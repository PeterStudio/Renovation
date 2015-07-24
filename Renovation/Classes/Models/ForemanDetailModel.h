//
//  ForemanDetailModel.h
//  Renovation
//
//  Created by duwen on 15/5/26.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "BaseModel.h"

@protocol UrlModel <NSObject>
@end

@interface UrlModel : JSONModel
@property (nonatomic, copy) NSString<Optional> * thumbnailUrl;
@property (nonatomic, copy) NSString<Optional> * HDUrl;
@end

@protocol PicModel <NSObject>
@end

@interface PicModel : JSONModel
@property (nonatomic, copy) NSString<Optional> * name;
@property (nonatomic, copy) NSArray<UrlModel, Optional> * url;
@end

@protocol PerformancesModel <NSObject>
@end

@interface PerformancesModel : JSONModel
@property (nonatomic, copy) NSString<Optional> * address;
@property (nonatomic, copy) NSString<Optional> * customerName;
@property (nonatomic, copy) NSArray<PicModel, Optional> * pic;
@end

@protocol AppraiseModel <NSObject>
@end

@interface AppraiseModel : JSONModel
@property (nonatomic, copy) NSString<Optional> * content;
@property (nonatomic, copy) NSString<Optional> * star;
@property (nonatomic, copy) NSString<Optional> * time;
@property (nonatomic, copy) NSString<Optional> * name;
@end

@protocol ForemanDetailInfoModel <NSObject>
@end

@interface ForemanDetailInfoModel : JSONModel
@property (nonatomic, copy) NSString<Optional> * name;
@property (nonatomic, copy) NSString<Optional> * headUrl;
@property (nonatomic, copy) NSString<Optional> * star;
@property (nonatomic, copy) NSString<Optional> * homeTown;
@property (nonatomic, copy) NSString<Optional> * year;
@property (nonatomic, copy) NSString<Optional> * distance;
@property (nonatomic, copy) NSString<Optional> * frequency;
@property (nonatomic, copy) NSArray<PerformancesModel, Optional> * performances;
@property (nonatomic, copy) NSArray<AppraiseModel, Optional> * appraise;
@end

@interface ForemanDetailModel : BaseModel
@property (nonatomic, copy) ForemanDetailInfoModel<Optional> * doc;
@end
