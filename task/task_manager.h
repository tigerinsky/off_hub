#ifndef __TASK_MANAGER_H_
#define __TASK_MANAGER_H_

#include <inttypes.h>
#include <pthread.h>
#include <queue>
#include <vector>
#include "handler/base_task.h"

namespace tis {

struct thread_context_t;

class TaskCmp {
public:
    bool operator()(BaseTask* first, BaseTask* second){
        return first->get_priority() > second->get_priority();
    }
};

class TaskManager{
public:
    static const uint32_t kDefaultMaxQueueSize = 100000;
public:
    TaskManager();
    virtual ~TaskManager();
public:
    bool init();
    BaseTask* fetch_task();
    bool add_task(BaseTask* task);
    void stop();
public:
    uint32_t get_max_queue_size() { return _max_queue_size; }
    void set_max_queue_size(uint32_t n) { _max_queue_size = n; }
    bool is_stop() { return _stop; }
private:
    pthread_mutex_t* _mutex;
    std::priority_queue<BaseTask*, std::vector<BaseTask*>, TaskCmp> _queue;
    uint32_t _max_queue_size;
    int32_t _thread_num;
    thread_context_t** _thread_context;
    pthread_t* _worker_thread;
    bool _stop;
};

}

#endif // __TASK_MANAGER_H_
