//
//  MoreViewController.m
//  Renovation
//
//  Created by duwen on 15/5/22.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "MoreViewController.h"
#import "CooperationViewController.h"
#import "InvitationFriendsViewController.h"
#import "ServiceAgreementViewController.h"
#import "SuitViewController.h"
@interface MoreViewController ()

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"更多";
    [self.view setBackgroundColor:UIColorFromRGB(0xf9f9f9)];
}


- (IBAction)buttonClick:(id)sender {
    UIButton * btn = (UIButton *)sender;
    switch (btn.tag) {
        case 0:
            // 邀请好友
        {
            InvitationFriendsViewController * vc = [[InvitationFriendsViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
            // 平台服务协议
        {
            ServiceAgreementViewController * vc = [[ServiceAgreementViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
            // 客服热线
        {
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"4000000878"];
            UIWebView * callWebview = [[UIWebView alloc] init];
            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
            [self.view addSubview:callWebview];
        }
            break;
        case 3:
            // 商务合作
        {
            CooperationViewController * vc = [[CooperationViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
            // 我要投诉
        {
            SuitViewController * vc = [[SuitViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
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
