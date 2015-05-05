#---------- env ----------
CXX=g++
CXXFLAGS=-D_GNU_SOURCE -D__STDC_LIMIT_MACROS -g -pipe -W -Wall -fPIC -fno-omit-frame-pointer
INCPATH=-I. -I/home/meihua/jinkaifeng/github/off_hub/../glog/include -I/home/meihua/jinkaifeng/github/off_hub/../se/include -I/home/meihua/jinkaifeng/github/off_hub/../redis_proxy/output/include -I/home/meihua/jinkaifeng/github/off_hub/../protobuf/include -I/home/meihua/jinkaifeng/github/off_hub/../hiredis/include -I/home/meihua/jinkaifeng/github/off_hub/../gflags/include -I/home/meihua/jinkaifeng/github/off_hub/../mysql_proxy/output/include -I/home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include -I/home/meihua/jinkaifeng/github/off_hub/../thrift/include
LIBPATH=-Xlinker "-(" -levent -ldl -lpthread -lm -lrt /home/meihua/jinkaifeng/github/off_hub/../glog/lib/libglog.a /home/meihua/jinkaifeng/github/off_hub/../redis_proxy/output/lib/libredis_proxy.a /home/meihua/jinkaifeng/github/off_hub/../protobuf/lib/libprotoc.a /home/meihua/jinkaifeng/github/off_hub/../protobuf/lib/libprotobuf.a /home/meihua/jinkaifeng/github/off_hub/../protobuf/lib/libprotobuf-lite.a /home/meihua/jinkaifeng/github/off_hub/../hiredis/lib/libhiredis.a /home/meihua/jinkaifeng/github/off_hub/../gflags/lib/libgflags.a /home/meihua/jinkaifeng/github/off_hub/../gflags/lib/libgflags_nothreads.a /home/meihua/jinkaifeng/github/off_hub/../mysql_proxy/output/lib/libmysql_proxy.a /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/lib/libmysqlclient.a /home/meihua/jinkaifeng/github/off_hub/../thrift/lib/libthriftnb.a /home/meihua/jinkaifeng/github/off_hub/../thrift/lib/libthriftz.a /home/meihua/jinkaifeng/github/off_hub/../thrift/lib/libthrift.a -Xlinker "-)"


#---------- phony ----------
.PHONY:all
all:prepare \
off_hub \


.PHONY:prepare
prepare:
	mkdir -p ./output/bin

.PHONY:clean
clean:
	rm -rf /home/meihua/jinkaifeng/github/off_hub/service/offpost_service_impl.o /home/meihua/jinkaifeng/github/off_hub/util/timer.o /home/meihua/jinkaifeng/github/off_hub/server/server.o /home/meihua/jinkaifeng/github/off_hub/util/utils.o /home/meihua/jinkaifeng/github/off_hub/interface/system_message_constants.o /home/meihua/jinkaifeng/github/off_hub/task/handler/update_offline_task.o /home/meihua/jinkaifeng/github/off_hub/interface/MessageServer.o /home/meihua/jinkaifeng/github/off_hub/proto/user_name.pb.o /home/meihua/jinkaifeng/github/off_hub/task/task_factory.o /home/meihua/jinkaifeng/github/off_hub/task/task_manager.o /home/meihua/jinkaifeng/github/off_hub/interface/post_service_types.o /home/meihua/jinkaifeng/github/off_hub/interface/PostService.o /home/meihua/jinkaifeng/github/off_hub/proto/tweet_offline.pb.o /home/meihua/jinkaifeng/github/off_hub/interface/system_message_types.o /home/meihua/jinkaifeng/github/off_hub/task/handler/new_follow_tweet_push_task.o /home/meihua/jinkaifeng/github/off_hub/main.o /home/meihua/jinkaifeng/github/off_hub/proto/user_id.pb.o /home/meihua/jinkaifeng/github/off_hub/proto/tweet_id.pb.o /home/meihua/jinkaifeng/github/off_hub/proto/follower.pb.o /home/meihua/jinkaifeng/github/off_hub/interface/post_service_constants.o /home/meihua/jinkaifeng/github/off_hub/task/handler/broadcast_post_task.o ./output


#---------- link ----------
off_hub:/home/meihua/jinkaifeng/github/off_hub/server/server.o \
/home/meihua/jinkaifeng/github/off_hub/main.o \
/home/meihua/jinkaifeng/github/off_hub/task/handler/new_follow_tweet_push_task.o \
/home/meihua/jinkaifeng/github/off_hub/task/task_manager.o \
/home/meihua/jinkaifeng/github/off_hub/proto/user_name.pb.o \
/home/meihua/jinkaifeng/github/off_hub/task/handler/broadcast_post_task.o \
/home/meihua/jinkaifeng/github/off_hub/service/offpost_service_impl.o \
/home/meihua/jinkaifeng/github/off_hub/proto/tweet_offline.pb.o \
/home/meihua/jinkaifeng/github/off_hub/task/handler/update_offline_task.o \
/home/meihua/jinkaifeng/github/off_hub/interface/post_service_constants.o \
/home/meihua/jinkaifeng/github/off_hub/interface/PostService.o \
/home/meihua/jinkaifeng/github/off_hub/interface/post_service_types.o \
/home/meihua/jinkaifeng/github/off_hub/proto/follower.pb.o \
/home/meihua/jinkaifeng/github/off_hub/proto/tweet_id.pb.o \
/home/meihua/jinkaifeng/github/off_hub/util/utils.o \
/home/meihua/jinkaifeng/github/off_hub/interface/MessageServer.o \
/home/meihua/jinkaifeng/github/off_hub/interface/system_message_constants.o \
/home/meihua/jinkaifeng/github/off_hub/interface/system_message_types.o \
/home/meihua/jinkaifeng/github/off_hub/util/timer.o \
/home/meihua/jinkaifeng/github/off_hub/task/task_factory.o \
/home/meihua/jinkaifeng/github/off_hub/proto/user_id.pb.o \

	$(CXX) /home/meihua/jinkaifeng/github/off_hub/server/server.o /home/meihua/jinkaifeng/github/off_hub/main.o /home/meihua/jinkaifeng/github/off_hub/task/handler/new_follow_tweet_push_task.o /home/meihua/jinkaifeng/github/off_hub/task/task_manager.o /home/meihua/jinkaifeng/github/off_hub/proto/user_name.pb.o /home/meihua/jinkaifeng/github/off_hub/task/handler/broadcast_post_task.o /home/meihua/jinkaifeng/github/off_hub/service/offpost_service_impl.o /home/meihua/jinkaifeng/github/off_hub/proto/tweet_offline.pb.o /home/meihua/jinkaifeng/github/off_hub/task/handler/update_offline_task.o /home/meihua/jinkaifeng/github/off_hub/interface/post_service_constants.o /home/meihua/jinkaifeng/github/off_hub/interface/PostService.o /home/meihua/jinkaifeng/github/off_hub/interface/post_service_types.o /home/meihua/jinkaifeng/github/off_hub/proto/follower.pb.o /home/meihua/jinkaifeng/github/off_hub/proto/tweet_id.pb.o /home/meihua/jinkaifeng/github/off_hub/util/utils.o /home/meihua/jinkaifeng/github/off_hub/interface/MessageServer.o /home/meihua/jinkaifeng/github/off_hub/interface/system_message_constants.o /home/meihua/jinkaifeng/github/off_hub/interface/system_message_types.o /home/meihua/jinkaifeng/github/off_hub/util/timer.o /home/meihua/jinkaifeng/github/off_hub/task/task_factory.o /home/meihua/jinkaifeng/github/off_hub/proto/user_id.pb.o $(LIBPATH) -o ./output/bin/off_hub



#---------- obj ----------
/home/meihua/jinkaifeng/github/off_hub/service/offpost_service_impl.o: \
 /home/meihua/jinkaifeng/github/off_hub/service/offpost_service_impl.cpp \
 /home/meihua/jinkaifeng/github/off_hub/service/service.h \
 interface/PostService.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/TDispatchProcessor.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/TProcessor.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/protocol/TProtocol.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/transport/TTransport.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/Thrift.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/transport/PlatformSocket.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/thrift-config.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/config.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/TLogging.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/transport/TTransportException.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/protocol/TProtocolException.h \
 interface/post_service_types.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/TApplicationException.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/cxxfunctional.h \
 /home/meihua/jinkaifeng/github/off_hub/../glog/include/glog/logging.h \
 /home/meihua/jinkaifeng/github/off_hub/../gflags/include/gflags/gflags.h \
 /home/meihua/jinkaifeng/github/off_hub/../gflags/include/gflags/gflags_declare.h \
 /home/meihua/jinkaifeng/github/off_hub/../glog/include/glog/log_severity.h \
 /home/meihua/jinkaifeng/github/off_hub/../glog/include/glog/vlog_is_on.h \
 /home/meihua/jinkaifeng/github/off_hub/service/../task/task_manager.h \
 /home/meihua/jinkaifeng/github/off_hub/service/../task/handler/base_task.h \
 /home/meihua/jinkaifeng/github/off_hub/service/../task/task_factory.h \
 /home/meihua/jinkaifeng/github/off_hub/service/../task/handler/broadcast_post_task.h \
 /home/meihua/jinkaifeng/github/off_hub/service/../task/handler/base_task.h
	$(CXX) $(INCPATH) $(CXXFLAGS) -c -o /home/meihua/jinkaifeng/github/off_hub/service/offpost_service_impl.o /home/meihua/jinkaifeng/github/off_hub/service/offpost_service_impl.cpp
/home/meihua/jinkaifeng/github/off_hub/util/timer.o: /home/meihua/jinkaifeng/github/off_hub/util/timer.cpp \
 /home/meihua/jinkaifeng/github/off_hub/util/timer.h
	$(CXX) $(INCPATH) $(CXXFLAGS) -c -o /home/meihua/jinkaifeng/github/off_hub/util/timer.o /home/meihua/jinkaifeng/github/off_hub/util/timer.cpp
/home/meihua/jinkaifeng/github/off_hub/server/server.o: /home/meihua/jinkaifeng/github/off_hub/server/server.cpp \
 /home/meihua/jinkaifeng/github/off_hub/server/server.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/protocol/TBinaryProtocol.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/protocol/TProtocol.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/transport/TTransport.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/Thrift.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/transport/PlatformSocket.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/thrift-config.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/config.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/TLogging.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/transport/TTransportException.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/protocol/TProtocolException.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/protocol/TVirtualProtocol.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/protocol/TBinaryProtocol.tcc \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/concurrency/ThreadManager.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/cxxfunctional.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/concurrency/Thread.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/concurrency/PosixThreadFactory.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/server/TNonblockingServer.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/server/TServer.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/TProcessor.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/transport/TServerTransport.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/transport/TBufferTransports.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/transport/TVirtualTransport.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/transport/TSocket.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/transport/TServerSocket.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/concurrency/PlatformThreadFactory.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/concurrency/Mutex.h \
 /home/meihua/jinkaifeng/github/off_hub/../glog/include/glog/logging.h \
 /home/meihua/jinkaifeng/github/off_hub/../gflags/include/gflags/gflags.h \
 /home/meihua/jinkaifeng/github/off_hub/../gflags/include/gflags/gflags_declare.h \
 /home/meihua/jinkaifeng/github/off_hub/../glog/include/glog/log_severity.h \
 /home/meihua/jinkaifeng/github/off_hub/../glog/include/glog/vlog_is_on.h \
 /home/meihua/jinkaifeng/github/off_hub/server/../flag.h \
 /home/meihua/jinkaifeng/github/off_hub/../gflags/include/google/gflags.h \
 /home/meihua/jinkaifeng/github/off_hub/server/../service/service.h \
 interface/PostService.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/TDispatchProcessor.h \
 interface/post_service_types.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/TApplicationException.h \
 /home/meihua/jinkaifeng/github/off_hub/server/../task/task_manager.h \
 /home/meihua/jinkaifeng/github/off_hub/server/../task/handler/base_task.h
	$(CXX) $(INCPATH) $(CXXFLAGS) -c -o /home/meihua/jinkaifeng/github/off_hub/server/server.o /home/meihua/jinkaifeng/github/off_hub/server/server.cpp
/home/meihua/jinkaifeng/github/off_hub/util/utils.o: /home/meihua/jinkaifeng/github/off_hub/util/utils.cpp \
 /home/meihua/jinkaifeng/github/off_hub/../glog/include/glog/logging.h \
 /home/meihua/jinkaifeng/github/off_hub/../gflags/include/gflags/gflags.h \
 /home/meihua/jinkaifeng/github/off_hub/../gflags/include/gflags/gflags_declare.h \
 /home/meihua/jinkaifeng/github/off_hub/../glog/include/glog/log_severity.h \
 /home/meihua/jinkaifeng/github/off_hub/../glog/include/glog/vlog_is_on.h \
 /home/meihua/jinkaifeng/github/off_hub/util/utils.h
	$(CXX) $(INCPATH) $(CXXFLAGS) -c -o /home/meihua/jinkaifeng/github/off_hub/util/utils.o /home/meihua/jinkaifeng/github/off_hub/util/utils.cpp
/home/meihua/jinkaifeng/github/off_hub/interface/system_message_constants.o: \
 /home/meihua/jinkaifeng/github/off_hub/interface/system_message_constants.cpp \
 /home/meihua/jinkaifeng/github/off_hub/interface/system_message_constants.h \
 /home/meihua/jinkaifeng/github/off_hub/interface/system_message_types.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/Thrift.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/transport/PlatformSocket.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/thrift-config.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/config.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/TLogging.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/TApplicationException.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/protocol/TProtocol.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/transport/TTransport.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/transport/TTransportException.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/protocol/TProtocolException.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/cxxfunctional.h
	$(CXX) $(INCPATH) $(CXXFLAGS) -c -o /home/meihua/jinkaifeng/github/off_hub/interface/system_message_constants.o /home/meihua/jinkaifeng/github/off_hub/interface/system_message_constants.cpp
/home/meihua/jinkaifeng/github/off_hub/task/handler/update_offline_task.o: \
 /home/meihua/jinkaifeng/github/off_hub/task/handler/update_offline_task.cpp \
 /home/meihua/jinkaifeng/github/off_hub/../glog/include/glog/logging.h \
 /home/meihua/jinkaifeng/github/off_hub/../gflags/include/gflags/gflags.h \
 /home/meihua/jinkaifeng/github/off_hub/../gflags/include/gflags/gflags_declare.h \
 /home/meihua/jinkaifeng/github/off_hub/../glog/include/glog/log_severity.h \
 /home/meihua/jinkaifeng/github/off_hub/../glog/include/glog/vlog_is_on.h \
 /home/meihua/jinkaifeng/github/off_hub/task/handler/../../util/timer.h \
 /home/meihua/jinkaifeng/github/off_hub/task/handler/../../flag.h \
 /home/meihua/jinkaifeng/github/off_hub/../gflags/include/google/gflags.h \
 /home/meihua/jinkaifeng/github/off_hub/task/handler/../../interface/post_service_types.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/Thrift.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/transport/PlatformSocket.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/thrift-config.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/config.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/TLogging.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/TApplicationException.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/protocol/TProtocol.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/transport/TTransport.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/transport/TTransportException.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/protocol/TProtocolException.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/cxxfunctional.h \
 /home/meihua/jinkaifeng/github/off_hub/task/handler/../../util/utils.h \
 /home/meihua/jinkaifeng/github/off_hub/task/handler/../thread_context.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql_proxy/output/include/mysql_proxy.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/mysql.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/mysql_version.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/mysql_com.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/mysql_time.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/my_list.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/mysql/client_plugin.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/mysql/plugin_auth_common.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/typelib.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/my_alloc.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/mysql/psi/psi_memory.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/mysql/psi/psi_base.h \
 /home/meihua/jinkaifeng/github/off_hub/../redis_proxy/output/include/redis_proxy.h \
 /home/meihua/jinkaifeng/github/off_hub/task/handler/../../proto/follower.pb.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/common.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/generated_message_util.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/once.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/atomicops.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/platform_macros.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/atomicops_internals_x86_gcc.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/message.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/message_lite.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/descriptor.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/repeated_field.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/type_traits.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/template_util.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/extension_set.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/unknown_field_set.h \
 /home/meihua/jinkaifeng/github/off_hub/task/handler/../../proto/tweet_id.pb.h \
 /home/meihua/jinkaifeng/github/off_hub/task/handler/update_offline_task.h \
 /home/meihua/jinkaifeng/github/off_hub/task/handler/base_task.h
	$(CXX) $(INCPATH) $(CXXFLAGS) -c -o /home/meihua/jinkaifeng/github/off_hub/task/handler/update_offline_task.o /home/meihua/jinkaifeng/github/off_hub/task/handler/update_offline_task.cpp
/home/meihua/jinkaifeng/github/off_hub/interface/MessageServer.o: \
 /home/meihua/jinkaifeng/github/off_hub/interface/MessageServer.cpp \
 /home/meihua/jinkaifeng/github/off_hub/interface/MessageServer.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/TDispatchProcessor.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/TProcessor.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/protocol/TProtocol.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/transport/TTransport.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/Thrift.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/transport/PlatformSocket.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/thrift-config.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/config.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/TLogging.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/transport/TTransportException.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/protocol/TProtocolException.h \
 /home/meihua/jinkaifeng/github/off_hub/interface/system_message_types.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/TApplicationException.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/cxxfunctional.h
	$(CXX) $(INCPATH) $(CXXFLAGS) -c -o /home/meihua/jinkaifeng/github/off_hub/interface/MessageServer.o /home/meihua/jinkaifeng/github/off_hub/interface/MessageServer.cpp
/home/meihua/jinkaifeng/github/off_hub/proto/user_name.pb.o: \
 /home/meihua/jinkaifeng/github/off_hub/proto/user_name.pb.cc \
 /home/meihua/jinkaifeng/github/off_hub/proto/user_name.pb.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/common.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/generated_message_util.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/once.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/atomicops.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/platform_macros.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/atomicops_internals_x86_gcc.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/message.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/message_lite.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/descriptor.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/repeated_field.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/type_traits.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/template_util.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/extension_set.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/unknown_field_set.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/io/coded_stream.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/wire_format_lite_inl.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/wire_format_lite.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/generated_message_reflection.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/generated_enum_reflection.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/reflection_ops.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/wire_format.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/descriptor.pb.h
	$(CXX) $(INCPATH) $(CXXFLAGS) -c -o /home/meihua/jinkaifeng/github/off_hub/proto/user_name.pb.o /home/meihua/jinkaifeng/github/off_hub/proto/user_name.pb.cc
/home/meihua/jinkaifeng/github/off_hub/task/task_factory.o: \
 /home/meihua/jinkaifeng/github/off_hub/task/task_factory.cpp \
 /home/meihua/jinkaifeng/github/off_hub/task/task_factory.h \
 /home/meihua/jinkaifeng/github/off_hub/task/handler/base_task.h \
 /home/meihua/jinkaifeng/github/off_hub/task/handler/broadcast_post_task.h \
 /home/meihua/jinkaifeng/github/off_hub/task/handler/base_task.h \
 /home/meihua/jinkaifeng/github/off_hub/task/handler/update_offline_task.h \
 /home/meihua/jinkaifeng/github/off_hub/task/handler/new_follow_tweet_push_task.h \
 /home/meihua/jinkaifeng/github/off_hub/../glog/include/glog/logging.h \
 /home/meihua/jinkaifeng/github/off_hub/../gflags/include/gflags/gflags.h \
 /home/meihua/jinkaifeng/github/off_hub/../gflags/include/gflags/gflags_declare.h \
 /home/meihua/jinkaifeng/github/off_hub/../glog/include/glog/log_severity.h \
 /home/meihua/jinkaifeng/github/off_hub/../glog/include/glog/vlog_is_on.h
	$(CXX) $(INCPATH) $(CXXFLAGS) -c -o /home/meihua/jinkaifeng/github/off_hub/task/task_factory.o /home/meihua/jinkaifeng/github/off_hub/task/task_factory.cpp
/home/meihua/jinkaifeng/github/off_hub/task/task_manager.o: \
 /home/meihua/jinkaifeng/github/off_hub/task/task_manager.cpp \
 /home/meihua/jinkaifeng/github/off_hub/task/task_manager.h \
 /home/meihua/jinkaifeng/github/off_hub/task/handler/base_task.h \
 /home/meihua/jinkaifeng/github/off_hub/../glog/include/glog/logging.h \
 /home/meihua/jinkaifeng/github/off_hub/../gflags/include/gflags/gflags.h \
 /home/meihua/jinkaifeng/github/off_hub/../gflags/include/gflags/gflags_declare.h \
 /home/meihua/jinkaifeng/github/off_hub/../glog/include/glog/log_severity.h \
 /home/meihua/jinkaifeng/github/off_hub/../glog/include/glog/vlog_is_on.h \
 /home/meihua/jinkaifeng/github/off_hub/task/thread_context.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql_proxy/output/include/mysql_proxy.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/mysql.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/mysql_version.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/mysql_com.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/mysql_time.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/my_list.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/mysql/client_plugin.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/mysql/plugin_auth_common.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/typelib.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/my_alloc.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/mysql/psi/psi_memory.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/mysql/psi/psi_base.h \
 /home/meihua/jinkaifeng/github/off_hub/../redis_proxy/output/include/redis_proxy.h \
 /home/meihua/jinkaifeng/github/off_hub/task/../proto/follower.pb.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/common.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/generated_message_util.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/once.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/atomicops.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/platform_macros.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/atomicops_internals_x86_gcc.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/message.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/message_lite.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/descriptor.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/repeated_field.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/type_traits.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/template_util.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/extension_set.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/unknown_field_set.h \
 /home/meihua/jinkaifeng/github/off_hub/task/../proto/tweet_id.pb.h \
 /home/meihua/jinkaifeng/github/off_hub/task/task_factory.h \
 /home/meihua/jinkaifeng/github/off_hub/task/../flag.h \
 /home/meihua/jinkaifeng/github/off_hub/../gflags/include/google/gflags.h
	$(CXX) $(INCPATH) $(CXXFLAGS) -c -o /home/meihua/jinkaifeng/github/off_hub/task/task_manager.o /home/meihua/jinkaifeng/github/off_hub/task/task_manager.cpp
/home/meihua/jinkaifeng/github/off_hub/interface/post_service_types.o: \
 /home/meihua/jinkaifeng/github/off_hub/interface/post_service_types.cpp \
 /home/meihua/jinkaifeng/github/off_hub/interface/post_service_types.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/Thrift.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/transport/PlatformSocket.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/thrift-config.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/config.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/TLogging.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/TApplicationException.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/protocol/TProtocol.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/transport/TTransport.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/transport/TTransportException.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/protocol/TProtocolException.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/cxxfunctional.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/TToString.h
	$(CXX) $(INCPATH) $(CXXFLAGS) -c -o /home/meihua/jinkaifeng/github/off_hub/interface/post_service_types.o /home/meihua/jinkaifeng/github/off_hub/interface/post_service_types.cpp
/home/meihua/jinkaifeng/github/off_hub/interface/PostService.o: \
 /home/meihua/jinkaifeng/github/off_hub/interface/PostService.cpp \
 /home/meihua/jinkaifeng/github/off_hub/interface/PostService.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/TDispatchProcessor.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/TProcessor.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/protocol/TProtocol.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/transport/TTransport.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/Thrift.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/transport/PlatformSocket.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/thrift-config.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/config.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/TLogging.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/transport/TTransportException.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/protocol/TProtocolException.h \
 /home/meihua/jinkaifeng/github/off_hub/interface/post_service_types.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/TApplicationException.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/cxxfunctional.h
	$(CXX) $(INCPATH) $(CXXFLAGS) -c -o /home/meihua/jinkaifeng/github/off_hub/interface/PostService.o /home/meihua/jinkaifeng/github/off_hub/interface/PostService.cpp
/home/meihua/jinkaifeng/github/off_hub/proto/tweet_offline.pb.o: \
 /home/meihua/jinkaifeng/github/off_hub/proto/tweet_offline.pb.cc \
 /home/meihua/jinkaifeng/github/off_hub/proto/tweet_offline.pb.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/common.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/generated_message_util.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/once.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/atomicops.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/platform_macros.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/atomicops_internals_x86_gcc.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/message.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/message_lite.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/descriptor.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/repeated_field.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/type_traits.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/template_util.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/extension_set.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/unknown_field_set.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/io/coded_stream.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/wire_format_lite_inl.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/wire_format_lite.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/generated_message_reflection.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/generated_enum_reflection.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/reflection_ops.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/wire_format.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/descriptor.pb.h
	$(CXX) $(INCPATH) $(CXXFLAGS) -c -o /home/meihua/jinkaifeng/github/off_hub/proto/tweet_offline.pb.o /home/meihua/jinkaifeng/github/off_hub/proto/tweet_offline.pb.cc
/home/meihua/jinkaifeng/github/off_hub/interface/system_message_types.o: \
 /home/meihua/jinkaifeng/github/off_hub/interface/system_message_types.cpp \
 /home/meihua/jinkaifeng/github/off_hub/interface/system_message_types.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/Thrift.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/transport/PlatformSocket.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/thrift-config.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/config.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/TLogging.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/TApplicationException.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/protocol/TProtocol.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/transport/TTransport.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/transport/TTransportException.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/protocol/TProtocolException.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/cxxfunctional.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/TToString.h
	$(CXX) $(INCPATH) $(CXXFLAGS) -c -o /home/meihua/jinkaifeng/github/off_hub/interface/system_message_types.o /home/meihua/jinkaifeng/github/off_hub/interface/system_message_types.cpp
/home/meihua/jinkaifeng/github/off_hub/task/handler/new_follow_tweet_push_task.o: \
 /home/meihua/jinkaifeng/github/off_hub/task/handler/new_follow_tweet_push_task.cpp \
 /home/meihua/jinkaifeng/github/off_hub/task/handler/new_follow_tweet_push_task.h \
 /home/meihua/jinkaifeng/github/off_hub/task/handler/base_task.h \
 /home/meihua/jinkaifeng/github/off_hub/../glog/include/glog/logging.h \
 /home/meihua/jinkaifeng/github/off_hub/../gflags/include/gflags/gflags.h \
 /home/meihua/jinkaifeng/github/off_hub/../gflags/include/gflags/gflags_declare.h \
 /home/meihua/jinkaifeng/github/off_hub/../glog/include/glog/log_severity.h \
 /home/meihua/jinkaifeng/github/off_hub/../glog/include/glog/vlog_is_on.h \
 /home/meihua/jinkaifeng/github/off_hub/task/handler/../../interface/post_service_types.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/Thrift.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/transport/PlatformSocket.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/thrift-config.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/config.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/TLogging.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/TApplicationException.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/protocol/TProtocol.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/transport/TTransport.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/transport/TTransportException.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/protocol/TProtocolException.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/cxxfunctional.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql_proxy/output/include/mysql_proxy.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/mysql.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/mysql_version.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/mysql_com.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/mysql_time.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/my_list.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/mysql/client_plugin.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/mysql/plugin_auth_common.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/typelib.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/my_alloc.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/mysql/psi/psi_memory.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/mysql/psi/psi_base.h \
 /home/meihua/jinkaifeng/github/off_hub/task/handler/../thread_context.h \
 /home/meihua/jinkaifeng/github/off_hub/../redis_proxy/output/include/redis_proxy.h \
 /home/meihua/jinkaifeng/github/off_hub/task/handler/../../proto/follower.pb.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/common.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/generated_message_util.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/once.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/atomicops.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/platform_macros.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/atomicops_internals_x86_gcc.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/message.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/message_lite.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/descriptor.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/repeated_field.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/type_traits.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/template_util.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/extension_set.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/unknown_field_set.h \
 /home/meihua/jinkaifeng/github/off_hub/task/handler/../../proto/tweet_id.pb.h \
 /home/meihua/jinkaifeng/github/off_hub/task/handler/../../flag.h \
 /home/meihua/jinkaifeng/github/off_hub/../gflags/include/google/gflags.h
	$(CXX) $(INCPATH) $(CXXFLAGS) -c -o /home/meihua/jinkaifeng/github/off_hub/task/handler/new_follow_tweet_push_task.o /home/meihua/jinkaifeng/github/off_hub/task/handler/new_follow_tweet_push_task.cpp
/home/meihua/jinkaifeng/github/off_hub/main.o: /home/meihua/jinkaifeng/github/off_hub/main.cpp \
 /home/meihua/jinkaifeng/github/off_hub/flag.h \
 /home/meihua/jinkaifeng/github/off_hub/../gflags/include/google/gflags.h \
 /home/meihua/jinkaifeng/github/off_hub/../gflags/include/gflags/gflags.h \
 /home/meihua/jinkaifeng/github/off_hub/../gflags/include/gflags/gflags_declare.h \
 /home/meihua/jinkaifeng/github/off_hub/../glog/include/glog/logging.h \
 /home/meihua/jinkaifeng/github/off_hub/../glog/include/glog/log_severity.h \
 /home/meihua/jinkaifeng/github/off_hub/../glog/include/glog/vlog_is_on.h \
 /home/meihua/jinkaifeng/github/off_hub/service/service.h \
 interface/PostService.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/TDispatchProcessor.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/TProcessor.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/protocol/TProtocol.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/transport/TTransport.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/Thrift.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/transport/PlatformSocket.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/thrift-config.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/config.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/TLogging.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/transport/TTransportException.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/protocol/TProtocolException.h \
 interface/post_service_types.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/TApplicationException.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/cxxfunctional.h \
 /home/meihua/jinkaifeng/github/off_hub/server/server.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql_proxy/output/include/mysql_proxy.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/mysql.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/mysql_version.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/mysql_com.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/mysql_time.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/my_list.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/mysql/client_plugin.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/mysql/plugin_auth_common.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/typelib.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/my_alloc.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/mysql/psi/psi_memory.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/mysql/psi/psi_base.h
	$(CXX) $(INCPATH) $(CXXFLAGS) -c -o /home/meihua/jinkaifeng/github/off_hub/main.o /home/meihua/jinkaifeng/github/off_hub/main.cpp
/home/meihua/jinkaifeng/github/off_hub/proto/user_id.pb.o: /home/meihua/jinkaifeng/github/off_hub/proto/user_id.pb.cc \
 /home/meihua/jinkaifeng/github/off_hub/proto/user_id.pb.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/common.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/generated_message_util.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/once.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/atomicops.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/platform_macros.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/atomicops_internals_x86_gcc.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/message.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/message_lite.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/descriptor.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/repeated_field.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/type_traits.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/template_util.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/extension_set.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/unknown_field_set.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/io/coded_stream.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/wire_format_lite_inl.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/wire_format_lite.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/generated_message_reflection.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/generated_enum_reflection.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/reflection_ops.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/wire_format.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/descriptor.pb.h
	$(CXX) $(INCPATH) $(CXXFLAGS) -c -o /home/meihua/jinkaifeng/github/off_hub/proto/user_id.pb.o /home/meihua/jinkaifeng/github/off_hub/proto/user_id.pb.cc
/home/meihua/jinkaifeng/github/off_hub/proto/tweet_id.pb.o: \
 /home/meihua/jinkaifeng/github/off_hub/proto/tweet_id.pb.cc \
 /home/meihua/jinkaifeng/github/off_hub/proto/tweet_id.pb.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/common.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/generated_message_util.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/once.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/atomicops.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/platform_macros.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/atomicops_internals_x86_gcc.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/message.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/message_lite.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/descriptor.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/repeated_field.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/type_traits.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/template_util.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/extension_set.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/unknown_field_set.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/io/coded_stream.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/wire_format_lite_inl.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/wire_format_lite.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/generated_message_reflection.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/generated_enum_reflection.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/reflection_ops.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/wire_format.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/descriptor.pb.h
	$(CXX) $(INCPATH) $(CXXFLAGS) -c -o /home/meihua/jinkaifeng/github/off_hub/proto/tweet_id.pb.o /home/meihua/jinkaifeng/github/off_hub/proto/tweet_id.pb.cc
/home/meihua/jinkaifeng/github/off_hub/proto/follower.pb.o: \
 /home/meihua/jinkaifeng/github/off_hub/proto/follower.pb.cc \
 /home/meihua/jinkaifeng/github/off_hub/proto/follower.pb.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/common.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/generated_message_util.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/once.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/atomicops.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/platform_macros.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/atomicops_internals_x86_gcc.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/message.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/message_lite.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/descriptor.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/repeated_field.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/type_traits.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/template_util.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/extension_set.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/unknown_field_set.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/io/coded_stream.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/wire_format_lite_inl.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/wire_format_lite.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/generated_message_reflection.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/generated_enum_reflection.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/reflection_ops.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/wire_format.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/descriptor.pb.h
	$(CXX) $(INCPATH) $(CXXFLAGS) -c -o /home/meihua/jinkaifeng/github/off_hub/proto/follower.pb.o /home/meihua/jinkaifeng/github/off_hub/proto/follower.pb.cc
/home/meihua/jinkaifeng/github/off_hub/interface/post_service_constants.o: \
 /home/meihua/jinkaifeng/github/off_hub/interface/post_service_constants.cpp \
 /home/meihua/jinkaifeng/github/off_hub/interface/post_service_constants.h \
 /home/meihua/jinkaifeng/github/off_hub/interface/post_service_types.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/Thrift.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/transport/PlatformSocket.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/thrift-config.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/config.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/TLogging.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/TApplicationException.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/protocol/TProtocol.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/transport/TTransport.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/transport/TTransportException.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/protocol/TProtocolException.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/cxxfunctional.h
	$(CXX) $(INCPATH) $(CXXFLAGS) -c -o /home/meihua/jinkaifeng/github/off_hub/interface/post_service_constants.o /home/meihua/jinkaifeng/github/off_hub/interface/post_service_constants.cpp
/home/meihua/jinkaifeng/github/off_hub/task/handler/broadcast_post_task.o: \
 /home/meihua/jinkaifeng/github/off_hub/task/handler/broadcast_post_task.cpp \
 /home/meihua/jinkaifeng/github/off_hub/task/handler/../../util/timer.h \
 /home/meihua/jinkaifeng/github/off_hub/task/handler/broadcast_post_task.h \
 /home/meihua/jinkaifeng/github/off_hub/task/handler/base_task.h \
 /home/meihua/jinkaifeng/github/off_hub/../glog/include/glog/logging.h \
 /home/meihua/jinkaifeng/github/off_hub/../gflags/include/gflags/gflags.h \
 /home/meihua/jinkaifeng/github/off_hub/../gflags/include/gflags/gflags_declare.h \
 /home/meihua/jinkaifeng/github/off_hub/../glog/include/glog/log_severity.h \
 /home/meihua/jinkaifeng/github/off_hub/../glog/include/glog/vlog_is_on.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/transport/TSocket.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/transport/TTransport.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/Thrift.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/transport/PlatformSocket.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/thrift-config.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/config.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/TLogging.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/transport/TTransportException.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/transport/TVirtualTransport.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/transport/TServerSocket.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/transport/TServerTransport.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/cxxfunctional.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/transport/TBufferTransports.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/protocol/TBinaryProtocol.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/protocol/TProtocol.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/protocol/TProtocolException.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/protocol/TVirtualProtocol.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/protocol/TBinaryProtocol.tcc \
 /home/meihua/jinkaifeng/github/off_hub/task/handler/../thread_context.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql_proxy/output/include/mysql_proxy.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/mysql.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/mysql_version.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/mysql_com.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/mysql_time.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/my_list.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/mysql/client_plugin.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/mysql/plugin_auth_common.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/typelib.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/my_alloc.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/mysql/psi/psi_memory.h \
 /home/meihua/jinkaifeng/github/off_hub/../mysql-connector/include/mysql/psi/psi_base.h \
 /home/meihua/jinkaifeng/github/off_hub/../redis_proxy/output/include/redis_proxy.h \
 /home/meihua/jinkaifeng/github/off_hub/task/handler/../../proto/follower.pb.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/common.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/generated_message_util.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/once.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/atomicops.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/platform_macros.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/atomicops_internals_x86_gcc.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/message.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/message_lite.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/descriptor.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/repeated_field.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/type_traits.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/stubs/template_util.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/extension_set.h \
 /home/meihua/jinkaifeng/github/off_hub/../protobuf/include/google/protobuf/unknown_field_set.h \
 /home/meihua/jinkaifeng/github/off_hub/task/handler/../../proto/tweet_id.pb.h \
 /home/meihua/jinkaifeng/github/off_hub/task/handler/../../flag.h \
 /home/meihua/jinkaifeng/github/off_hub/../gflags/include/google/gflags.h \
 /home/meihua/jinkaifeng/github/off_hub/task/handler/../../interface/MessageServer.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/TDispatchProcessor.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/TProcessor.h \
 /home/meihua/jinkaifeng/github/off_hub/task/handler/../../interface/system_message_types.h \
 /home/meihua/jinkaifeng/github/off_hub/../thrift/include/thrift/TApplicationException.h \
 /home/meihua/jinkaifeng/github/off_hub/task/handler/../../interface/post_service_types.h
	$(CXX) $(INCPATH) $(CXXFLAGS) -c -o /home/meihua/jinkaifeng/github/off_hub/task/handler/broadcast_post_task.o /home/meihua/jinkaifeng/github/off_hub/task/handler/broadcast_post_task.cpp


