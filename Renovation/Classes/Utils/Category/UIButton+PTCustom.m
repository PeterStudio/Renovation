//
//  UIButton+PTCustom.m
//  Renovation
//
//  Created by duwen on 15/5/19.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "UIButton+PTCustom.h"

@implementation UIButton (PTCustom)

- (void)backGroundCustomNorImage:(NSString *)norImage selImage:(NSString *)selImage{
    UIImage * nor = [[UIImage imageNamed:norImage] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    UIImage * sel = [[UIImage imageNamed:selImage] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    [self setBackgroundImage:nor forState:UIControlStateNormal];
    [self setBackgroundImage:sel forState:UIControlStateHighlighted];
    [self setBackgroundImage:sel forState:UIControlStateSelected];
}


@end
