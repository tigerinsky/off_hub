#ifndef  __FLAG_H_ 
#define  __FLAG_H_

#include "google/gflags.h"

DECLARE_int32(port);
DECLARE_int32(server_thread_num);
DECLARE_int32(task_thread_num);
DECLARE_string(redis_host);
DECLARE_int32(redis_port);
DECLARE_string(cache_redis_host);
DECLARE_int32(cache_redis_port);
DECLARE_int32(thread_sleep_time);
DECLARE_string(ms_host);
DECLARE_int32(ms_port);
DECLARE_string(mysql_host);
DECLARE_int32(mysql_port);
DECLARE_string(mysql_db);
DECLARE_string(mysql_user);
DECLARE_string(mysql_pwd);
DECLARE_int32(redis_queue_size);
DECLARE_string(sms_host);
DECLARE_int32(sms_port);
DECLARE_string(msg_queue_prefix);

#endif
