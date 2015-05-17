#include "glog/logging.h"
#include "../thread_context.h"
#include "../../interface/post_service_types.h"
#include "mysql_new_tweet_task.h"

namespace tis {

bool MysqlNewTweetTask::init(const void* r) {
    const PostServiceRequest* request = static_cast<const PostServiceRequest*>(r);
    _tid = request->tid;
    _uid = request->uid;
    _type = request->type;
    _f_catalog = request->f_catalog;
    _content = request->content;
    _ctime = request->ctime;
    _dtime = request->dtime;
    _img = request->img;
    _s_catalog = request->s_catalog;
    _tags = request->tags;

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

    i_ret = mysql_proxy->execute(new_tweet_st,
                                _tid,
                                _uid,
                                _type,
                                _f_catalog.c_str(),
                                _content.c_str(),
                                _ctime,
                                0,
                                _dtime,
                                _img.c_str(),
                                _s_catalog.c_str(),
                                _tags.c_str());
    if (MysqlProxy::MYSQL_QUERY_OK != i_ret) {
        LOG(ERROR) << "Insert tweet error, tid=" << _tid
            << " uid=" << _uid << " ret=" << i_ret;
        return 1;
    }

    return 0;
}

}
