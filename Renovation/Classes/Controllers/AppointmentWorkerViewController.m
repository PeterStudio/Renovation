//
//  AppointmentWorkerViewController.m
//  Renovation
//
//  Created by duwen on 15/6/4.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "AppointmentWorkerViewController.h"

@interface AppointmentWorkerViewController ()

@end

@implementation AppointmentWorkerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}











/**
 *  房屋信息
 *
 *  @param sender
 */
- (IBAction)button1Click:(id)sender {
}

/**
 *  所在小区
 *
 *  @param sender
 */
- (IBAction)button2Click:(id)sender {
}

/**
 *  户型
 *
 *  @param sender
 */
- (IBAction)button3Click:(id)sender {
}



- (IBAction)typeButtonSelected:(id)sender {
    for (UIButton * btn in _typeBtnArray) {
        [btn setSelected:NO];
    }
    UIButton * btn1 = (UIButton *)sender;
    [btn1 setSelected:YES];
}


- (IBAction)submitButtonSelected:(id)sender {
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
