#ifndef __UPDATE_OFFLINE_TASK_H_
#define __UPDATE_OFFLINE_TASK_H_

#include "base_task.h"

namespace tis {

class UpdateOfflineTask : public BaseTask {
public:
    UpdateOfflineTask() : BaseTask () {}
    virtual ~UpdateOfflineTask() {}
    TaskType get_type() const { return UPDATE_OFFLINE; }
    bool init(const PostServiceRequest* request);
    int execute(thread_context_t* thread_context);
private:
    int __update_offline_tweet(thread_context_t* context);

    char _redis_key_buff[1024];

    int32_t _online_tid;
    int32_t _uid;
    std::string _uname;
    std::string _title;
    std::string _content;
    std::string _img;
    int32_t _industry;
    int64_t _ctime;
    int32_t _is_essence;
};

}

#endif // _UPDATE_OFFLINE_TASK_H_
