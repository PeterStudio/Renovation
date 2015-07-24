//
//  PersionViewController.m
//  Renovation
//
//  Created by duwen on 15/5/22.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "PersionViewController.h"
#import "MoreViewController.h"
#import "MyAppointmentViewController.h"
#import "MyRepairViewController.h"
#import "NearWorkersViewController.h"
#import "MyInfoViewController.h"

@interface PersionViewController ()

@end

@implementation PersionViewController

//- (void)viewDidAppear:(BOOL)animated{
//    self.navigationController.navigationBarHidden = YES;
//}
//
//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    
//}
//
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    self.navigationController.navigationBarHidden = NO;
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =  @"个人中心";
    
    if (UIScreenHeight == 480) {
        _heightConstraint1.constant = _heightConstraint2.constant = 15;
    }
    // Do any additional setup after loading the view from its nib.
}



- (IBAction)persionInfoTouch:(id)sender {
    MyInfoViewController * vc = [[MyInfoViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)myRepairButtonClick:(id)sender {
    MyRepairViewController * vc = [[MyRepairViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)AppointmentRecordButtonClick:(id)sender {
    MyAppointmentViewController * vc = [[MyAppointmentViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)myInformationButtonClick:(id)sender {
    MyInfoViewController * vc = [[MyInfoViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)contractTermsButtonClick:(id)sender {
    
}

- (IBAction)nearWorkersButtonClick:(id)sender {
    NearWorkersViewController * vc = [[NearWorkersViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)moreButtonClick:(id)sender {
    MoreViewController * vc = [[MoreViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)callButtonClick:(id)sender {
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"4000000878"];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
