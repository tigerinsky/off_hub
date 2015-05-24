#ifndef __SEND_SYS_MSG_TASK_H_
#define __SEND_SYS_MSG_TASK_H_

#include <inttypes.h>
#include <string>
#include "base_task.h"

using std::string;

namespace tis {

class SendSysMsgTask: public BaseTask {
public:
    SendSmsTask() : BaseTask() {}
    virtual ~SendSmsTask() {}
    TaskType get_type() const {return SEND_SYS_MSG;}
    bool init(const void* request);
    int execute(thread_context_t* thread_context);

private:
    int32_t _from_uid;
    SysMsgType::type _mType;
    vector<int32_t> _to_uid;
    int64_t _content_id;
};

}

#endif
