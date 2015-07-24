//
//  NearWorkersViewController.h
//  Renovation
//
//  Created by duwen on 15/5/27.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "PTViewController.h"
#import "NearWorkersTableViewCell.h"
@interface NearWorkersViewController : PTViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *mainTableView;
@property (strong, nonatomic) UITableViewCell *prototypeCell;
@property (strong, nonatomic) IBOutlet UILabel *locationLab;


@end
