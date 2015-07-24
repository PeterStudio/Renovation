//
//  NearSiteListModel.h
//  Renovation
//
//  Created by duwen on 15/6/4.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "BaseModel.h"

@protocol NearSiteModel <NSObject>
@end
@interface NearSiteModel : JSONModel
@property (nonatomic, copy) NSString<Optional> * nearbySiteId;
@property (nonatomic, copy) NSString<Optional> * name;
@property (nonatomic, copy) NSString<Optional> * headUrl;
@property (nonatomic, copy) NSString<Optional> * distance;
@property (nonatomic, copy) NSString<Optional> * num;
@property (nonatomic, copy) NSString<Optional> * lat;
@property (nonatomic, copy) NSString<Optional> * lng;
@end

@interface NearSiteListModel : BaseModel
@property (nonatomic, copy) NSArray<NearSiteModel, Optional> * doc;
@end
