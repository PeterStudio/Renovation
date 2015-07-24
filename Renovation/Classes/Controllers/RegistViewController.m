//
//  RegistViewController.m
//  Renovation
//
//  Created by duwen on 15/5/19.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "RegistViewController.h"
#import "PTDefine.h"
#import "SVProgressHUD.h"
#import "RegexKitLite.h"
//#import "HomeViewController.h"
#import "RootViewController.h"
#import "AppService.h"
#import "UserModel.h"
#import "UIDevice+IdentifierAddition.h"

#import "MyAppointmentViewController.h"
#import "HomeSelectViewController.h"


@interface RegistViewController ()

@end

@implementation RegistViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:UIColorFromRGB(0xefefef)];
    
    [self customNav];
    [_checkButton backGroundCustomNorImage:@"reg_bg01" selImage:@"reg_bg01_1"];
    [_sureButton backGroundCustomNorImage:@"reg_btn01_1" selImage:@"reg_btn01"];
    _sureButton.titleLabel.textColor = UIColorFromRGB(0x6c6c6c);
    
    
    
    
//    UIButton * cityButton_ = [UIButton buttonWithType:UIButtonTypeCustom];
//    cityButton_.frame = CGRectMake(0, 0, 80, 44);
//    [cityButton_ setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
//    cityButton_.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    cityButton_.titleLabel.minimumScaleFactor = .7;
//    cityButton_.titleLabel.adjustsFontSizeToFitWidth = YES;
//    cityButton_.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
//    [cityButton_ addTarget:self action:@selector(showAreaSelector) forControlEvents:UIControlEventTouchUpInside];
//    [cityButton_ setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    cityButton_.titleLabel.font = [UIFont boldSystemFontOfSize:16.f];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cityButton_];
    
}

- (void)customNav{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [RGB(237,132,59) CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    self.title = @"业主注册";
    UIColor * color = [UIColor whiteColor];
    NSDictionary * dict = [NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    self.navigationController.navigationBar.titleTextAttributes = dict;
}


- (IBAction)checkButtonClick:(id)sender {
    [self.view endEditing:YES];
    if (![_phoneTF.text isMatchedByRegex:MOBILE_REGULAR_EXPRESSION]) {
        // 未输入账号
        [SVProgressHUD showErrorWithStatus:@"请输入11位手机号码"];
        return;
    }
    [[AppService sharedManager] request_getcode_Http_phone:_phoneTF.text type:@"0" success:^(id responseObject) {
        BaseModel * baseModel = (BaseModel *)responseObject;
        if ([RETURN_CODE_SUCCESS isEqualToString:baseModel.retcode]) {
            [SVProgressHUD showSuccessWithStatus:baseModel.retinfo];
        }else{
            [SVProgressHUD showErrorWithStatus:baseModel.retinfo];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:OTHER_ERROR_MESSAGE];
    }];
    
    [_checkButton setSelected:YES];
    [_checkButton setUserInteractionEnabled:NO];
    __block int timeout = 59;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [_checkButton setSelected:NO];
                [_checkButton setUserInteractionEnabled:YES];
                [_checkButton setTitle:@"获取短信验证码" forState:UIControlStateNormal];
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2ds后重新获取",seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_checkButton setTitle:strTime forState:UIControlStateNormal];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

- (IBAction)registButtonClick:(id)sender {
    [self.view endEditing:YES];
    
    /*******测试******/
//    MyAppointmentViewController * vc = [[MyAppointmentViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    
    RootViewController * vc = [[RootViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    return;
    
    
    if (![_phoneTF.text isMatchedByRegex:MOBILE_REGULAR_EXPRESSION]) {
        [SVProgressHUD showErrorWithStatus:@"请输入11位手机号码"];
        return;
    }
    
    NSString * checkStr = [_passwordTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (checkStr.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }
    
    NSString * lat = [[NSUserDefaults standardUserDefaults] objectForKey:@"Userlatitude"];
    NSString * lng = [[NSUserDefaults standardUserDefaults] objectForKey:@"Userlongitude"];
    NSString *curVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    if (!curVersion) {
        curVersion=@"1.0";
    }
    //设备号
    NSString *imeiStr = [[UIDevice currentDevice] myGlobalDeviceId];
    [[AppService sharedManager] request_Login_Http_username:_phoneTF.text code:checkStr system:@"1" version:curVersion imei:imeiStr lat:lat lng:lng success:^(id responseObject) {
        UserModel * userModel = (UserModel *)responseObject;
        if ([RETURN_CODE_SUCCESS isEqualToString:userModel.retcode]) {
            [[NSUserDefaults standardUserDefaults] setObject:[userModel.doc toDictionary] forKey:USERINFO];
            [[NSUserDefaults standardUserDefaults] synchronize];
            RootViewController * vc = [[RootViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:userModel.retinfo];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:OTHER_ERROR_MESSAGE];
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
