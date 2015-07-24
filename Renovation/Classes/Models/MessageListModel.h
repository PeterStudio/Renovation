//
//  MessageListModel.h
//  Renovation
//
//  Created by duwen on 15/6/4.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "BaseModel.h"

@protocol MessageModel <NSObject>
@end
@interface MessageModel : JSONModel
@property (nonatomic, copy) NSString<Optional> * thumbnailUrl;
@property (nonatomic, copy) NSString<Optional> * HDUrl;
@end

@interface MessageListModel : BaseModel
@property (nonatomic, copy) NSArray<MessageModel, Optional> * doc;
@end
