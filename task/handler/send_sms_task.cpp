#include "send_sms_task.h"
#include "../../interface/sms_types.h"
#include "glog/logging.h"
#include "../thread_context.h"
#include "../../flag.h"
#include "../../dclient/sms_client.h"
#include "../../interface/post_service_types.h"

namespace tis {
bool SendSmsTask::init(const void* r) {
    const SmsRequest* request = static_cast<const SmsRequest*>(r);
    _mobile = request->mobile;
    _content = request->content;
    _send_time = request->send_time;
    return true;
}

int SendSmsTask::execute(thread_context_t* context) {
    SendSMSRequest request;
    request.mobile = _mobile;
    request.content = _content;
    request.send_time = _send_time;

    SmsClient *client = context->sms_client;

    int retry = 2;
    for (int i = 0; i < retry; i++) {
        int result = client->send_sms(request);
        if (result == 0) {
            LOG(INFO) << "send sms success, mobile[" << _mobile <<"] retry[" << i << "]";
            return 0;
        }

        LOG(INFO) << "send sms  a failed, mobile[" << _mobile <<"] retry[" << i << "]";
    }

    LOG(INFO) << "send sms finally failed, mobile[" << _mobile <<"]"; 
    return 1;
}


}//namesapce
