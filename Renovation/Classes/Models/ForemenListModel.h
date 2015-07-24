//
//  ForemenListModel.h
//  Renovation
//
//  Created by duwen on 15/5/26.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "BaseModel.h"

@protocol ForemenModel <NSObject>
@end

@interface ForemenModel : JSONModel
@property (nonatomic, copy) NSString<Optional> * contractorId;
@property (nonatomic, copy) NSString<Optional> * name;
@property (nonatomic, copy) NSString<Optional> * headUrl;
@property (nonatomic, copy) NSString<Optional> * star;
@property (nonatomic, copy) NSString<Optional> * homeTown;
@property (nonatomic, copy) NSString<Optional> * year;
@property (nonatomic, copy) NSString<Optional> * distance;
@property (nonatomic, copy) NSString<Optional> * frequency;
@property (nonatomic, copy) NSString<Optional> * tel;
@property (nonatomic, copy) NSString<Optional> * lat;
@property (nonatomic, copy) NSString<Optional> * lng;
@end

@interface ForemenListModel : BaseModel
@property (nonatomic, copy)NSString<Optional> * queryTime;
@property (nonatomic, copy)NSArray<ForemenModel,Optional> * doc;
@end
