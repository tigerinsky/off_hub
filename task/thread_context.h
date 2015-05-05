#ifndef __THREAD_CONTEXT_H_
#define __THREAD_CONTEXT_H_

#include "mysql_proxy.h"
#include "redis_proxy.h"
#include "../proto/follower.pb.h"
#include "../proto/tweet_id.pb.h"

namespace tis {

class TaskManager;

typedef struct mysql_proxy_t {
    MysqlProxy* proxy; 
    mysql_stmt_t get_follower_st;
    Follower follower;
    mysql_stmt_t write_tweet_offline_st;
    mysql_stmt_t get_user_recent_tweet_st;
    TweetID tweet_id; 

    mysql_proxy_t() {
        proxy = NULL;
    }
} mysql_proxy_t;

typedef struct thread_context_t {
    int fail_num;
    TaskManager* task_manager;
    RedisProxy* redis_proxy;
    RedisProxy* cache_redis_proxy;
    mysql_proxy_t mysql;

    thread_context_t() {
        fail_num = 0;
        task_manager = NULL;
        redis_proxy = NULL; 
        cache_redis_proxy = NULL;
    }

    ~thread_context_t() {
        if (redis_proxy) delete redis_proxy; 
        if (mysql.proxy) {
            mysql.proxy->free_result(&(mysql.get_follower_st));
            mysql.proxy->free_prepare(&(mysql.get_follower_st)); 
            mysql.proxy->free_result(&(mysql.write_tweet_offline_st));
            mysql.proxy->free_prepare(&(mysql.write_tweet_offline_st)); 
            mysql.proxy->free_result(&(mysql.get_user_recent_tweet_st));
            mysql.proxy->free_prepare(&(mysql.get_user_recent_tweet_st)); 
            mysql.proxy->close();
            delete mysql.proxy;
        } 
    }
} thread_context_t;

}

#endif // __THREAD_CONTEXT_H_
