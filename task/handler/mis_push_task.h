#ifndef __MIS_PUSH_TASK_H_
#define __MIS_PUSH_TASK_H_

#include <inttypes.h>
#include <string>
#include "base_task.h"

using std::string;

namespace tis {

class MisPushTask: public BaseTask {
public:
    MisPushTask() : BaseTask() {}
    virtual ~MisPushTask() {}
    TaskType get_type() const {return MIS_PUSH;}
    bool init(const void* request);
    int execute(thread_context_t* thread_context);

private:
    string _title;
    string _content;
    int32_t _type;
    int64_t _tid;
    string _url;
    int32_t _send_time;
    int32_t _push_task_id;
    int32_t _device_type;
    string _city;
    string _school;
    string _ukind_verify;
    int32_t _is_broadcast;
};

}

#endif
