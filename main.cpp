/**
 * @file main.cpp
 * @author wangxuebing
 * @date 2015/01/25 17:29:16
 * @brief 
 *  
 **/

#include <signal.h>
#include "flag.h"
#include "glog/logging.h"
#include "service/service.h"
#include "server/server.h"
#include "mysql_proxy.h"

DEFINE_int32(port, 9027, "server port");
DEFINE_int32(server_thread_num, 2, "non blocking server handler thread num");
DEFINE_int32(task_thread_num, 5, "task handler thread num");
DEFINE_string(redis_host, "127.0.0.1", "redis host");
DEFINE_int32(redis_port, 8888, "redis port");
DEFINE_string(cache_redis_host, "127.0.0.1", "cache redis host");
DEFINE_int32(cache_redis_port, 8889, "cache redis port");
DEFINE_int32(thread_sleep_time, 10000, "task handler thread sleep time");
DEFINE_string(ms_host, "127.0.0.1", "message server host");
DEFINE_int32(ms_port, 8999, "message server port");
DEFINE_string(mysql_host, "127.0.0.1", "mysql server host");
DEFINE_int32(mysql_port, 3306, "mysql server port");
DEFINE_string(mysql_db, "test", "mysql db");
DEFINE_string(mysql_user, "root", "mysql user");
DEFINE_string(mysql_pwd, "", "mysql password");
DEFINE_int32(redis_queue_size, 10000, "redis max queue size");
DEFINE_string(sms_host, "127.0.0.1", "sms server host");
DEFINE_int32(sms_port, 9898, "sms server port");


tis::PostServer g_server;

void handle_signal(int sig) {
    g_server.stop();    
}  

int main(int argc, char** argv){
    ::google::ParseCommandLineFlags(&argc, &argv, true);
    ::google::InitGoogleLogging(argv[0]);
    ::google::SetUsageMessage("offpost server");
    signal(SIGINT, handle_signal);
    signal(SIGQUIT, handle_signal);
    signal(SIGPIPE, SIG_IGN);
    tis::MysqlProxy::library_init(); 

    return g_server.run();
}

/* vim: set expandtab ts=4 sw=4 sts=4 tw=100: */
