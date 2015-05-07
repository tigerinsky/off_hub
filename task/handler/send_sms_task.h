#ifndef __SEND_SMS_TASK_H_
#define __SEND_SMS_TASK_H_

#include <inttypes.h>
#include <string>
#include "base_task.h"

using std::string;

namespace tis {

class SendSmsTask : public BaseTask {
public:
    SendSmsTask() : BaseTask() {}
    virtual ~SendSmsTask() {}
    TaskType get_type() const {return SEND_SMS;}
    bool init(const void* request);
    int execute(thread_context_t* thread_context);

private:
    string _mobile;
    string _content;
    int _send_time;
};

}

#endif
