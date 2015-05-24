#include "set_push_tag_task.h"
#include "../../interface/system_message_types.h"
#include "glog/logging.h"
#include "../thread_context.h"
#include "../../flag.h"
#include "../../dclient/ms_client.h"
#include "../../interface/post_service_types.h"

namespace tis {
bool SetPushTagTask::init(const void* r) {
    const * request = static_cast<const SetPushTagRequest*>(r);
    _uid = request->uid;
    _xg_device_token = request->xg_device_token;
    _op = request->op;
    _tag_list = request->tag_list;

    return true;
}

int SetMsgDeleteTask::execute(thread_context_t* context) {

    OpTagRequest request;

    request.uid = _uid;
    request.xg_device_token = _xg_device_token;
    request.op = _op;
    request.tag_list = _tag_list;

    MsClient *client = context->ms_client;
    int ret = client->optag(request);

    return ret;
}


}//namesapce
