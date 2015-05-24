#include "clear_red_task.h"
#include "../../interface/system_message_types.h"
#include "glog/logging.h"
#include "../thread_context.h"
#include "../../flag.h"
#include "../../dclient/ms_client.h"
#include "../../interface/post_service_types.h"

namespace tis {
bool ClearRedTask::init(const void* r) {
    const ClearRedRequest* request = static_cast<const ClearRedRequest*>(r);
    _uid = request->uid;
    _mType = request->mType;
    _from_uid = request->from_uid;

    return true;
}

int ClearRedTask::execute(thread_context_t* context) {

    MsClient *client = context->ms_client;
    int ret = client->clear_red_by_uid(_uid, _mType, 0, _from_uid);

    return ret;
}


}//namesapce
