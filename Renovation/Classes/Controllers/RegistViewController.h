//
//  RegistViewController.h
//  Renovation
//
//  Created by duwen on 15/5/19.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+PTCustom.h"

@interface RegistViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *checkButton;
@property (strong, nonatomic) IBOutlet UIButton *sureButton;

@property (strong, nonatomic) IBOutlet UITextField *phoneTF;
@property (strong, nonatomic) IBOutlet UITextField *passwordTF;


@end
