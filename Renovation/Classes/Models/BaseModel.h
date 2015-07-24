//
//  BaseModel.h
//  MirLiDoctor
//
//  Created by duwen on 15/1/17.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "JSONModel.h"

@interface BaseModel : JSONModel
@property(nonatomic,copy)NSString<Optional> *retcode;                     //返回code
@property(nonatomic,copy)NSString<Optional> *retinfo;                     //返回信息
@end
