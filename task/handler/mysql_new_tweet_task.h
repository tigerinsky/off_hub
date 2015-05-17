/**
 * This file is the task of creating tweet to mysql.
 */

#ifndef __MYSQL_NEW_TWEET_TASK_H_
#define __MYSQL_NEW_TWEET_TASK_H_

#include <inttypes.h>
#include <string>
#include "base_task.h"

namespace tis {

class MysqlNewTweetTask : public BaseTask {
public:
    MysqlNewTweetTask() : BaseTask() {}
    virtual ~MysqlNewTweetTask() {}
    TaskType get_type() const { return MYSQL_NEW_TWEET; }
    bool init(const void* r);
    int execute(thread_context_t* thread_context);

private:
    int __mysql_update(thread_context_t* context);

    uint64_t _tid;
    int32_t _uid;
    int _type;
    std::string _f_catalog;
    std::string _content;
    int32_t _ctime;
    int _is_del;
    int32_t _dtime;
    std::string _img;
    std::string _s_catalog;
    std::string _tags;
};

}

#endif // __MYSQL_NEW_TWEET_TASK_H_
