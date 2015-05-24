#include <iostream>

#include "glog/logging.h"
#include "ms_client.h"

namespace tis {
    void MsClient::send_system_msg(const SystemMessage& request) {
        try {
            transport->open();
            ret = client.send_system_msg(request);
        } catch (TException& tx) {
            LOG(WARNING) << "send system msg exception, msg["<<tx.what()<<"]";
        }
        if (NULL != transport) {
            transport->close();
        }
    }

    int32_t MsClient::set_read(const int32_t sMsgId) {
        ret = -1;
        try {
            transport->open();
            ret = client.set_read(sMsgId); 
        } catch (TException& tx) {
            LOG(WARNING) << "set read  exception, msg["<<tx.what()<<"]";
        }

        if (NULL != transport) {
            transport->close();
        }
    }

    int32_t MsClient::set_delete(const int32_t sMsgId) {
        ret = -1;
        try {
            transport->open();
            ret = client.set_delete(sMsgId); 
        } catch (TException& tx) {
            LOG(WARNING) << "set delete exception, msg["<<tx.what()<<"]";
        }

        if (NULL != transport) {
            transport->close();
        }

        return ret;
    }

    int32_t clear_red_by_uid(const int32_t uid, const int32_t mType, const int32_t num, const int32_t from_uid) {
        ret = -1;
        try {
            transport->open();
            ret = client.clear_red_by_uid(uid, mType, num, from_uid);
        } catch (TException& tx) {
            LOG(WARNING) << "clear red exception, msg["<<tx.what()<<"]";
        }

        if (NULL != transport) {
            transport->close();
        }

        return ret;
    }

    void mis_notify(const MisRequest& request) {
        try {
            transport->open();
            client.mis_notify(request);
        } catch (TException& tx) {
            LOG(WARNING) << "mis notify exception, msg["<<tx.what()<<"]";
        }

        if (NULL != transport) {
            transport->close();
        }

        return ret;
    }

    int32_t optag(const OpTagRequest& request) {
        ret = -1;
        try {
            transport->open();
            ret = client.optag(request);
        } catch (TException& tx) {
            LOG(WARNING) << "op tag exception, msg["<<tx.what()<<"]";
        }

        if (NULL != transport) {
            transport->close();
        }

        return ret;
    }
};//namespace
