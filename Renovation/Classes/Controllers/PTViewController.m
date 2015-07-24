//
//  PTViewController.m
//  Renovation
//
//  Created by duwen on 15/5/19.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "PTViewController.h"

@interface PTViewController ()

@end

@implementation PTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    UIColor * color = [UIColor blackColor];
    NSDictionary * dict = [NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    self.navigationController.navigationBar.titleTextAttributes = dict;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


@implementation PTViewControllerWithBack

- (void)viewDidLoad{
    UIImage * leftImg = [UIImage imageNamed:@"back02"];
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:leftImg forState:UIControlStateNormal];
    [leftBtn setFrame:CGRectMake(0, 0, leftImg.size.width, leftImg.size.height)];
    [leftBtn addTarget:self action:@selector(clickBackToPopVC) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
}

- (void)clickBackToPopVC{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
