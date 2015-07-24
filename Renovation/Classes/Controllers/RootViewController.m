//
//  RootViewController.m
//  Renovation
//
//  Created by duwen on 15/5/27.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "RootViewController.h"
#import "PersionViewController.h"

@interface RootViewController ()
{
    BOOL isHomeVC;
}
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isHomeVC = YES;
    
    [self customNavView];
    
    _homeVC = [[HomeViewController alloc] init];
    _homeVC.view.frame = self.view.bounds;
    _nearWorkersVC = [[NearWorkersViewController alloc] init];
    _nearWorkersVC.view.frame = self.view.bounds;
    
    [self addChildViewController:_homeVC];
    [self addChildViewController:_nearWorkersVC];
    
    [self.view addSubview:self.nearWorkersVC.view];
    [self.view addSubview:self.homeVC.view];
    
    self.currentVC = self.homeVC;
    
    
}


- (void)customNavView{
    UIImage * leftImg = [UIImage imageNamed:@"user_head"];
    UIImage * rightImg = [UIImage imageNamed:@"icon01"];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:leftImg forState:UIControlStateNormal];
    [leftBtn setFrame:CGRectMake(0, 0, leftImg.size.width, leftImg.size.height)];
    [leftBtn addTarget:self action:@selector(myInfoVC) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:rightImg forState:UIControlStateNormal];
    [rightBtn setFrame:CGRectMake(0, 0, rightImg.size.width, rightImg.size.height)];
    [rightBtn addTarget:self action:@selector(renovationListVC) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTag:100];
    UIBarButtonItem * rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    UIImage * iconImg = [UIImage imageNamed:@"logo01"];
    UIImage * titleImg = [UIImage imageNamed:@"logo02"];
    UIView * customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iconImg.size.width + titleImg.size.width + 9, 44)];
    UIImageView * icon = [[UIImageView alloc] init];
    [icon setImage:iconImg];
    [icon setFrame:CGRectMake(0, (customView.frame.size.height - iconImg.size.height) / 2, iconImg.size.width, iconImg.size.height)];
    [customView addSubview:icon];
    
    UIImageView * title = [[UIImageView alloc] init];
    [title setFrame:CGRectMake(icon.frame.origin.x + icon.frame.size.width + 9, (customView.frame.size.height - titleImg.size.height) / 2, titleImg.size.width, titleImg.size.height)];
    [title setImage:titleImg];
    [customView addSubview:title];
    self.navigationItem.titleView = customView;
}

- (void)myInfoVC{
    PersionViewController * vc = [[PersionViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)renovationListVC{
    if (isHomeVC) {
        isHomeVC = NO;
        [self replaceController:self.currentVC newController:self.nearWorkersVC];
    }else{
        isHomeVC = YES;
        [self replaceController:self.currentVC newController:self.homeVC];
    }
}

- (void)replaceController:(UIViewController *)oldController newController:(UIViewController *)newController
{
    if (oldController == newController) {
        return;
    }
    [self addChildViewController:newController];
    int obj = UIViewAnimationOptionTransitionFlipFromLeft;
    
    UIImage * rightImg = [UIImage imageNamed:@"top_icon01"];
    UIButton * btn = (UIButton *)[self.navigationItem.rightBarButtonItem.customView viewWithTag:100];
    if (isHomeVC) {
        rightImg = [UIImage imageNamed:@"icon01"];
        obj = UIViewAnimationOptionTransitionFlipFromRight;
    }
    [btn setImage:rightImg forState:UIControlStateNormal];
    [self transitionFromViewController:oldController toViewController:newController duration:0.35 options:obj animations:nil completion:^(BOOL finished) {
        if (finished) {
            [newController didMoveToParentViewController:self];
            [oldController willMoveToParentViewController:nil];
            [oldController removeFromParentViewController];
            self.currentVC = newController;
        }else{
            self.currentVC = oldController;
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
