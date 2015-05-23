namespace php offhub 
namespace cpp tis 
namespace py offhub

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

enum SmsType {
    SECURITY  = 0, //验证码短信
}

enum SysMsgType {
    AT = 0,             //@
    MAIL = 1,           //私信
    COMMENT = 2,        //评论
    COMMENT_REPLY = 3,  //回复评论
    COMMENT_DELETE = 4, //删除评论
    FOLLOW = 5,         //关注
    PRAISE = 6,         //点赞
    NEW_TWEET = 7,      //小秘书将讨论推荐到要闻
    NEW_FRIEND = 8,     //好友推荐, 新的可关注好友
    MIS_AUTHENTED = 9,  //mis认证通过
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
    5: required i32 sid,
}

struct SysMsgRequest {
    1: required i32 from_uid,
    2: required SysMsgType action_type,
    3: required list<i32> to_uid,
    4: required i64 content_id = 0,
}

struct MisPushRequest {
    1: required string title='',   //通知标题
    2: required string content, //通知内容
    4: required i32 type, //推送类型,1:app首页,2:指定的wap页面,3:帖子详情页,4:新的好友列表页,5:私信详情页,6:跳转到系统通知列表页
    5: required i64 tid=0,        //与此通知相关的帖子id,可选
    6: required string url='', //与此通知相关的wap url
    7: required i32 send_time=0, //推送时间
    8: required i32 push_task_id=0, //推送任务id
    9: required i32 device_type=0,//0:全平台 1:android 2:ios
    10: required string city,//城市名称，用逗号分隔，如果是全部城市，请只传字符串"all_city"
    11: required string school, //学校名称，用逗号分隔,如果是全部学校，请只传字符串"all_school"
    12: required string ukind_verify, //取两个值，verify，unverify
    13: required i32 is_broadcast,//是否是广播，1是广播，0不是。广播表示给所有设备推送
}

struct SetPushTagRequest {
    1: required i32 uid=0;//用户id
    2: required string xg_device_token='';
    3: required i32 op; //op=1:增加tag, op=2:删除tag
    4: required list<string> tag_list; //需要增加或者删除的tag 列表
}


service PostService{
    void SendNewPost(1:PostServiceRequest request),
    void SendNewEvent(1:EventServiceRequest request),
    void FollowNewEvent(1:FollowEvent event),
    void SendSmsEvent(1:SmsRequest request),
    //下面是对接消息中心
    i32 SendSysMsgEvent(1:SysMsgEvent event),
    i32 SetSysMsgReadEvent(1:i32 sMsgId),
    i32 SetSysMsgDeleteEvent(1:i32 sMsgId),
    i32 ClearRedEvent(1:i32 uid, 2:i32 mType, 3:i32 num=0, 4:i32 from_uid=0),
    void MisPushEvent(1:MisEvent event),

    i32 SetPushTagEvent(1:SetPushTagRequest)
}
