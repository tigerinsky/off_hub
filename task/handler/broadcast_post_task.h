#ifndef __BROADCAST_POST_TASK_H_
#define __BROADCAST_POST_TASK_H_

#include <inttypes.h> 
#include <vector>
#include <string>
#include "base_task.h"

namespace tis {

class BroadcastPostTask : public BaseTask {
public:
    BroadcastPostTask() : BaseTask() {}
    virtual ~BroadcastPostTask() {}
    TaskType get_type() const { return BROADCAST_POST; }
    bool init(const void* request);
    int execute(thread_context_t* thread_context);

private:
    int __get_follower(thread_context_t* context);
    int __redis_update(thread_context_t* context);
    int __new_tweet_notify();

    int32_t _uid;
    int64_t _tid;
    std::vector<int32_t> _follower_list;

};

}

#endif  // __TASK_H_
