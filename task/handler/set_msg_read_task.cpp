#include "set_msg_read_task.h"
#include "../../interface/system_message_types.h"
#include "glog/logging.h"
#include "../thread_context.h"
#include "../../flag.h"
#include "../../dclient/ms_client.h"
#include "../../interface/post_service_types.h"

namespace tis {
bool SetMsgReadTask::init(const void* r) {
    const SetMsgReadRequest* request = static_cast<const SetMsgReadRequest*>(r);
    _msg_id = request->msg_id;

    return true;
}

int SetMsgReadTask::execute(thread_context_t* context) {

    MsClient *client = context->ms_client;
    int ret = client->set_read(_msg_id);

    return ret;
}


}//namesapce
