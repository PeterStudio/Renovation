//
//  AppointmentWorkerViewController.h
//  Renovation
//
//  Created by duwen on 15/6/4.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "PTViewController.h"
#import "RatingBar.h"


@interface AppointmentWorkerViewController : PTViewControllerWithBack

@property (strong, nonatomic) IBOutlet UIImageView *headImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *appointmentNumLab;
@property (strong, nonatomic) IBOutlet RatingBar *rateBarView;

@property (strong, nonatomic) IBOutlet UILabel *infoLab1;
@property (strong, nonatomic) IBOutlet UILabel *infoLab2;
@property (strong, nonatomic) IBOutlet UILabel *infoLab3;

@property (strong, nonatomic) IBOutlet UITextField *infoTF1;
@property (strong, nonatomic) IBOutlet UITextField *infoTF2;


@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *typeBtnArray;





@end
