
#include "new_follow_tweet_push_task.h"
#include <time.h>
#include <vector>
#include <string>
#include <algorithm>
#include "glog/logging.h"
#include "../../interface/post_service_types.h"
#include "mysql_proxy.h"
#include "../thread_context.h"
#include "../../flag.h"

namespace tis {

bool NewFollowTweetPushTask::init(const void* e) {
    const FollowEvent* event = static_cast<const FollowEvent*>(e);
    _uid = event->uid;
    _follower_uid = event->follower_uid;
    return true;
}

int NewFollowTweetPushTask::execute(thread_context_t* context) {
    static const int INTERVAL = 3600 * 24 * 7;
    int ret = -1;
    std::vector<std::string> recent_push_list;
    std::vector<std::string> tid_str_queue;
    std::vector<int32_t> tid_queue;
    mysql_stmt_t* get_tid_st = &(context->mysql.get_user_recent_tweet_st);
    TweetID* tweet_id = &(context->mysql.tweet_id);
    RedisProxy* redis_proxy = context->redis_proxy;
    MysqlProxy* mysql_proxy = context->mysql.proxy;


    snprintf(_key_buff, MAX_KEY_SIZE, "%d_msg_queue", _follower_uid);
    ret = redis_proxy->lrange(_key_buff, 0, -1, &tid_str_queue);
    if (RedisProxy::REDIS_LRANGE_OK != ret) {
        return 1; 
    }
    std::vector<std::string>::iterator ite;
    for (ite = tid_str_queue.begin(); ite != tid_str_queue.end(); ++ite) {
        tid_queue.push_back(strtol(ite->c_str(), NULL, 10));
    }
    ret = mysql_proxy->execute(get_tid_st, _uid, time(NULL) - INTERVAL);
    if (MysqlProxy::MYSQL_QUERY_OK != ret) {
        LOG(ERROR)<<"mysql error: ["
            <<mysql_proxy->get_err_msg()<<"] ["
            <<mysql_proxy->get_prepare_err_msg(get_tid_st) << "]";
        return 1; 
    }
    while (true) {
        bool is_finish = false;
        switch(mysql_proxy->next(get_tid_st)) {
        case MysqlProxy::MYSQL_NEXT_ERR: 
            mysql_proxy->free_result(get_tid_st);
            return 2;
        case MysqlProxy::MYSQL_NEXT_END:
            is_finish = true;
            break;
        case MysqlProxy::MYSQL_NEXT_OK:
            ret = mysql_proxy->get_proto(get_tid_st, tweet_id); 
            if (MysqlProxy::MYSQL_GET_PROTO_OK != ret) {
                mysql_proxy->free_result(get_tid_st);
                return 3; 
            }
            if (tid_queue.end() == std::find(tid_queue.begin(), tid_queue.end(), tweet_id->tid())) {
                snprintf(_value_buff, MAX_VALUE_SIZE, "%d|%s", tweet_id->tid(), tweet_id->industry().c_str());
                recent_push_list.push_back(_value_buff);
            }
            tweet_id->Clear();
            break;
        }
        if (is_finish) break; 
    }
    uint64_t list_len = 0;
    for (ite = recent_push_list.begin(); ite != recent_push_list.end(); ++ite) {
        ret = redis_proxy->lpush(_key_buff, ite->c_str(), ite->size(), &list_len); 
        if (RedisProxy::REDIS_LPUSH_OK != ret) {
            LOG(WARNING) << "new_follow_tweet_push_task: lpush queue error"; 
        }
    }
    if (FLAGS_redis_queue_size < list_len) {
        ret = redis_proxy->ltrim(_key_buff, 0, FLAGS_redis_queue_size); 
        if (RedisProxy::REDIS_LTRIM_OK != ret) {
            LOG(WARNING) << "new_follow_tweet_push_task ltrim error"; 
        }
    }
    LOG(INFO) << "new_follow_tweet_push_task: all done uid["<<_uid<<"] follower["<<_follower_uid<<"]";

    return 0;
}



}
