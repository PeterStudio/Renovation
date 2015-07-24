//
//  AreaListModel.h
//  Renovation
//
//  Created by duwen on 15/5/26.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "BaseModel.h"

@protocol AreaModel <NSObject>
@end

@interface AreaModel : JSONModel
@property (nonatomic, copy) NSString<Optional> * area;
@end

@interface AreaListModel : BaseModel
@property (nonatomic, copy) NSArray<AreaModel, Optional> * doc;
@end
