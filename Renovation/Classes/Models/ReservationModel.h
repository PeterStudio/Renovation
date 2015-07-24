//
//  ReservationModel.h
//  Renovation
//
//  Created by duwen on 15/5/26.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "BaseModel.h"

@protocol PersionModel <NSObject>
@end
@interface PersionModel : JSONModel
@property (nonatomic, copy) NSString<Optional> * contractorId;
@property (nonatomic, copy) NSString<Optional> * name;
@property (nonatomic, copy) NSString<Optional> * headUrl;
@property (nonatomic, copy) NSString<Optional> * star;
@property (nonatomic, copy) NSString<Optional> * homeTown;
@property (nonatomic, copy) NSString<Optional> * year;
@property (nonatomic, copy) NSString<Optional> * distance;
@property (nonatomic, copy) NSString<Optional> * frequency;
@end


@protocol Persion1Model <NSObject>
@end
@interface Persion1Model : JSONModel
@property (nonatomic, copy) NSString<Optional> * address;
@property (nonatomic, copy) NSArray<PersionModel,Optional> * personList;
@end


@protocol ReservationInfoModel <NSObject>
@end
@interface ReservationInfoModel : JSONModel
@property (nonatomic, copy) NSString<Optional> * reservationNum;
@property (nonatomic, copy) NSArray<Persion1Model,Optional> * houseList;
@end

@interface ReservationModel : BaseModel
@property (nonatomic, copy) ReservationInfoModel<Optional> * doc;
@end
