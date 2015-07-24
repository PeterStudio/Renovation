//
//  NearWorkersTableViewCell.h
//  Renovation
//
//  Created by duwen on 15/5/27.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingBar.h"
#import "ForemenListModel.h"
#import "ReservationModel.h"

@interface NearWorkersTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *headImage;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *otherLabel;
@property (strong, nonatomic) IBOutlet UILabel *numLabel;
@property (strong, nonatomic) IBOutlet RatingBar *starView;

- (void)refrashDataWithForemenModel:(ForemenModel *)_foremenModel;

- (void)refrashDataWithPersionModel:(PersionModel *)_persionModel;
@end
