#ifndef __NEW_FOLLOW_TWEET_PUSH_TASK_H_
#define __NEW_FOLLOW_TWEET_PUSH_TASK_H_

#include <inttypes.h>
#include "base_task.h"

namespace tis {

class NewFollowTweetPushTask : public BaseTask {
public:
    static const int MAX_KEY_SIZE = 128;
    static const int MAX_VALUE_SIZE = 128;
public:
    NewFollowTweetPushTask() : BaseTask() {}
    virtual ~NewFollowTweetPushTask() {}
    TaskType get_type() const { return NEW_FOLLOW_TWEET_PUSH; }
    bool init(const void* request);
    int execute(thread_context_t* thread_context);

private:
    int32_t _uid;
    int32_t _follower_uid;
    int32_t _timestamp;
    char _key_buff[MAX_KEY_SIZE];
    char _value_buff[MAX_VALUE_SIZE];
};


}


#endif
