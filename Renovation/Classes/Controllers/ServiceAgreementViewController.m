//
//  ServiceAgreementViewController.m
//  Renovation
//
//  Created by duwen on 15/5/23.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "ServiceAgreementViewController.h"

@interface ServiceAgreementViewController ()

@end

@implementation ServiceAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"平台服务协议";
    NSURL *url =[NSURL URLWithString:@"http://www.baidu.com"];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [_serviceWebView loadRequest:request];
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
