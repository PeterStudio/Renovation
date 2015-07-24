//
//  DecorationsModel.h
//  Renovation
//
//  Created by duwen on 15/5/26.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "BaseModel.h"

@protocol HomeModel <NSObject>
@end

@interface HomeModel : JSONModel
@property (nonatomic, copy) NSString<Optional> * homeId;
@property (nonatomic, copy) NSString<Optional> * address;
@property (nonatomic, copy) NSString<Optional> * name;
@property (nonatomic, copy) NSString<Optional> * tel;
@property (nonatomic, copy) NSString<Optional> * state;
@property (nonatomic, copy) NSString<Optional> * contractorId;
@end

@protocol DecorationsInfoModel <NSObject>
@end

@interface DecorationsInfoModel : JSONModel
@property (nonatomic, copy) NSString<Optional> * reservationNum;
@property (nonatomic, copy) NSArray<HomeModel,Optional> * homeInfo;
@end

@interface DecorationsModel : BaseModel
@property (nonatomic, copy) DecorationsInfoModel<Optional> * doc;
@end
