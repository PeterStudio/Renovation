//
//  MyInfoViewController.m
//  Renovation
//
//  Created by duwen on 15/6/3.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "MyInfoViewController.h"

@interface MyInfoViewController ()

@end

@implementation MyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的资料";
    [_headIV setImage:[UIImage imageNamed:@"ghead"]];
    _headIV.layer.masksToBounds = YES;
    _headIV.layer.cornerRadius = 30;
    

    
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)resignTF:(id)sender {
    [_nameTF resignFirstResponder];
    [_addressTF resignFirstResponder];
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
