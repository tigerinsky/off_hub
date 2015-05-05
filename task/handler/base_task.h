#ifndef __BASE_TASK_H_
#define __BASE_TASK_H_

namespace tis {

class PostServiceRequest;
struct thread_context_t;

enum TaskType {
    BROADCAST_POST,
    UPDATE_OFFLINE,
    NEW_FOLLOW_TWEET_PUSH,
};

class BaseTask{
public:
    static const int DEFAULT_PRIORITY = 0;

public:
    BaseTask() : _priority(DEFAULT_PRIORITY){}
    virtual ~BaseTask() {}
    virtual bool init(const void* request) = 0;
    virtual TaskType get_type() const = 0;
    virtual int execute(thread_context_t* thread_context) = 0;

    int get_priority() { return _priority; }
    void set_priority(int p) { _priority = p; }

protected:
    int _priority;
};

}

#endif  // __TASK_H_
