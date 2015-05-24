#include "mis_push_task.h"
#include "../../interface/system_message_types.h"
#include "glog/logging.h"
#include "../thread_context.h"
#include "../../flag.h"
#include "../../dclient/ms_client.h"
#include "../../interface/post_service_types.h"

namespace tis {
bool MisPushTask::init(const void* r) {
    const MisPushRequest* request = static_cast<const MisPushRequest*>(r);
    _title = request->title;
    _content = request->content;
    _type = request->type;
    _tid = request->tid;
    _url = request->url;
    _send_time = request->send_time;
    _push_task_id = request->push_task_id;
    _device_type = request->device_type;
    _city = request->city;
    _school = request->school;
    _ukind_verify = request->ukind_verify;
    _is_broadcast = request->is_broadcast;

    return true;
}

int MisPushTask::execute(thread_context_t* context) {

    MsClient *client = context->ms_client;

    MisRequest request;
    request.title = _title;
    request.content = _content;
    request.type = _type;
    request.tid = _tid;
    request.url = _url;
    request.send_time = _send_time;
    request.push_task_id = _push_task_id;
    request.device_type = _device_type;
    request.city = _city;
    request.school = _school;
    request.ukind_verify = _ukind_verify;
    request.is_broadcast = _is_broadcast;
    client->mis_notify(request);

    return 0;
}


}//namesapce
