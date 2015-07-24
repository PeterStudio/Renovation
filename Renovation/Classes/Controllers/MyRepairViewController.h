//
//  MyRepairViewController.h
//  Renovation
//
//  Created by duwen on 15/6/3.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "PTViewController.h"

@interface MyRepairViewController : PTViewControllerWithBack<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *repairNumLabel;
@property (strong, nonatomic) IBOutlet UILabel *appointMentNumLabel;
@property (strong, nonatomic) IBOutlet UITableView *mainTableView;
@property (strong, nonatomic) UITableViewCell *prototypeCell;
@end
