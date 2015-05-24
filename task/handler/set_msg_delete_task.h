#ifndef __SET_MSG_DELETE_TASK_H_
#define __SET_MSG_DELETE_TASK_H_

#include <inttypes.h>
#include <string>
#include "base_task.h"

using std::string;

namespace tis {

class SetMsgDeleteTask: public BaseTask {
public:
    SetMsgDeleteTask() : BaseTask() {}
    virtual ~SetMsgDeleteTask() {}
    TaskType get_type() const {return SET_MSG_DELETE;}
    bool init(const void* request);
    int execute(thread_context_t* thread_context);

private:
    int32_t _msg_id;
};

}

#endif
