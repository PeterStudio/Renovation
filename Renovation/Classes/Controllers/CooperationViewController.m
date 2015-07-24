//
//  CooperationViewController.m
//  Renovation
//
//  Created by duwen on 15/5/22.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "CooperationViewController.h"

@interface CooperationViewController ()

@end

@implementation CooperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商务合作";
    [self.view setBackgroundColor:UIColorFromRGB(0xf9f9f9)];
    
    if (UIScreenHeight == 480) {
        _heightConstraint1.constant = 175;
        _heightConstraint2.constant = 30;
        _heightConstraint3.constant = _heightConstraint4.constant = 13;
    }
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
