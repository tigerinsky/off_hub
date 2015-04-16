#ifndef __TASK_FACTORY_H_
#define __TASK_FACTORY_H_

#include "handler/base_task.h"
namespace tis {

class BaseTask;

//TODO 引入内存管理后可以搞成单键
class TaskFactory {
private:
    TaskFactory() {}
    virtual ~TaskFactory() {}
public:
    static BaseTask* create_task(TaskType type, int priority);
    static void destroy_task(BaseTask* t);
};

}

#endif // __TASK_FACTORY_H_
