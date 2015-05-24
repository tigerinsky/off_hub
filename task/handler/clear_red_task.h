#ifndef __CLEAR_RED_TASK_
#define __CLEAR_RED_TASK_

#include <inttypes.h>
#include <string>
#include "base_task.h"

using std::string;

namespace tis {

class ClearRedTask: public BaseTask {
public:
    ClearRedTask() : BaseTask() {}
    virtual ~ClearRedTask() {}
    TaskType get_type() const {return CLEAR_RED;}
    bool init(const void* request);
    int execute(thread_context_t* thread_context);

private:
    int32_t _uid;
    int32_t _mType;
    int32_t _from_uid;
};

}

#endif
