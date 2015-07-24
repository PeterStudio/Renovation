//
//  PTDefine.h
//  MirLiDoctor
//
//  Created by duwen on 15/1/16.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#ifndef MirLiDoctor_PTDefine_h
#define MirLiDoctor_PTDefine_h


#endif

//正则表达式
#define EMAIL_REGULAR_EXPRESSION @"^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$"
#define USER_REGULAR_EXPRESSION @"^[0-9A-Za-z_]{6,20}$"
#define PSW_REGULAR_EXPRESSION @"^[A-Za-z0-9_]{6,20}$"
#define PSW_REGULAR_FORLOGIN  @"^[^ ]{6,20}$"
#define MOBILE_REGULAR_EXPRESSION @"^[0-9]{11}$"
#define ZIP_REGULAR_EXPRESSION @"^[0-9]{0,6}$"
#define AUTHCODE_REGULAR_EXPRESSION @"^[0-9]{1,10}$"
#define POSTCODE_REGULAR_EXPRESSION @"^[0-9]{6}$"
//正整数
#define POSITIVE_NUMBER_REGULAR_EXPRESSION   @"^[0-9]*[1-9][0-9]*$"
//非负浮点数
#define POSITIVE_FLOAT_REGULAR_EXPRESSION   @"^\\d+(\\.\\d+)?$"

#define IDNUMBER_REGULAR_EXPRESSION  @"[0-9]{17}([0-9]|[xX])"

#define UmengAppkey @"549967a5fd98c5b998000b0a"

#define RETURN_CODE_SUCCESS                  @"000000"     //成功
#define OTHER_ERROR_MESSAGE   @"请求失败，请稍后再试"
#define NONE_DATA_MESSAGE   @"很抱歉，暂无数据"

#define USERINFO    @"MIRLIUSERINFO"
#define NUMBER_FOR_REQUEST @"10" //一次请求条数
#define DEFAULTPLACEHOLDIMAGE   @"showIcon"
#define USERIMAGEVIEWFILES       @"USERIMAGEVIEWFILES"

// Share
#define SettingShareUrl  @"叮叮装修,欢迎点击下载http://115.29.223.193/doct/appDown.html，邀请您体验"
#define SETTING_CONTENT_SHARE_URL  @"叮叮装修手机应用，邀请您体验，欢迎点击下载。"
#define SHARE_TITLE  @"叮叮装修"
#define ShopEventShareUrl  @"http://115.29.223.193/doct/appDown.html"
#define ShareSuccess  @"分享成功"
#define ShareError  @"取消分享"


//当前设备屏幕高度
#define UIScreenHeight ([[UIScreen mainScreen] bounds].size.height)
#define UIScreenWidth  ([[UIScreen mainScreen] bounds].size.width)
#define RETINA4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
//系统版本
#define CURRENT_VERSION [[UIDevice currentDevice].systemVersion floatValue]
// 医生OR患者
#define ISPATIENT  [[NSUserDefaults standardUserDefaults] boolForKey:@"ISPATIENT"] 
//颜色
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define RGB(a, b, c) [UIColor colorWithRed:(a / 255.0f) green:(b / 255.0f) blue:(c / 255.0f) alpha:1.0f]
#define RGBA(a, b, c, d) [UIColor colorWithRed:(a / 255.0f) green:(b / 255.0f) blue:(c / 255.0f) alpha:d]


/**************************接口**************************/

#define SERVER_URL  @"http://103.244.67.10/"

// 3.1.1	用户登录注册
#define HTTP_login_URL [NSString stringWithFormat:@"%@login", SERVER_URL]
// 3.1.2	个人资料修改
#define HTTP_modifyInfo_URL    [NSString stringWithFormat:@"%@modifyInfo", SERVER_URL]
// 3.1.3	装修信息查询
#define HTTP_decorationRecords_URL  [NSString stringWithFormat:@"%@decorationRecords", SERVER_URL]
// 3.1.4	投诉建议
#define HTTP_feedback_URL  [NSString stringWithFormat:@"%@feedback", SERVER_URL]
// 3.1.5	通知服务器发送短信验证码
#define HTTP_getcode_URL [NSString stringWithFormat:@"%@getcode", SERVER_URL]
// 3.1.6	版本更新
#define HTTP_update_URL     [NSString stringWithFormat:@"%@update", SERVER_URL]
// 3.1.7	我的预约
#define HTTP_reservations_URL  [NSString stringWithFormat:@"%@reservations", SERVER_URL]
// 3.1.8	我的装修
#define HTTP_decorations_URL [NSString stringWithFormat:@"%@decorations", SERVER_URL]
// 3.1.9	新增装修
#define HTTP_addDecoration_URL [NSString stringWithFormat:@"%@addDecoration", SERVER_URL]
// 3.1.10	户型查询
#define HTTP_queryApartment_URL [NSString stringWithFormat:@"%@queryApartment", SERVER_URL]
// 3.1.11	小区查询
#define HTTP_queryArea_URL [NSString stringWithFormat:@"%@queryArea", SERVER_URL]
// 3.1.12	附件工长
#define HTTP_nearbyForemen_URL [NSString stringWithFormat:@"%@nearbyForemen", SERVER_URL]
// 3.1.13	附件工地
#define HTTP_nearbySite_URL [NSString stringWithFormat:@"%@nearbySite", SERVER_URL]
// 3.1.14	工长详情
#define HTTP_foremanDetail_URL [NSString stringWithFormat:@"%@foremanDetail", SERVER_URL]
// 3.1.15	付款记录
#define HTTP_payHistory_URL [NSString stringWithFormat:@"%@payHistory", SERVER_URL]
// 3.1.16	预约工长
#define HTTP_reservate_URL [NSString stringWithFormat:@"%@reservate", SERVER_URL]
// 3.1.17	在线支付查询
#define HTTP_paymentAmount_URL [NSString stringWithFormat:@"%@paymentAmount", SERVER_URL]
// 3.1.18	跟工长聊天（服务器累积此工长跟不同人的聊天次数，工长端需要获取）
#define HTTP_chat_URL [NSString stringWithFormat:@"%@chat", SERVER_URL]
// 3.1.19	提交评价
#define HTTP_appraise_URL [NSString stringWithFormat:@"%@appraise", SERVER_URL]
// 3.1.20	消息列表
#define HTTP_message_URL [NSString stringWithFormat:@"%@message", SERVER_URL]











