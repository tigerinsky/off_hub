
#include "task_factory.h"
#include "handler/broadcast_post_task.h"
#include "handler/update_offline_task.h"
#include "handler/new_follow_tweet_push_task.h"
#include "handler/send_sms_task.h"
#include "handler/mysql_new_tweet_task.h"
#include "glog/logging.h"

namespace tis {

//TODO involve tc_maclloc to 
BaseTask* TaskFactory::create_task(TaskType type, int priority) {
    BaseTask* task = NULL;
    LOG(INFO) << "task type:" << type << " priority: " << priority;
    switch (type) {
    case BROADCAST_POST:
        task = dynamic_cast<BaseTask*>(new(std::nothrow) BroadcastPostTask);
        break;
    case UPDATE_OFFLINE:
        task = dynamic_cast<BaseTask*>(new(std::nothrow) UpdateOfflineTask);
        break;
    case NEW_FOLLOW_TWEET_PUSH:
        task = dynamic_cast<BaseTask*>(new(std::nothrow) NewFollowTweetPushTask);
        break;
    case SEND_SMS:
        LOG(INFO) << "before create task";
        task = dynamic_cast<BaseTask*>(new(std::nothrow) SendSmsTask);
        LOG(INFO) << "after create task";
        break;
    case MYSQL_NEW_TWEET:
        task = dynamic_cast<BaseTask*>(new(std::nothrow) MysqlNewTweetTask);
        break;
    default:
        LOG(WARNING) << "task factory: invalid type["<<type<<"]";
        return NULL;
    }
    if (task) {
        task->set_priority(priority);
        return task; 
    } else {
        LOG(WARNING) << "task factory: create task failed, type["<<type<<"]";
        return NULL;
    }
}

void TaskFactory::destroy_task(BaseTask* t) {
    if (t) {
        delete t; 
    }
}

}
