/**
 * @file server.cpp
 * @author wangxuebing
 * @date 2015/01/27 23:57:36
 * @brief 
 *  
 **/

#include "server.h"

#include "thrift/protocol/TBinaryProtocol.h"
#include "thrift/concurrency/ThreadManager.h"
#include "thrift/concurrency/PosixThreadFactory.h"
#include "thrift/server/TNonblockingServer.h"

#include "glog/logging.h"
#include "../flag.h"
#include "../service/service.h"
#include "../task/task_manager.h"

namespace tis{

PostServer::PostServer(){
    _server = NULL;
    _task_manager = NULL;
}

PostServer::~PostServer(){
    if (_server) delete _server; 
    if (_task_manager) delete _task_manager; 
}

int PostServer::run(){
using boost::shared_ptr;
using apache::thrift::protocol::TProtocolFactory;
using apache::thrift::protocol::TBinaryProtocolFactory;
using apache::thrift::TProcessor;
using apache::thrift::concurrency::ThreadManager;
using apache::thrift::concurrency::PosixThreadFactory;
using apache::thrift::server::TNonblockingServer;
using apache::thrift::TException;

    // 1. init task manager
    _task_manager = new(std::nothrow) TaskManager;
    if (!_task_manager) return 4; 
    if (!_task_manager->init()) return 5; 
    // 2. thrift server
    try {
        //protocol
        shared_ptr<TProtocolFactory> protocol_factory(new TBinaryProtocolFactory());

        //processor
        //register processor
        shared_ptr<PostServiceImpl> handler(new PostServiceImpl());
        handler->set_task_manager(_task_manager);
        shared_ptr<TProcessor> post_processor(new PostServiceProcessor(handler));

        // handler thread pool
        shared_ptr<ThreadManager> thread_manager = ThreadManager::newSimpleThreadManager(FLAGS_server_thread_num);
        shared_ptr<PosixThreadFactory> thread_factory(new PosixThreadFactory());
        thread_manager->threadFactory(thread_factory);
        thread_manager->start();

        // server
        _server = new(std::nothrow) TNonblockingServer(post_processor, 
                                                       protocol_factory, 
                                                       FLAGS_port, 
                                                       thread_manager);
        if (NULL == _server) {
            LOG(ERROR) << "create nonblocking server error";    
            return 1;
        }
        _server->serve();
        _task_manager->stop();
    } catch (TException& ex){
        LOG(ERROR) << "thrift server exception: [" << ex.what() << "]";
        return 2;
    } catch (std::exception& ex) {
        LOG(ERROR) << "unknown exception: [" << ex.what() << "]";
        return 3;
    }
    return 0;
}

void PostServer::stop(){
    _server->stop();
}

}

/* vim: set expandtab ts=4 sw=4 sts=4 tw=100: */
