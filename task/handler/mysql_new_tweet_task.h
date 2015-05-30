/**
 * This file is the task of creating tweet to mysql.
 */

#ifndef __MYSQL_NEW_TWEET_TASK_H_
#define __MYSQL_NEW_TWEET_TASK_H_

#include <inttypes.h>
#include <string>
#include <vector>
#include "base_task.h"

namespace tis {

class TweetStruct;
class ResourceStruct;

class MysqlNewTweetTask : public BaseTask {
public:
    MysqlNewTweetTask() : BaseTask(), _tweet_str(NULL) {}
    virtual ~MysqlNewTweetTask();
    TaskType get_type() const { return MYSQL_NEW_TWEET; }
    bool init(const void* r);
    int execute(thread_context_t* thread_context);

private:
    int __mysql_update(thread_context_t* context);

    int64_t _tid;
    TweetStruct* _tweet_str;
};

}

#endif // __MYSQL_NEW_TWEET_TASK_H_
