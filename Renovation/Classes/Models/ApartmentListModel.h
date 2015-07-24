//
//  ApartmentListModel.h
//  Renovation
//
//  Created by duwen on 15/5/26.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "BaseModel.h"

@protocol ApartmentModel <NSObject>
@end

@interface ApartmentModel : JSONModel
@property (nonatomic, copy) NSString<Optional> * apartment;
@end

@interface ApartmentListModel : BaseModel
@property (nonatomic, copy) NSArray<ApartmentModel,Optional> * doc;
@end
