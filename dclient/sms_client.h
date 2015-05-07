#ifndef push_client_H
#define push_client_H

#include "thrift/protocol/TBinaryProtocol.h"
#include "thrift/transport/TSocket.h"
#include "thrift/transport/TTransportUtils.h"
#include "../interface/sms_types.h"
#include "../interface/SmsService.h"

using namespace std;
using namespace apache::thrift;
using namespace apache::thrift::protocol;
using namespace apache::thrift::transport;

namespace tis{

class SmsClient {
    private:
        boost::shared_ptr<TTransport> socket;
        boost::shared_ptr<TTransport> transport;
        boost::shared_ptr<TProtocol> protocol;
        SmsServiceClient client;

    public:
        SmsClient(const char* host, const int port) :socket(new TSocket(host, port)), transport(new TFramedTransport(socket)), protocol(new TBinaryProtocol(transport)), client(protocol) {
        };
        int32_t send_sms(const SendSMSRequest& request);

        ~SmsClient() {
            if (NULL != transport) {
                transport->close();
            }
        };
};
};
#endif
