#include "send_sys_msg_task.h"
#include "../../interface/system_message_types.h"
#include "glog/logging.h"
#include "../thread_context.h"
#include "../../flag.h"
#include "../../dclient/ms_client.h"
#include "../../interface/post_service_types.h"

namespace tis {
bool SendSysMsgTask::init(const void* r) {
    const SysMsgRequest* request = static_cast<const SysMsgRequest*>(r);
    _from_uid = request->from_uid;
    _action_type = request->action_type;
    _to_uid = request->to_uid;
    _content_id = request->content_id;

    return true;
}

int SendSysMsgTask::execute(thread_context_t* context) {
    SystemMessage request;
    request.from_uid = _from_uid;
    request.action_type = ActionType::type(_action_type);
    request.to_uid = _to_uid;
    request.content_id = _content_id;

    MsClient *client = context->ms_client;
    LOG(INFO) << "send sys msg from_uid[" << _from_uid << "] action_type[" << ActionType::type(_action_type) << "]";
    client->send_system_msg(request);
}


}//namesapce
