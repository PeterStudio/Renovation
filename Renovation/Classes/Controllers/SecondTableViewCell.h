//
//  SecondTableViewCell.h
//  Renovation
//
//  Created by duwen on 15/6/8.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingBar.h"
#import "ForemanDetailModel.h"

@interface SecondTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *levelLab;
@property (strong, nonatomic) IBOutlet UILabel *timeLab;
@property (strong, nonatomic) IBOutlet RatingBar *rateView;
@property (strong, nonatomic) IBOutlet UILabel *contentLab;
- (void)refrashWithAppraiseModel:(AppraiseModel *)aModel;
@end
