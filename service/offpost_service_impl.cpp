/**
 * @file offpost_service.cpp
 * @author wangxuebing
 * @date 2015/01/28 00:24:35
 * @brief 
 *  
 **/

#include "service.h"
#include "glog/logging.h"
#include "../task/task_manager.h"
#include "../task/task_factory.h"
#include "../task/handler/broadcast_post_task.h"

namespace tis {

void PostServiceImpl::SendNewPost(PostServiceResponse& response,
                                  const PostServiceRequest& request){
    BaseTask* task = NULL;
    if ((task = TaskFactory::create_task(BROADCAST_POST, 5))) {
        if (!task->init(&request)) {
            response.err_no = INIT_TASK_ERR;
            response.err_msg = "init broadcast post task err";
            return ; 
        }
        if (!_task_manager->add_task(task)) {
            response.err_no = SUBMIT_TASK_ERR;
            response.err_msg = "submit broadcast task err";
        } else {
            response.err_no = 0;
        }
    } else {
        response.err_no = CREATE_BROADCAST_TASK_ERR;
        response.err_msg = "create broadcast post task err";
    }

    if (task = TaskFactory::create_task(UPDATE_OFFLINE, 1)) {
        if (!task->init(&request)) {
            response.err_no = INIT_TASK_ERR;
            response.err_msg = "init tweet offline task err";
            return ;
        }
        
        if (!_task_manager->add_task(task)) {
            response.err_no = SUBMIT_TASK_ERR;
            response.err_msg = "submit tweet offline task err";
        } else {
            response.err_no = 0;
        }
    } else {
        response.err_no = CREATE_TWEETOFFLINE_TASK_ERR;
        response.err_msg = "create tweet offline task err";
    }
}

void PostServiceImpl::SendNewEvent(const EventServiceRequest& request){
    LOG(INFO) << "uesr_statistics: " << "event["<<request.type<<"] tid["<<request.tid<<"]";
}

}




/* vim: set expandtab ts=4 sw=4 sts=4 tw=100: */
