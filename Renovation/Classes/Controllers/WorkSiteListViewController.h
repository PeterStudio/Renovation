//
//  WorkSiteListViewController.h
//  Renovation
//
//  Created by duwen on 15/6/2.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "PTViewController.h"
#import "ForemanDetailModel.h"

@interface WorkSiteListViewController : PTViewControllerWithBack<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) PerformancesModel * pModel;
@property (strong, nonatomic) IBOutlet UITableView *mainTableView;
@property (strong, nonatomic) UITableViewCell *prototypeCell;

@end
