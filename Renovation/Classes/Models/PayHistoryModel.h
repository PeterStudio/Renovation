//
//  PayHistoryModel.h
//  Renovation
//
//  Created by duwen on 15/5/26.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "BaseModel.h"

@protocol ScheduleModel <NSObject>
@end

@interface ScheduleModel : JSONModel
@property (nonatomic, copy) NSString<Optional> * time;
@property (nonatomic, copy) NSString<Optional> * phase;
@property (nonatomic, copy) NSString<Optional> * isPay;
@end

@protocol  HomeInfoModel <NSObject>
@end

@interface HomeInfoModel : JSONModel
@property (nonatomic, copy) NSString<Optional> * address;
@property (nonatomic, copy) NSArray<ScheduleModel, Optional> * schedule;
@end

@protocol PayHistoryInfoModel <NSObject>
@end

@interface PayHistoryInfoModel : JSONModel
@property (nonatomic, copy) NSString<Optional> * reservationNum;
@property (nonatomic, copy) NSArray<HomeInfoModel, Optional> * homeInfo;
@end

@interface PayHistoryModel : BaseModel
@property (nonatomic, copy) PayHistoryInfoModel<Optional> * doc;
@end
