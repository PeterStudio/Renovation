//
//  AmountModel.h
//  Renovation
//
//  Created by duwen on 15/5/26.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "BaseModel.h"

@protocol AmountInfoModel <NSObject>

@end

@interface AmountInfoModel : JSONModel
@property (nonatomic, copy) NSString<Optional> * address;
@property (nonatomic, copy) NSString<Optional> * transactionNum;
@property (nonatomic, copy) NSString<Optional> * totalMoney;
@property (nonatomic, copy) NSString<Optional> * last;
@property (nonatomic, copy) NSString<Optional> * need;
@property (nonatomic, copy) NSString<Optional> * phase;
@end

@interface AmountModel : BaseModel
@property (nonatomic, copy) AmountInfoModel<Optional> * doc;
@end
