#ifndef  __SERVICE_H_
#define  __SERVICE_H_

#include "interface/PostService.h"

namespace tis {

class TaskManager;

class PostServiceImpl : virtual public PostServiceIf {

public:
    static const int CREATE_BROADCAST_TASK_ERR = 1;
    static const int SUBMIT_TASK_ERR = 2;
    static const int INIT_TASK_ERR = 3;
    static const int CREATE_HANDLEAT_TASK_ERR = 4;
    static const int CREATE_TWEETOFFLINE_TASK_ERR = 5;

public:
    PostServiceImpl() : _task_manager(NULL) {}
    virtual ~PostServiceImpl() {}

public:
    void set_task_manager(TaskManager* m) { _task_manager = m; }
    void SendNewPost(PostServiceResponse& response, 
                     const PostServiceRequest& request);
    void SendNewEvent(const EventServiceRequest& request);

private:
    TaskManager* _task_manager;
};

//以后的service实现类的声明都放这

}

#endif  //__SERVICE_H_
