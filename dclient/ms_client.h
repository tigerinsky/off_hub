#ifndef __MS_CLIENT_H_
#define __MS_CLIENT_H_

#include "thrift/protocol/TBinaryProtocol.h"
#include "thrift/transport/TSocket.h"
#include "thrift/transport/TTransportUtils.h"
#include "../interface/system_message_types.h"
#include "../interface/MessageServer.h"

using namespace std;
using namespace apache::thrift;
using namespace apache::thrift::protocol;
using namespace apache::thrift::transport;

namespace tis{

class MsClient {
    private:
        boost::shared_ptr<TTransport> socket;
        boost::shared_ptr<TTransport> transport;
        boost::shared_ptr<TProtocol> protocol;
        MessageServerClient client;

    public:
        MsClient(const char* host, const int port):socket(new TSocket(host, port)), transport(new TFramedTransport(socket)), protocol(new TBinaryProtocol(transport)), client(protocol) {
        };
        void send_system_msg(const SystemMessage& sMsg); 
        int32_t set_read(const int32_t sMsgId); 
        int32_t set_delete(const int32_t sMsgId); 
        int32_t clear_red_by_uid(const int32_t uid, const int32_t mType, const int32_t num, const int32_t from_uid); 
        void new_tweet_notify(const NewTweetNotifyRequest& request); 
        void mis_notify(const MisRequest& request); 
        //int32_t update_config(const int32_t key, const std::string& value); 
        int32_t get_num(const int32_t uid, const int32_t queue_type); 
        int32_t optag(const OpTagRequest& request);

        ~MsClient() {
            if (NULL != transport) {
                transport->close();
            }
        };
};
};
#endif
