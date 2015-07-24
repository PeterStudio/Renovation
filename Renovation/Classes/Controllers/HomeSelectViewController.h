//
//  HomeSelectViewController.h
//  Renovation
//
//  Created by duwen on 15/6/11.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "PTViewController.h"

@interface HomeSelectViewController : PTViewControllerWithBack<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *mainTableView;
@property(nonatomic,copy)void (^callBack)(NSString * homeID);
@end
