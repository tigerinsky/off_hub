
#include "../../util/timer.h"
#include "../../util/utils.h"
#include "broadcast_post_task.h"
#include "glog/logging.h"
#include "thrift/transport/TSocket.h"
#include "thrift/transport/TBufferTransports.h"
#include "thrift/protocol/TBinaryProtocol.h"
#include "../thread_context.h"
#include "../../flag.h"
#include "../../interface/MessageServer.h"
#include "../../interface/post_service_types.h"

namespace tis {

bool BroadcastPostTask::init(const void* r) {
    const PostServiceRequest* request = static_cast<const PostServiceRequest*>(r);
    _uid = request->tweet_info.uid;
    _tid = request->tweet_info.tid;

    return true;
}

int BroadcastPostTask::__get_follower(thread_context_t* context) {
    int ret = -1;
    MysqlProxy* mysql_proxy = context->mysql.proxy;
    mysql_stmt_t* get_small_follower_st = 
        &(context->mysql.get_small_follower_st);
    SmallFollower* small_follower = &(context->mysql.small_follower);
    ret = mysql_proxy->execute(get_small_follower_st, _uid); 
    if (MysqlProxy::MYSQL_QUERY_OK != ret) {
        LOG(ERROR)<<"mysql error: ["
            <<mysql_proxy->get_err_msg()<<"] ["
            <<mysql_proxy->get_prepare_err_msg(get_small_follower_st) 
            << "]";
        return 1; 
    }
    mysql_stmt_t* get_big_follower_st =
        &(context->mysql.get_big_follower_st);
    BigFollower* big_follower = &(context->mysql.big_follower);
    ret = mysql_proxy->execute(get_big_follower_st, _uid);
    if (MysqlProxy::MYSQL_QUERY_OK != ret) {
        LOG(ERROR) << "mysql error: ["
            << mysql_proxy->get_err_msg() << "] ["
            << mysql_proxy->get_prepare_err_msg(get_big_follower_st)
            << "]";
        return 1;
    }
    _follower_list.clear();
    // get small follower
    while (true) {
        bool is_finish = false;
        switch(mysql_proxy->next(get_small_follower_st)) {
        case MysqlProxy::MYSQL_NEXT_ERR: 
            mysql_proxy->free_result(get_small_follower_st);
            return 2;
        case MysqlProxy::MYSQL_NEXT_END:
            is_finish = true;
            break;
        case MysqlProxy::MYSQL_NEXT_OK:
            ret = mysql_proxy->get_proto(get_small_follower_st, small_follower); 
            if (MysqlProxy::MYSQL_GET_PROTO_OK == ret) {
                if (small_follower->has_a_uid()) {
                    _follower_list.push_back(small_follower->a_uid());
                }
            } else {
                mysql_proxy->free_result(get_small_follower_st);
                return 3;
            }
            small_follower->Clear();
            break;
        }
        if (is_finish) break; 
    }

    // get big follower
    bool is_finish = false;
    while (true) {
        switch (mysql_proxy->next(get_big_follower_st)) {
        case MysqlProxy::MYSQL_NEXT_ERR:
            mysql_proxy->free_result(get_big_follower_st);
            return 2;
        case MysqlProxy::MYSQL_NEXT_END:
            is_finish = true;
            break;
        case MysqlProxy::MYSQL_NEXT_OK:
            ret = mysql_proxy->get_proto(get_big_follower_st, big_follower);
            if (MysqlProxy::MYSQL_GET_PROTO_OK == ret) {
                if (big_follower->has_b_uid()) {
                    _follower_list.push_back(big_follower->b_uid());
                }
            } else  {
                mysql_proxy->free_result(get_big_follower_st);
                return 3;
            }
            big_follower->Clear();
            break;
        }
        if (is_finish) break;
    }

    mysql_proxy->free_result(get_small_follower_st);
    mysql_proxy->free_result(get_big_follower_st);

    // print followers
    std::string str_followers;
    for (std::vector<int32_t>::iterator vec_itr = _follower_list.begin();
            vec_itr != _follower_list.end(); vec_itr++) {
        str_followers += type_convert<int32_t, std::string>(*vec_itr);
        str_followers += ';';
    }
    DLOG(INFO) << "follower list: uid=" << _uid
        << " followers: " << str_followers;

    return 0;
}

int BroadcastPostTask::__redis_update(thread_context_t* context) {
    RedisProxy* redis_proxy = context->redis_proxy;
    std::stringstream str_stream;
    std::string out_value;
    std::string user_key;
    uint64_t queue_size = 0;

    // set value
    str_stream << _tid;
    str_stream >> out_value;
    DLOG(INFO) << "out_value: " << out_value;

    // add myself
    std::vector<int32_t>::iterator vec_itr = std::find(_follower_list.begin(),
                                        _follower_list.end(),
                                        _uid);
    if (_follower_list.end() != vec_itr) {
        LOG(ERROR) << "The " << _uid << " followed himself!";
        _follower_list.erase(vec_itr);

    }

    // loop users
    for (std::vector<int32_t>::iterator vec_itr = _follower_list.begin();
            vec_itr != _follower_list.end(); vec_itr++){
        // 3. lpush user msg_queue
        str_stream.clear();
        str_stream << FLAGS_msg_queue_prefix << *vec_itr;
        str_stream >> user_key;
        DLOG(INFO) << "list_key: " << user_key;
        if (RedisProxy::REDIS_LPUSH_OK !=
                redis_proxy->lpush(user_key.c_str(), 
                                    out_value.c_str(), 
                                    out_value.length(),
                                    &queue_size)){
            LOG(ERROR) << "lpush " << user_key << " failed.";
        } else {
            // if queue is limit, pop out left item.
            if (FLAGS_redis_queue_size < queue_size){
                int32_t end_pos = FLAGS_redis_queue_size - static_cast<int32_t>(queue_size) - 1;
                if(RedisProxy::REDIS_LTRIM_OK != 
                        redis_proxy->ltrim(user_key.c_str(),
                                0,
                                end_pos)){
                    LOG(ERROR) << "ltrim " << user_key 
                        << " from " << queue_size - FLAGS_redis_queue_size
                        << " to -1 failed.";
                } // if RedisProxy ..
            } // if FLAGS ..
        } // else
    }

    return 0;
}

/*int BroadcastPostTask::__new_tweet_notify() {
    NewTweetNotifyRequest request;
    request.type = TweetType::COMMUNITY;
    request.tid = _tid;
    request.uids = _follower_list;

    using namespace apache::thrift;
    using boost::shared_ptr;
    shared_ptr<transport::TSocket> socket(new transport::TSocket(FLAGS_ms_host.c_str(), FLAGS_ms_port));
    shared_ptr<transport::TTransport> transport(new transport::TFramedTransport(socket));
    shared_ptr<protocol::TProtocol> protocol(new protocol::TBinaryProtocol(transport));
    MessageServerClient ms(protocol);
    try {
        transport->open();
        ms.new_tweet_notify(request);
        transport->close();
    } catch (TException& tx) {
        LOG(WARNING) << "broadcast new tweet notify exception, msg["<<tx.what()<<"]"; 
        return 1;
    }

    return 0;
}*/

int BroadcastPostTask::execute(thread_context_t* context) {
    int ret = -1;
    Timer timer;

    ret = __get_follower(context);
    if (ret) {
        LOG(ERROR) << "broadcast post task: get follower error, tid["<<_tid<<"] ret["<<ret<<"]"; 
        return 1;
    }
    time_t follower_time = timer.elapse();

    timer.reset();
    ret = __redis_update(context);
    if (ret) {
        LOG(ERROR) << "broadcast post task: update redis error, tid["<<_tid<<"] ret["<<ret<<"]"; 
        return 2;
    }
    time_t update_time = timer.elapse();

    timer.reset();
/* TODO: new notify later.
    ret = __new_tweet_notify();
    if (ret) {
        LOG(ERROR) << "broadcast post task: notify new tweet error, tid["<<_tid<<"] ret["<<ret<<"]"; 
        return 3;
  }*/
    time_t new_tweet_time = timer.elapse();

    LOG(INFO) << "broadcast post task: executed. _tid=" << _tid 
        << " _uid=" << _uid
        << " follower_time=" << follower_time 
        << " update_time=" << update_time
        << " new_tweet_time=" << new_tweet_time;

    return 0;
}

}

