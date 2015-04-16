
#include "glog/logging.h"

#include "../../util/timer.h"
#include "../../flag.h"
#include "../../interface/post_service_types.h"
#include "../../util/utils.h"
#include "../thread_context.h"
#include "update_offline_task.h"

namespace tis {

bool UpdateOfflineTask::init(const PostServiceRequest* request){
    _online_tid = request->tid;
    _uid = request->uid;
    _uname = "";
    _title = request->title.c_str();
    _content = request->content.c_str();
    _img = request->img.c_str();
    _industry = request->industry;
    _ctime = request->ctime;
    _is_essence = request->is_essence;

    return true;
}

int UpdateOfflineTask::execute(thread_context_t* thread_context){
    int ret = -1;
    Timer timer;

    ret = __update_offline_tweet(thread_context);
    if (ret) {
        LOG(ERROR) << "update offline task: update offline tweet error, ret[" 
            << ret << "]";
        return 1;
    }
    time_t update_time = timer.elapse();

    LOG(INFO) << "update offline task: executed. tid=" << _online_tid
        << " update_time=" << update_time;
    return 0;
}

int UpdateOfflineTask::__update_offline_tweet(thread_context_t* context){
    int ret = -1;

    // 1. get user name from mysql
    snprintf(_redis_key_buff, 1023, "user_%d", _uid);
    (void)context->cache_redis_proxy->hget(_redis_key_buff, "sname", _uname);

    // 2. write offline tweet mysql
    MysqlProxy* mysql_proxy = context->mysql.proxy;
    mysql_stmt_t* write_tweet_offline_st = &(context->mysql.write_tweet_offline_st);

    ret = mysql_proxy->execute(write_tweet_offline_st,
                                _online_tid,
                                _uid,
                                _uname.c_str(), //code_convert(_uname, "utf-8", "gb2312").c_str(),
                                _title.c_str(), //code_convert(_title, "utf-8", "gb2312").c_str(),
                                _content.c_str(), //code_convert(_content, "utf-8", "gb2312").c_str(),
                                _img.c_str(), //code_convert(_img, "utf-8", "gb2312").c_str(),
                                _industry,
                                _ctime,
                                0,
                                0,
                                0,
                                _is_essence,
                                0,
                                0);
    if (MysqlProxy::MYSQL_QUERY_OK != ret) {
        LOG(ERROR) << "update offline task: mysql write tweet offline failed, "
            << "tid[" << _online_tid << "] uid[" << _uid << "] ret[" << ret << "]";
        return 2;
    }

    return 0;
}

}
