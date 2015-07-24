//
//  SearchTableViewCell.m
//  Renovation
//
//  Created by duwen on 15/6/3.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "SearchTableViewCell.h"

@implementation SearchTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)refrashDataWithTitle:(NSString *)_title content:(NSString *)_content{
    _titleLab.text = _title;
    _contentLab.text = _content;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
