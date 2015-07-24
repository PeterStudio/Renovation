//
//  DecorationModel.h
//  Renovation
//
//  Created by duwen on 15/5/26.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "BaseModel.h"

@protocol DecorationInfoModel <NSObject>

@end

@interface DecorationInfoModel : JSONModel
@property (nonatomic, copy) NSString<Optional> * paid;
@property (nonatomic, copy) NSString<Optional> * constructing;
@property (nonatomic, copy) NSString<Optional> * completed;
@property (nonatomic, copy) NSString<Optional> * messageNum;
@end

@interface DecorationModel : BaseModel
@property (nonatomic, copy) DecorationInfoModel<Optional> * doc;
@end
