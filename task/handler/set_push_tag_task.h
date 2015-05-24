#ifndef __SET_PUSH_TAG_TASK_H_
#define __SET_PUSH_TAG_TASK_H_

#include <inttypes.h>
#include <string>
#include "base_task.h"

using std::string;

namespace tis {

class SetPushTagTask: public BaseTask {
public:
    SetPushTagTask() : BaseTask() {}
    virtual ~SetPushTagTask() {}
    TaskType get_type() const {return SET_PUSH_TAG;}
    bool init(const void* request);
    int execute(thread_context_t* thread_context);

private:
    int32_t _uid;
    string _xg_device_token;
    int32_t _op;
    vector<string> _tag_list;
};

}

#endif
