namespace php offhub 
namespace cpp tis 
namespace py tis 

struct PostServiceRequest{
    1: i32 tid,
    2: i32 uid,
    3: i32 industry,
    4: string title = "",
    5: string content,
    6: i64 ctime,
    7: i32 parent_tid = -1,
    8: i32 origin_tid = -1,
    9: i32 is_essence = 0,
    10: string img = "",
}

enum EventType {
    FORWARD = 0, //转发
    COMMENT = 1, //评论
    ZAN = 2, //点赞
    ZAN_CANCEL = 3, //取消点赞
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
}

service PostService{
    void SendNewPost(1:PostServiceRequest request),
    void SendNewEvent(1:EventServiceRequest request),
    void FollowNewEvent(1:FollowEvent event),
    void SendSmsEvent(1:SmsRequest request),
}
