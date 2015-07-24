//
//  AppService.h
//  JoJo
//
//  Created by duwen on 15/3/16.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"
#import "NSString+MD5Addition.h"
#import "PTDefine.h"
@interface AppService : NSObject
+ (AppService *)sharedManager;

// 3.1.1	用户登录注册
- (void)request_Login_Http_username:(NSString *)_username
                               code:(NSString *)_code
                             system:(NSString *)_system
                            version:(NSString *)_version
                               imei:(NSString *)_imei
                                lat:(NSString *)_lat
                                lng:(NSString *)_lng
                            success:(void (^)(id responseObject))success
                            failure:(void (^)(NSError *error))failure;

// 3.1.2	个人资料修改
- (void)request_modifyInfo_Http_userId:(NSString *)_userId
                                  name:(NSString *)_name
                               address:(NSString *)_address
                                   sex:(NSString *)_sex
                                  file:(NSString *)_file
                               success:(void (^)(id responseObject))success
                               failure:(void (^)(NSError *error))failure;

// 3.1.3	装修信息查询
- (void)request_decorationRecords_Http_userId:(NSString *)_userId
                                      success:(void (^)(id responseObject))success
                                      failure:(void (^)(NSError *error))failure;

// 3.1.4	投诉建议
- (void)request_feedback_Http_userId:(NSString *)_userId
                             content:(NSString *)_content
                             success:(void (^)(id responseObject))success
                             failure:(void (^)(NSError *error))failure;

// 3.1.5	通知服务器发送短信验证码
- (void)request_getcode_Http_phone:(NSString *)_phone
                              type:(NSString *)_type
                           success:(void (^)(id responseObject))success
                           failure:(void (^)(NSError *error))failure;

// 3.1.6	版本更新
- (void)request_update_Http_version:(NSString *)_version
                               type:(NSString *)_type
                               imei:(NSString *)_imei
                            success:(void (^)(id responseObject))success
                            failure:(void (^)(NSError *error))failure;

// 3.1.7	我的预约
- (void)request_reservations_Http_userId:(NSString *)_userId
                                 success:(void (^)(id responseObject))success
                                 failure:(void (^)(NSError *error))failure;

// 3.1.8	我的装修
- (void)request_decorations_Http_userId:(NSString *)_userId
                                  state:(NSString *)_state
                                success:(void (^)(id responseObject))success
                                failure:(void (^)(NSError *error))failure;

// 3.1.9	新增装修
- (void)request_addDecoration_Http_userId:(NSString *)_userId
                                  address:(NSString *)_address
                                community:(NSString *)_community
                          specificAddress:(NSString *)_specificAddress
                                apartment:(NSString *)_apartment
                                     area:(NSString *)_area
                                     type:(NSString *)_type
                                foremanId:(NSString *)_foremanId
                                  success:(void (^)(id responseObject))success
                                  failure:(void (^)(NSError *error))failure;

// 3.1.10	户型查询
- (void)request_queryApartment_Http_success:(void (^)(id responseObject))success
                                    failure:(void (^)(NSError *error))failure;

// 3.1.11	小区查询
- (void)request_queryArea_Http_address:(NSString *)_address
                               success:(void (^)(id responseObject))success
                               failure:(void (^)(NSError *error))failure;

// 3.1.12	附件工长
- (void)request_nearbyForemen_Http_lat:(NSString *)_lat
                                   lng:(NSString *)_lng
                              adddress:(NSString *)_adddress
                                  page:(NSString *)_page
                                   num:(NSString *)_num
                             queryTime:(NSString *)_queryTime
                               success:(void (^)(id responseObject))success
                               failure:(void (^)(NSError *error))failure;

// 3.1.13	附件工地（暂定）
- (void)request_nearbySite_Http_lat:(NSString *)_lat
                                lng:(NSString *)_lng
                           adddress:(NSString *)_adddress
                            success:(void (^)(id responseObject))success
                            failure:(void (^)(NSError *error))failure;

// 3.1.14	工长详情
- (void)request_foremanDetail_Http_contractorId:(NSString *)_contractorId
                                        success:(void (^)(id responseObject))success
                                        failure:(void (^)(NSError *error))failure;

// 3.1.15	付款记录
- (void)request_payHistory_Http_userId:(NSString *)_userId
                               success:(void (^)(id responseObject))success
                               failure:(void (^)(NSError *error))failure;

// 3.1.16	预约工长
- (void)request_reservate_Http_homeId:(NSString *)_homeId
                               userId:(NSString *)_userId
                         contractorId:(NSString *)_contractorId
                              success:(void (^)(id responseObject))success
                              failure:(void (^)(NSError *error))failure;

// 3.1.17	在线支付查询
- (void)request_paymentAmount_Http_homeId:(NSString *)_homeId
                                   userId:(NSString *)_userId
                                  success:(void (^)(id responseObject))success
                                  failure:(void (^)(NSError *error))failure;

// 3.1.18	跟工长聊天（服务器累积此工长跟不同人的聊天次数，工长端需要获取）
- (void)request_chat_Http_userId:(NSString *)_userId
                    contractorId:(NSString *)_contractorId
                         success:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure;

// 3.1.19	提交评价
- (void)request_appraise_Http_userId:(NSString *)_userId
                        contractorId:(NSString *)_contractorId
                             content:(NSString *)_content
                               start:(NSString *)_start
                         success:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure;
// 3.1.20	消息列表
- (void)request_message_Http_userId:(NSString *)_userId
                             success:(void (^)(id responseObject))success
                             failure:(void (^)(NSError *error))failure;

@end
