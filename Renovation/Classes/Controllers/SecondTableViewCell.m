//
//  SecondTableViewCell.m
//  Renovation
//
//  Created by duwen on 15/6/8.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "SecondTableViewCell.h"

@implementation SecondTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _rateView.isIndicator = YES;
    [_rateView setImageDeselected:@"start_icon01" halfSelected:nil fullSelected:@"start_icon01_1" andDelegate:nil];
}

- (void)refrashWithAppraiseModel:(AppraiseModel *)aModel{
    if ([@"0" isEqualToString:aModel.star]) {
        [_rateView displayRating:0.0];
        _levelLab.text = @"";
    }else if ([@"1" isEqualToString:aModel.star]){
        [_rateView displayRating:1.0];
        _levelLab.text = @"很差";
    }else if ([@"2" isEqualToString:aModel.star]){
        [_rateView displayRating:2.0];
        _levelLab.text = @"较差";
    }else if ([@"3" isEqualToString:aModel.star]){
        [_rateView displayRating:3.0];
        _levelLab.text = @"一般";
    }else if ([@"4" isEqualToString:aModel.star]){
        [_rateView displayRating:4.0];
        _levelLab.text = @"满意";
    }else{
        [_rateView displayRating:5.0];
        _levelLab.text = @"非常满意";
    }
    _contentLab.text = aModel.content;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *date = [dateFormatter dateFromString:aModel.time];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    _timeLab.text = strDate;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
