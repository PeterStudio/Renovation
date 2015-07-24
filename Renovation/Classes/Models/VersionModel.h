//
//  VersionModel.h
//  Renovation
//
//  Created by duwen on 15/5/26.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "BaseModel.h"

@protocol VersionInfoModel <NSObject>

@end

@interface VersionInfoModel : JSONModel
@property (nonatomic, copy) NSString<Optional> * version;
@property (nonatomic, copy) NSString<Optional> * content;
@property (nonatomic, copy) NSString<Optional> * isUpdate;
@property (nonatomic, copy) NSString<Optional> * urlAddress;
@end

@interface VersionModel : BaseModel
@property (nonatomic, copy) VersionInfoModel<Optional> * doc;
@end
