#ifndef __SET_MSG_READ_TASK_H_
#define __SET_MSG_READ_TASK_H_

#include <inttypes.h>
#include <string>
#include "base_task.h"

using std::string;

namespace tis {

class SetMsgReadTask: public BaseTask {
public:
    SetMsgReadTask() : BaseTask() {}
    virtual ~SetMsgReadTask() {}
    TaskType get_type() const {return SET_MSG_READ;}
    bool init(const void* request);
    int execute(thread_context_t* thread_context);

private:
    int32_t _msg_id;
};

}

#endif
