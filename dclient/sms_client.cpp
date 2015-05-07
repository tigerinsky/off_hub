#include <iostream>

#include "glog/logging.h"
#include "sms_client.h"

namespace tis {
    int32_t SmsClient::send_sms(const SendSMSRequest& request) {
        int32_t ret = 0;
        try {
            transport->open();
            ret = client.send_sms(request);
        } catch (TException& tx) {
            LOG(WARNING) << "send sms exception, msg["<<tx.what()<<"]";
            ret = 1;
        }
        if (NULL != transport) {
            transport->close();
        }

        return ret;
    }
};
