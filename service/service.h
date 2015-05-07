#ifndef  __SERVICE_H_
#define  __SERVICE_H_

#include "interface/PostService.h"

namespace tis {

class TaskManager;

class PostServiceImpl : virtual public PostServiceIf {

public:
    PostServiceImpl() : _task_manager(NULL) {}
    virtual ~PostServiceImpl() {}

public:
    void set_task_manager(TaskManager* m) { _task_manager = m; }
    void SendNewPost(const PostServiceRequest& request);
    void SendNewEvent(const EventServiceRequest& request);
    void FollowNewEvent(const FollowEvent& event);
    void SendSmsEvent(const SmsRequest& request);

private:
    TaskManager* _task_manager;
};

//以后的service实现类的声明都放这

}

#endif  //__SERVICE_H_
