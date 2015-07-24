//
//  WorkSiteListTableViewCell.h
//  Renovation
//
//  Created by duwen on 15/6/2.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ForemanDetailModel.h"

@interface WorkSiteListTableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UIImageView *headImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *numLabel;
- (void)refrshWithPicModel:(PicModel *)pModel;

@end
