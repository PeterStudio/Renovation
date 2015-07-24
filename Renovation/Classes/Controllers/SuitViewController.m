//
//  SuitViewController.m
//  Renovation
//
//  Created by duwen on 15/5/23.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "SuitViewController.h"
#import "SVProgressHUD.h"
#import "AppService.h"
#import "BaseModel.h"

@interface SuitViewController ()

@end

@implementation SuitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"投诉建议";
    [self.view setBackgroundColor:UIColorFromRGB(0xe9e9e9)];
    [_submitButton backGroundCustomNorImage:@"btn02" selImage:@"btn02"];
}


- (IBAction)submitBtnClick:(id)sender {
    [self.view endEditing:YES];
    NSString * str = [_contentTV.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([@"" isEqualToString:str]||str==nil) {
        // 请输入内容
        [SVProgressHUD showErrorWithStatus:@"请输入内容"];
        return;
    }else{
        if (str.length > 200) {
            [SVProgressHUD showErrorWithStatus:@"您输入的内容已超过200字"];
            return;
        }
    }
    [SVProgressHUD showSuccessWithStatus:@"投诉成功！"];
    [self.navigationController popViewControllerAnimated:YES];
    
//    NSDictionary * dic = [[NSUserDefaults standardUserDefaults] objectForKey:USERINFO];
//    [SVProgressHUD showWithStatus:@"加载中" maskType:SVProgressHUDMaskTypeClear];
//    [[AppService sharedManager] request_feedback_Http_userId:[dic objectForKey:@"userId"] content:_contentTV.text success:^(id responseObject) {
//        BaseModel * baseModel = (BaseModel *)responseObject;
//        if ([RETURN_CODE_SUCCESS isEqualToString:baseModel.retcode]) {
//            [SVProgressHUD showSuccessWithStatus:baseModel.retinfo];
//            [self.navigationController popViewControllerAnimated:YES];
//        }else{
//            [SVProgressHUD showErrorWithStatus:baseModel.retinfo];
//        }
//    } failure:^(NSError *error) {
//        [SVProgressHUD showErrorWithStatus:OTHER_ERROR_MESSAGE];
//    }];
}

- (void)textViewDidChange:(UITextView *)textView{
    _placeholdLab.hidden = textView.text.length > 0;
    if (textView.markedTextRange == nil && textView.text.length > 200) {
        NSString * str = textView.text;
        textView.text = [str substringToIndex:200];
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];return NO;
    }
    
//    if (textView.text.length > 200 && text.length > range.length) {
//        return NO;
//    }
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
