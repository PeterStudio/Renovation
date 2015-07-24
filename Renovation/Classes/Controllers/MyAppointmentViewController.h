//
//  MyAppointmentViewController.h
//  Renovation
//
//  Created by duwen on 15/6/2.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "PTViewController.h"

@interface MyAppointmentViewController : PTViewControllerWithBack<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *RepairNumLabel;
@property (strong, nonatomic) IBOutlet UILabel *appointmentNumLabel;
@property (strong, nonatomic) IBOutlet UITableView *mainTableView;
@property (strong, nonatomic) UITableViewCell *prototypeCell;
@end
