#include "glog/logging.h"
#include "../thread_context.h"
#include "../../interface/post_service_types.h"
#include "mysql_new_tweet_task.h"

namespace tis {

MysqlNewTweetTask::~MysqlNewTweetTask() {
    delete _tweet_str;
}

bool MysqlNewTweetTask::init(const void* r) {
    const PostServiceRequest* request = static_cast<const PostServiceRequest*>(r);
    _tid = request->tweet_info.tid;
    _tweet_str = new TweetStruct(request->tweet_info);

    return true;
}

int MysqlNewTweetTask::execute(thread_context_t* thread_context) {
    int i_ret = -1;

    i_ret = __mysql_update(thread_context);
    if (0 != i_ret) {
        LOG(ERROR) << "mysql_new_tweet_task: mysql_update error, ret=" << i_ret;
        return 1;
    }

    return 0;
}

int MysqlNewTweetTask::__mysql_update(thread_context_t* context) {
    int i_ret = -1;
    MysqlProxy* mysql_proxy = context->mysql.proxy;
    mysql_stmt_t* new_tweet_st = &(context->mysql.write_new_tweet_st);
    mysql_stmt_t* new_resource_st = &(context->mysql.write_new_resource_st);
    std::vector<ResourceStruct>& res_list = _tweet_str->resources;

    i_ret = mysql_proxy->execute(new_tweet_st,
                                _tweet_str->tid,
                                _tweet_str->uid,
                                _tweet_str->type,
                                _tweet_str->f_catalog.c_str(),
                                _tweet_str->content.c_str(),
                                _tweet_str->ctime,
                                0,
                                _tweet_str->dtime,
                                _tweet_str->s_catalog.c_str(),
                                _tweet_str->tags.c_str(),
                                _tweet_str->resource_id.c_str());
    if (MysqlProxy::MYSQL_QUERY_OK != i_ret) {
        LOG(ERROR) << "Insert tweet error, tid=" << _tweet_str->tid
            << " uid=" << _tweet_str->uid << " ret=" << i_ret;
        return 1;
    }

    for (std::vector<ResourceStruct>::iterator vec_itr = res_list.begin();
            vec_itr != res_list.end(); vec_itr++) {
        i_ret = mysql_proxy->execute(new_resource_st,
                                vec_itr->rid,
                                vec_itr->img.c_str(),
                                vec_itr->description.c_str());
        if (MysqlProxy::MYSQL_QUERY_OK != i_ret) {
            LOG(ERROR) << "insert resource error, rid=" << vec_itr->rid
                << " ret=" << i_ret;
            return 2;
        }
    }

    return 0;
}

}
