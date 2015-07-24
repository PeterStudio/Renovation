//
//  AppointmentView.m
//  Renovation
//
//  Created by duwen on 15/6/11.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "AppointmentView.h"
#import "PTDefine.h"

@implementation AppointmentView

- (void)awakeFromNib{
    _numLab.textColor = UIColorFromRGB(0xea8625);
    _addressLab.textColor = UIColorFromRGB(0x333333);
    self.backgroundColor = UIColorFromRGB(0xf1f1f1);
}

- (IBAction)arrowBtnClick:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(arrowBtnSelected:isSelected:)]) {
        [_delegate arrowBtnSelected:_section isSelected:_arrowBtn.selected];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
