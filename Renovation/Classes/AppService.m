//
//  AppService.m
//  JoJo
//
//  Created by duwen on 15/3/16.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "AppService.h"
#import "AppDelegate.h"
#import "UserModel.h"
#import "DecorationModel.h"
#import "VersionModel.h"
#import "ReservationModel.h"
#import "DecorationsModel.h"
#import "ApartmentListModel.h"
#import "AreaListModel.h"
#import "ForemenListModel.h"
#import "ForemanDetailModel.h"
#import "PayHistoryModel.h"
#import "AmountModel.h"
#import "NearSiteListModel.h"
#import "MessageListModel.h"

static AppService * shareAppServiceManagerInstance = nil;
static dispatch_once_t predicate;
@implementation AppService
+ (AppService *)sharedManager{
    dispatch_once(&predicate, ^{
        shareAppServiceManagerInstance = [[self alloc] init];
    });
    return shareAppServiceManagerInstance;
}

// 登录
- (void)request_Login_Http_username:(NSString *)_username
                               code:(NSString *)_code
                             system:(NSString *)_system
                            version:(NSString *)_version
                               imei:(NSString *)_imei
                                lat:(NSString *)_lat
                                lng:(NSString *)_lng
                            success:(void (^)(id))success
                            failure:(void (^)(NSError *))failure{
    NSDictionary * params = @{@"username":_username
                              ,@"code":_code
                              ,@"system":_system
                              ,@"version":_version
                              ,@"imei":_imei
                              ,@"lat":_lat
                              ,@"lng":_lng};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:HTTP_login_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        UserModel * demoModel = [[UserModel alloc] initWithDictionary:responseObject error:nil];
        NSLog(@"demoModel==%@",demoModel);
        if (success) {
            success(demoModel);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 3.1.2	个人资料修改
- (void)request_modifyInfo_Http_userId:(NSString *)_userId
                                  name:(NSString *)_name
                               address:(NSString *)_address
                                   sex:(NSString *)_sex
                                  file:(NSString *)_file
                               success:(void (^)(id responseObject))success
                               failure:(void (^)(NSError *error))failure{
    NSDictionary * params = @{@"userId":_userId
                              ,@"name":_name
                              ,@"address":_address
                              ,@"sex":_sex};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    [manager POST:HTTP_modifyInfo_URL parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:_file] name:@"file" error:nil];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BaseModel * demoModel = [[BaseModel alloc] initWithDictionary:responseObject error:nil];
        if (success) {
            success(demoModel);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        /*******失败返回处理逻辑**********/
        if (failure) {
            failure(error);
        }
    }];
}

// 3.1.3	装修信息查询
- (void)request_decorationRecords_Http_userId:(NSString *)_userId
                                      success:(void (^)(id responseObject))success
                                      failure:(void (^)(NSError *error))failure{
    NSDictionary * params = @{@"userId":_userId};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:HTTP_decorationRecords_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DecorationModel * demoModel = [[DecorationModel alloc] initWithDictionary:responseObject error:nil];
        NSLog(@"demoModel==%@",demoModel);
        if (success) {
            success(demoModel);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 3.1.4	投诉建议
- (void)request_feedback_Http_userId:(NSString *)_userId
                             content:(NSString *)_content
                             success:(void (^)(id responseObject))success
                             failure:(void (^)(NSError *error))failure{
    NSDictionary * params = @{@"userId":_userId,@"content":_content};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:HTTP_feedback_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BaseModel * demoModel = [[BaseModel alloc] initWithDictionary:responseObject error:nil];
        NSLog(@"demoModel==%@",demoModel);
        if (success) {
            success(demoModel);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 3.1.5	通知服务器发送短信验证码
- (void)request_getcode_Http_phone:(NSString *)_phone
                              type:(NSString *)_type
                           success:(void (^)(id responseObject))success
                           failure:(void (^)(NSError *error))failure{
    NSDictionary * params = @{@"phone":_phone,@"type":_type};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:HTTP_getcode_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BaseModel * demoModel = [[BaseModel alloc] initWithDictionary:responseObject error:nil];
        NSLog(@"demoModel==%@",demoModel);
        if (success) {
            success(demoModel);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 3.1.6	版本更新
- (void)request_update_Http_version:(NSString *)_version
                               type:(NSString *)_type
                               imei:(NSString *)_imei
                            success:(void (^)(id responseObject))success
                            failure:(void (^)(NSError *error))failure{
    NSDictionary * params = @{@"version":_version,@"type":_type,@"imei":_imei};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:HTTP_update_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        VersionModel * demoModel = [[VersionModel alloc] initWithDictionary:responseObject error:nil];
        NSLog(@"demoModel==%@",demoModel);
        if (success) {
            success(demoModel);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 3.1.7	我的预约
- (void)request_reservations_Http_userId:(NSString *)_userId
                                 success:(void (^)(id responseObject))success
                                 failure:(void (^)(NSError *error))failure{
    NSDictionary * params = @{@"userId":_userId};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:HTTP_reservations_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        ReservationModel * demoModel = [[ReservationModel alloc] initWithDictionary:responseObject error:nil];
        NSLog(@"demoModel==%@",demoModel);
        if (success) {
            success(demoModel);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 3.1.8	我的装修
- (void)request_decorations_Http_userId:(NSString *)_userId
                                  state:(NSString *)_state
                                success:(void (^)(id responseObject))success
                                failure:(void (^)(NSError *error))failure{
    NSDictionary * params = nil;
    if (_state == nil) {
        params = @{@"userId":_userId};
    }else{
        params = @{@"userId":_userId,@"state":_state};
    }
//    NSDictionary * params = @{@"userId":_userId,@"state":_state};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:HTTP_decorations_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DecorationsModel * demoModel = [[DecorationsModel alloc] initWithDictionary:responseObject error:nil];
        NSLog(@"demoModel==%@",demoModel);
        if (success) {
            success(demoModel);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

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
                                  failure:(void (^)(NSError *error))failure{
    NSDictionary * params = @{@"userId":_userId
                              ,@"address":_address
                              ,@"community":_community
                              ,@"specificAddress":_specificAddress
                              ,@"apartment":_apartment
                              ,@"area":_area
                              ,@"type":_type
                              ,@"foremanId":_foremanId};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:HTTP_addDecoration_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BaseModel * demoModel = [[BaseModel alloc] initWithDictionary:responseObject error:nil];
        NSLog(@"demoModel==%@",demoModel);
        if (success) {
            success(demoModel);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 3.1.10	户型查询
- (void)request_queryApartment_Http_success:(void (^)(id responseObject))success
                                    failure:(void (^)(NSError *error))failure{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:HTTP_queryApartment_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        ApartmentListModel * demoModel = [[ApartmentListModel alloc] initWithDictionary:responseObject error:nil];
        NSLog(@"demoModel==%@",demoModel);
        if (success) {
            success(demoModel);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 3.1.11	小区查询
- (void)request_queryArea_Http_address:(NSString *)_address
                               success:(void (^)(id responseObject))success
                               failure:(void (^)(NSError *error))failure{
    NSDictionary * params = @{@"address":_address};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:HTTP_queryArea_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        AreaListModel * demoModel = [[AreaListModel alloc] initWithDictionary:responseObject error:nil];
        NSLog(@"demoModel==%@",demoModel);
        if (success) {
            success(demoModel);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 3.1.12	附件工长
- (void)request_nearbyForemen_Http_lat:(NSString *)_lat
                                   lng:(NSString *)_lng
                              adddress:(NSString *)_adddress
                                  page:(NSString *)_page
                                   num:(NSString *)_num
                             queryTime:(NSString *)_queryTime
                               success:(void (^)(id responseObject))success
                               failure:(void (^)(NSError *error))failure{
    NSDictionary * params = nil;
    if ([@"FIRST" isEqualToString:_queryTime]) {
        params = @{@"lat":_lat,@"lng":_lng,@"adddress":_adddress,@"page":_page,@"num":_num};
    }else{
        params = @{@"lat":_lat,@"lng":_lng,@"adddress":_adddress,@"page":_page,@"num":_num,@"queryTime":_queryTime};
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    [manager POST:HTTP_nearbyForemen_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        ForemenListModel * demoModel = [[ForemenListModel alloc] initWithDictionary:responseObject error:nil];
        if (success) {
            success(demoModel);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

/******************************************/
// 3.1.13	附件工地（暂定）
- (void)request_nearbySite_Http_lat:(NSString *)_lat
                                lng:(NSString *)_lng
                           adddress:(NSString *)_adddress
                            success:(void (^)(id responseObject))success
                            failure:(void (^)(NSError *error))failure{
    NSDictionary * params = @{@"lat":_lat,@"lng":_lng,@"adddress":_adddress};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:HTTP_nearbySite_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NearSiteListModel * demoModel = [[NearSiteListModel alloc] initWithDictionary:responseObject error:nil];
        NSLog(@"demoModel==%@",demoModel);
        if (success) {
            success(demoModel);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/******************************************/

// 3.1.14	工长详情
- (void)request_foremanDetail_Http_contractorId:(NSString *)_contractorId
                                        success:(void (^)(id responseObject))success
                                        failure:(void (^)(NSError *error))failure{
    NSDictionary * params = @{@"contractorId":_contractorId};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:HTTP_foremanDetail_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        ForemanDetailModel * demoModel = [[ForemanDetailModel alloc] initWithDictionary:responseObject error:nil];
        NSLog(@"demoModel==%@",demoModel);
        if (success) {
            success(demoModel);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 3.1.15	付款记录
- (void)request_payHistory_Http_userId:(NSString *)_userId
                               success:(void (^)(id responseObject))success
                               failure:(void (^)(NSError *error))failure{
    NSDictionary * params = @{@"userId":_userId};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:HTTP_payHistory_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        PayHistoryModel * demoModel = [[PayHistoryModel alloc] initWithDictionary:responseObject error:nil];
        NSLog(@"demoModel==%@",demoModel);
        if (success) {
            success(demoModel);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 3.1.16	预约工长
- (void)request_reservate_Http_homeId:(NSString *)_homeId
                               userId:(NSString *)_userId
                         contractorId:(NSString *)_contractorId
                              success:(void (^)(id responseObject))success
                              failure:(void (^)(NSError *error))failure{
    NSDictionary * params = @{@"homeId":_homeId,@"userId":_userId};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:HTTP_reservate_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BaseModel * demoModel = [[BaseModel alloc] initWithDictionary:responseObject error:nil];
        NSLog(@"demoModel==%@",demoModel);
        if (success) {
            success(demoModel);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 3.1.17	在线支付查询
- (void)request_paymentAmount_Http_homeId:(NSString *)_homeId
                                   userId:(NSString *)_userId
                                  success:(void (^)(id responseObject))success
                                  failure:(void (^)(NSError *error))failure{
    NSDictionary * params = @{@"homeId":_homeId,@"userId":_userId};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:HTTP_paymentAmount_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        AmountModel * demoModel = [[AmountModel alloc] initWithDictionary:responseObject error:nil];
        NSLog(@"demoModel==%@",demoModel);
        if (success) {
            success(demoModel);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 3.1.18	跟工长聊天（服务器累积此工长跟不同人的聊天次数，工长端需要获取）
- (void)request_chat_Http_userId:(NSString *)_userId
                    contractorId:(NSString *)_contractorId
                         success:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure{
    NSDictionary * params = @{@"userId":_userId,@"contractorId":_contractorId};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:HTTP_chat_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BaseModel * demoModel = [[BaseModel alloc] initWithDictionary:responseObject error:nil];
        NSLog(@"demoModel==%@",demoModel);
        if (success) {
            success(demoModel);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 3.1.19	提交评价
- (void)request_appraise_Http_userId:(NSString *)_userId
                        contractorId:(NSString *)_contractorId
                             content:(NSString *)_content
                               start:(NSString *)_start
                             success:(void (^)(id responseObject))success
                             failure:(void (^)(NSError *error))failure{
    NSDictionary * params = @{@"userId":_userId,@"contractorId":_contractorId,@"content":_content,@"start":_start};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:HTTP_appraise_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BaseModel * demoModel = [[BaseModel alloc] initWithDictionary:responseObject error:nil];
        NSLog(@"demoModel==%@",demoModel);
        if (success) {
            success(demoModel);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 3.1.20	消息列表
- (void)request_message_Http_userId:(NSString *)_userId
                            success:(void (^)(id responseObject))success
                            failure:(void (^)(NSError *error))failure{
    NSDictionary * params = @{@"userId":_userId};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:HTTP_message_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        MessageListModel * demoModel = [[MessageListModel alloc] initWithDictionary:responseObject error:nil];
        NSLog(@"demoModel==%@",demoModel);
        if (success) {
            success(demoModel);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
