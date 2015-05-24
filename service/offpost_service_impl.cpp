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

void PostServiceImpl::SendNewPost(const PostServiceRequest& request){
    BaseTask* task = NULL;
    if ((task = TaskFactory::create_task(BROADCAST_POST, 5))) {
        if (!task->init(&request)) {
            LOG(ERROR) << "send new post:init broadcast post task err, tid[" << request.tid << "]";
            TaskFactory::destroy_task(task);
        } else {
            if (!_task_manager->add_task(task)) {
                LOG(ERROR) << "send new post: add broadcast post task err, tid[" << request.tid << "]";
                TaskFactory::destroy_task(task);
            }
        }
    } else {
        LOG(ERROR) << "send new post: create broadcast post task err, tid["<<request.tid<<"]";
    }
    if ((task = TaskFactory::create_task(MYSQL_NEW_TWEET, 4))) {
        if (!task->init(&request)) {
            LOG(ERROR) << "send new post: init mysql new tweet task err, tid[" << request.tid << "]";
            TaskFactory::destroy_task(task);
        } else {
            if (!_task_manager->add_task(task)) {
                LOG(ERROR) << "send new post: add mysql new tweet task err, tid[" << request.tid << "]";
                TaskFactory::destroy_task(task);
            }
        }
    }
/*  TODO: offline will coding later.
    if (task = TaskFactory::create_task(UPDATE_OFFLINE, 1)) {
        if (!task->init(&request)) {
            LOG(ERROR) << "send new post:init offline update task err, tid[" << request.tid << "]";
            TaskFactory::destroy_task(task);
        } else {
            if (!_task_manager->add_task(task)) {
                LOG(ERROR) << "send new post: add offline update task err, tid[" << request.tid << "]";
                TaskFactory::destroy_task(task);
            }
        }
    } else {
        LOG(ERROR) << "send new post: create offline update task err, tid["<<request.tid<<"]";
    }*/
}

void PostServiceImpl::SendNewEvent(const EventServiceRequest& request){
    LOG(INFO) << "uesr_statistics: " << "event["<<request.type<<"] tid["<<request.tid<<"]";
}

void PostServiceImpl::FollowNewEvent(const FollowEvent& event) {
    BaseTask *task = NULL;
    if ((task = TaskFactory::create_task(NEW_FOLLOW_TWEET_PUSH, 6))) {
        if (!task->init(&event)) {
            TaskFactory::destroy_task(task);
            LOG(ERROR) << "Follow event: init follow new event task error, uid[" << event.uid << "] follower[" << event.follower_uid << "]";
        } else {
            if (!_task_manager->add_task(task)) {
                TaskFactory::destroy_task(task);
                LOG(ERROR) << "Follow event: add follow new event task error, uid[" << event.uid << "] follower[" << event.follower_uid << "]";
            }
        }
    } else {
        LOG(ERROR) << "Follow event: create follow new event task error, uid["<<event.uid<<"] follower["<<event.follower_uid<<"]";
    }
}

void PostServiceImpl::SendSmsEvent(const SmsRequest& request) {
    BaseTask *task = NULL;
    if ((task = TaskFactory::create_task(SEND_SMS, 7))) {
        if (!task->init(&request)) {
            TaskFactory::destroy_task(task);
            LOG(ERROR) << "Send sms event: init error, mobile[" << request.mobile << "] content[" << request.content << "]";
        } else {
            if (!_task_manager->add_task(task)) {
                TaskFactory::destroy_task(task);
                LOG(ERROR) << "Send sms event: add error, mobile[" << request.mobile << "] content[" << request.content << "]";
            }
        }
    } else {
        LOG(ERROR) << "Send sms event: create error, mobile[" << request.mobile << "] content[" << request.content << "]";
    }
}

void PostServiceImpl::SendSysMsgEvent(const SysMsgRequest& request) {
    BaseTask *task = NULL;
    if ((task = TaskFactory::create_task(SEND_SYS_MSG, 4))) {
        if (!task->init(&request)) {
            TaskFactory::destroy_task(task);
            LOG(ERROR) << "Send sys msg event: init error, from_uid[" << request.from_uid << "] action_type[" << request.action_type << "] to_uid[" << request.to_uid.at(0) << "] content_id[" << request.content_id << "]";
        } else {
            if (!_task_manager->add_task(task)) {
                TaskFactory::destroy_task(task);
                LOG(ERROR) << "Send sys msg event: add error, from_uid[" << request.from_uid << "] action_type[" << request.action_type << "] to_uid[" << request.to_uid.at(0) << "] content_id[" << request.content_id << "]";
            }
        }
    } else {
        LOG(ERROR) << "Send sys msg event: create error, from_uid[" << request.from_uid << "] action_type[" << request.action_type << "] to_uid[" << request.to_uid.at(0) << "] content_id[" << request.content_id << "]";
    }
}

void PostServiceImpl::SetSysMsgReadEvent(const SetMsgReadRequest& request) {
    BaseTask *task = NULL;
    if ((task = TaskFactory::create_task(SET_MSG_READ, 4))) {
        if (!task->init(&request)) {
            TaskFactory::destroy_task(task);
            LOG(ERROR) << "Set sys msg read event: init error, msg_id[" << request.msg_id << "]";
        } else {
            if (!_task_manager->add_task(task)) {
                TaskFactory::destroy_task(task);
                LOG(ERROR) << "Set sys msg read event: add error, msg_id[" << request.msg_id << "]";
            }
        }
    } else {
        LOG(ERROR) << "Set sys msg read event: create error, msg_id[" << request.msg_id << "]";
    }
}

void PostServiceImpl::SetSysMsgDeleteEvent(const SetMsgDelRequest& request) {
    BaseTask *task = NULL;
    if ((task = TaskFactory::create_task(SET_MSG_DELETE, 5))) {
        if (!task->init(&request)) {
            TaskFactory::destroy_task(task);
            LOG(ERROR) << "Set sys msg del event: init error, msg_id[" << request.msg_id << "]";
        } else {
            if (!_task_manager->add_task(task)) {
                TaskFactory::destroy_task(task);
                LOG(ERROR) << "Set sys msg del event: add error, msg_id[" << request.msg_id << "]";
            }
        }
    } else {
        LOG(ERROR) << "Set sys msg read event: create error, msg_id[" << request.msg_id << "]";
    }
}

void PostServiceImpl::ClearRedEvent(const ClearRedRequest& request) {
    BaseTask *task = NULL;
    if ((task = TaskFactory::create_task(CLEAR_RED, 4))) {
        if (!task->init(&request)) {
            TaskFactory::destroy_task(task);
            LOG(ERROR) << "clear red event: init error, uid[" << request.uid<< "] mtype[" << request.mType << "] from_uid[" << request.from_uid;
        } else {
            if (!_task_manager->add_task(task)) {
                TaskFactory::destroy_task(task);
                LOG(ERROR) << "clear red event: add error, uid[" << request.uid<< "] mtype[" << request.mType << "] from_uid[" << request.from_uid;
            }
        }
    } else {
        LOG(ERROR) << "clear red event: create error, uid[" << request.uid<< "] mtype[" << request.mType << "] from_uid[" << request.from_uid;
    }
}

void PostServiceImpl::MisPushEvent(const MisPushRequest& request) {
    BaseTask *task = NULL;
    if ((task = TaskFactory::create_task(MIS_PUSH, 1))) {
        if (!task->init(&request)) {
            TaskFactory::destroy_task(task);
            LOG(ERROR) << "mis push event: init error, push_task_id[" << request.push_task_id <<"]";
        } else {
            if (!_task_manager->add_task(task)) {
                TaskFactory::destroy_task(task);
                LOG(ERROR) << "mis push event: add error, push_task_id[" << request.push_task_id <<"]";
            }
        }
    } else {
        LOG(ERROR) << "mis push event: create error, push_task_id[" << request.push_task_id <<"]";
    }
}

void PostServiceImpl::SetPushTagEvent(const SetPushTagRequest& request) {
    BaseTask *task = NULL;
    if ((task = TaskFactory::create_task(SET_PUSH_TAG, 4))) {
        if (!task->init(&request)) {
            TaskFactory::destroy_task(task);
            LOG(ERROR) << "set push tag event: init error, uid[" << request.uid<<"] op[" << request.op <<"] tagsize[" << request.tag_list.size() << "]";
        } else {
            if (!_task_manager->add_task(task)) {
                TaskFactory::destroy_task(task);
                LOG(ERROR) << "set push tag event: add error, uid[" << request.uid<<"] op[" << request.op <<"] tagsize[" << request.tag_list.size() << "]";
            }
        }
    } else {
        LOG(ERROR) << "set push tag event: create error, uid[" << request.uid<<"] op[" << request.op <<"] tagsize[" << request.tag_list.size() << "]";
    }
}

}//namespce

/* vim: set expandtab ts=4 sw=4 sts=4 tw=100: */
