//
//  RootViewController.h
//  Renovation
//
//  Created by duwen on 15/5/27.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "PTViewController.h"
#import "NearWorkersViewController.h"
#import "HomeViewController.h"
@interface RootViewController : PTViewController
@property (nonatomic, copy) HomeViewController * homeVC;
@property (nonatomic, copy) NearWorkersViewController * nearWorkersVC;
@property (strong, nonatomic) UIViewController *currentVC;
@end
