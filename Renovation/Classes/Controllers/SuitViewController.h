//
//  SuitViewController.h
//  Renovation
//
//  Created by duwen on 15/5/23.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "PTViewController.h"

@interface SuitViewController : PTViewControllerWithBack<UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UIButton *submitButton;
@property (strong, nonatomic) IBOutlet UITextView *contentTV;
@property (strong, nonatomic) IBOutlet UILabel *placeholdLab;




@end
