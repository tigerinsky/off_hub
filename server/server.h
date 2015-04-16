/**
 * @file server.h
 * @author wangxuebing(com@baidu.com)
 * @date 2015/01/27 23:48:05
 * @brief 
 *  
 **/


#ifndef  __OFFPOST_SERVER_H_
#define  __OFFPOST_SERVER_H_

namespace apache { namespace thrift { namespace server{
class TNonblockingServer;
}}}

namespace tis {

class TaskManager;

class PostServer{
public:
    PostServer();
    virtual ~PostServer();
    // TODO: add config params for loading configure.
    int run();
    void stop();
private:
    apache::thrift::server::TNonblockingServer* _server;   // non blocking server 
    TaskManager* _task_manager;
};

}

#endif  //__OFFPOST_SERVER_H_

/* vim: set expandtab ts=4 sw=4 sts=4 tw=100: */
