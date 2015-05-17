namespace php offhub 
namespace cpp tis 
namespace py tis 

struct PostServiceRequest{
    1: i64 tid,
    2: i32 uid,
    3: string title = "",
    4: string content = "",
    5: string img = "",
    6: string tags = "",
    7: i32 type,
    8: string f_catalog,
    9: string s_catalog,
    10: i64 ctime,
    11: i64 dtime,
}

enum EventType {
    FORWARD = 0, //转发
    COMMENT = 1, //评论
    ZAN = 2, //点赞
    ZAN_CANCEL = 3, //取消点赞
}

enum SmsType {
    SECURITY  = 0, //验证码短信
}

struct EventServiceRequest {
    1: required EventType type,
    2: required i32 tid,
}

struct FollowEvent {
   1: required i32 uid,
   2: required i32 follower_uid,
}

struct SmsRequest {
   1: required string mobile,
   2: required string content,
   3: required i32 send_time=0,
   4: required SmsType type=0,
}

service PostService{
    void SendNewPost(1:PostServiceRequest request),
    void SendNewEvent(1:EventServiceRequest request),
    void FollowNewEvent(1:FollowEvent event),
    void SendSmsEvent(1:SmsRequest request),
}
