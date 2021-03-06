#include <stdlib.h>
#include "task_manager.h"
#include "glog/logging.h"
#include "thread_context.h"
#include "task_factory.h"
#include "../flag.h"

namespace tis {

TaskManager::TaskManager(){
    _max_queue_size = kDefaultMaxQueueSize;
    _mutex = NULL;
    _thread_num = 0;
    _thread_context = NULL;
    _worker_thread = NULL;
    _stop = true;
}

TaskManager::~TaskManager(){
    if (_mutex) (void)pthread_mutex_destroy(_mutex);
    for (int i = 0; i < _thread_num; ++i) {
        if (_thread_context[i]) delete _thread_context[i]; 
    }
    if (_worker_thread) delete[] _worker_thread;
}

static int _init_thread_context(TaskManager* m, thread_context_t** context) {
    int ret = -1;
    MysqlProxy* proxy = NULL;
    thread_context_t* c = new(std::nothrow) thread_context_t;
    if (!c) {
        ret = 1;  
    }
    c->task_manager = m;
    if (!(c->redis_proxy = new(std::nothrow) RedisProxy)) {
        ret = 3; 
        goto fail;
    }
    if (c->redis_proxy->connect(FLAGS_redis_host.c_str(), FLAGS_redis_port)) {
        ret = 2;
        goto fail;
    }
    if (!(c->cache_redis_proxy = new(std::nothrow) RedisProxy)) {
        ret = 8; 
        goto fail;
    }
    if (c->cache_redis_proxy->connect(FLAGS_cache_redis_host.c_str(), FLAGS_cache_redis_port)) {
        ret = 9;
        goto fail;
    }
    if (!(c->mysql.proxy = new(std::nothrow) MysqlProxy)) {
        ret = 4; 
        goto fail;
    }
    proxy = c->mysql.proxy;
    ret = proxy->connect(FLAGS_mysql_host.c_str(), 
                         FLAGS_mysql_port,
                         FLAGS_mysql_user.c_str(),
                         FLAGS_mysql_pwd.c_str());  
    if (MysqlProxy::MYSQL_CONNECT_OK != ret) {
        LOG(INFO) << FLAGS_mysql_host.c_str() << FLAGS_mysql_port << FLAGS_mysql_user.c_str() << FLAGS_mysql_pwd.c_str();
        ret = 5; 
        goto fail;
    }
    ret = proxy->select_db(FLAGS_mysql_db.c_str());
    if (MysqlProxy::MYSQL_SELECT_DB_OK != ret) {
        ret = 6; 
        goto fail;
    }
    // small follower
    ret = proxy->prepare("select a_uid from ci_user_relation where b_uid = ? and a_follow_b != 0",
                         c->mysql.small_follower.GetDescriptor(),
                         &(c->mysql.get_small_follower_st),
                         MysqlProxy::PREPARE_INT32);
    if (MysqlProxy::MYSQL_PREPARE_OK != ret) {
        LOG(ERROR) << "prepare small_follower error, ret=" << ret;
        ret = 7;
        goto fail;
    }
    // big follower
    ret = proxy->prepare("select b_uid from ci_user_relation where a_uid = ? and b_follow_a != 0",
                        c->mysql.big_follower.GetDescriptor(),
                        &(c->mysql.get_big_follower_st),
                        MysqlProxy::PREPARE_INT32);
    if (MysqlProxy::MYSQL_PREPARE_OK != ret) {
        LOG(ERROR) << "prepare big_follower error, ret=" << ret;
        ret = 8;
        goto fail;
    }

    // insert online tweet
    ret = proxy->prepare("insert into ci_tweet (tid, uid, type, f_catalog, content,"
                        "ctime, is_del, dtime, s_catalog, tags, resource_id, img) "
                        "values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
                        NULL,
                        &(c->mysql.write_new_tweet_st),
                        MysqlProxy::PREPARE_INT64,      // tid
                        MysqlProxy::PREPARE_INT32,      // uid
                        MysqlProxy::PREPARE_INT32,      // type
                        MysqlProxy::PREPARE_STRING,     // f_catalog
                        MysqlProxy::PREPARE_STRING,     // content
                        MysqlProxy::PREPARE_INT32,      // ctime
                        MysqlProxy::PREPARE_INT32,      // is_del
                        MysqlProxy::PREPARE_INT32,      // dtime
                        MysqlProxy::PREPARE_STRING,     // s_catalog
                        MysqlProxy::PREPARE_STRING,     // tags
                        MysqlProxy::PREPARE_STRING,     // resource_id
                        MysqlProxy::PREPARE_STRING      // img
                        );
    if (MysqlProxy::MYSQL_PREPARE_OK != ret) {
        LOG(ERROR) << "prepare mysql_new_tweet error, ret=" << ret;
        ret = 9;
        goto fail;
    }

    // insert resource info
    ret = proxy->prepare("insert into ci_resource (rid, img, description) "
                        "values (?, ?, ?)",
                        NULL,
                        &(c->mysql.write_new_resource_st),
                        MysqlProxy::PREPARE_INT64,      // rid
                        MysqlProxy::PREPARE_STRING,     // img
                        MysqlProxy::PREPARE_STRING      // description
                        );
    if (MysqlProxy::MYSQL_PREPARE_OK != ret) {
        LOG(ERROR) << "prepare mysql_new_resource error, ret=" << ret;
        ret = 10;
        goto fail;
    }
    
    // user recent tweet
    ret = proxy->prepare("select tid from ci_tweet where uid=? and ctime > ? and is_del = 0 limit 5",//TODO industry->s_catalog just let sever start up, need to fix for requirements
                          c->mysql.tweet_id.GetDescriptor(),
                          &(c->mysql.get_user_recent_tweet_st),
                          MysqlProxy::PREPARE_INT64,
                          MysqlProxy::PREPARE_INT32);
    if (MysqlProxy::MYSQL_PREPARE_OK != ret) {
            ret = 12; 
            goto fail;
    }
    ret = proxy->set_charset("utf8mb4");
    if (MysqlProxy::MYSQL_SET_CHARSET_OK != ret) {
        ret = 11;
        goto fail;
    }

    c->sms_client = new SmsClient(FLAGS_sms_host.c_str(), FLAGS_sms_port);
    c->ms_client = new MsClient(FLAGS_ms_host.c_str(), FLAGS_ms_port);

    *context = c;
    return 0;
fail:
    if (c) delete c;
    return ret;
}

static void* _work_thread_main(void *arg) {
    int ret = -1;
    thread_context_t* context = static_cast<thread_context_t*>(arg);
    TaskManager* manager = context->task_manager;
    BaseTask* task = NULL;
    while (true) {
        task = manager->fetch_task(); 
        if (task) {
            ret = task->execute(context); 
            if (ret) {
                LOG(WARNING) << "execute task error, type["<<task->get_type()<<"]";
                context->fail_num++;
            }
            TaskFactory::destroy_task(task);
        } else {
            if (manager->is_stop()) {
                break; 
            } else {
                (void)usleep(FLAGS_thread_sleep_time); 
            }
        }
    }
    return NULL;
}

bool TaskManager::init(){
    int ret = -1;
    // 1. init lock
    if (!(_mutex = new(std::nothrow) pthread_mutex_t)) {
        LOG(ERROR) << "task manager: new pthread mutex erorr"; 
        return false;
    }
    if (pthread_mutex_init(_mutex, NULL)) {
        LOG(ERROR) << "task manager: init pthread mutex erorr"; 
        return false;
    }

    // 2. init thread context
    _thread_num = FLAGS_task_thread_num; 
    if (!(_thread_context = static_cast<thread_context_t**>(calloc(_thread_num, sizeof(thread_context_t*))))) {
        LOG(ERROR) << "task manager: new pthread context erorr, num["<<_thread_num<<"]"; 
        return false;
    }
    for (int i = 0; i < _thread_num; ++i) {
        ret = _init_thread_context(this, &(_thread_context[i]));
        if (ret) {
            LOG(ERROR) << "task manager: init thread context error, ret["<<ret<<"]"; 
            return false;
        }
    }
    
    // 3. init thread
    // TODO  move above to a new method
    _stop = false;
    if (!(_worker_thread = new(std::nothrow) pthread_t[_thread_num])) {
        LOG(ERROR) << "task manager: new pthread erorr, num["<<_thread_num<<"]"; 
        return false;
    }
    for (int i = 0; i < _thread_num; ++i){
        if (pthread_create(_worker_thread + i,
                           NULL,
                           _work_thread_main,
                           static_cast<void*>(_thread_context[i]))){
            LOG(ERROR) << "task manager: create  pthread erorr, i["<<i<<"]"; 
            return false;
        }
    }
    return true;
}

BaseTask* TaskManager::fetch_task(){
    BaseTask* task = NULL;
    (void)pthread_mutex_lock(_mutex);
    if (_queue.empty()) {
        task = NULL; 
    } else {
        task = _queue.top(); 
        _queue.pop();
    }
    (void)pthread_mutex_unlock(_mutex);
    return task;
}

bool TaskManager::add_task(BaseTask* task){
    if (!task || is_stop()) {
        return false; 
    }
    if (!_queue.size() >= _max_queue_size){
        LOG(WARNING)<< "task manager: Queue overflow.";
        return false;
    }
    (void)pthread_mutex_lock(_mutex);
    _queue.push(task);
    (void)pthread_mutex_unlock(_mutex);
    return true;
}

void TaskManager::stop() {
    _stop = true;
    for (int i = 0; i < _thread_num; ++i) {
        (void)pthread_join(_worker_thread[i], NULL); 
    }
}

}
