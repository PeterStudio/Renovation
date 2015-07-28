//
//  NearWorkersTableViewCell.m
//  Renovation
//
//  Created by duwen on 15/5/27.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "NearWorkersTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "PTDefine.h"

@implementation NearWorkersTableViewCell

- (void)awakeFromNib {

    _headImage.layer.masksToBounds = YES;
    _headImage.layer.cornerRadius = _headImage.image.size.height / 2;
    
    _starView.isIndicator = YES;
    [_starView setImageDeselected:@"start_icon01" halfSelected:nil fullSelected:@"start_icon01_1" andDelegate:nil];
}

- (void)refrashDataWithForemenModel:(ForemenModel *)_foremenModel{
//    [_headImage sd_setImageWithURL:[NSURL URLWithString:_foremenModel.headUrl] placeholderImage:nil];
    [_headImage setImage:[UIImage imageNamed:_foremenModel.headUrl]];
    _nameLabel.text = _foremenModel.name;
    _otherLabel.text = [NSString stringWithFormat:@"籍贯：%@   %@年    距离%@公里",_foremenModel.homeTown,_foremenModel.year,_foremenModel.distance];
    NSString * orginStr = [NSString stringWithFormat:@"被预约%@次",_foremenModel.frequency];
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:orginStr];
    NSRange range = [orginStr rangeOfString:_foremenModel.frequency];
    [str beginEditing];
    [str addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xea8625) range:range];
    [str endEditing];
    _numLabel.attributedText = str;
    [_starView displayRating:[_foremenModel.star floatValue]];
}

- (void)refrashDataWithPersionModel:(PersionModel *)_persionModel{
//    [_headImage sd_setImageWithURL:[NSURL URLWithString:_persionModel.headUrl] placeholderImage:nil];
    [_headImage setImage:[UIImage imageNamed:_persionModel.headUrl]];
    
    
    _nameLabel.text = _persionModel.name;
    _otherLabel.text = [NSString stringWithFormat:@"籍贯：%@   %@年    距离%@公里",_persionModel.homeTown,_persionModel.year,_persionModel.distance];
    NSString * orginStr = [NSString stringWithFormat:@"被预约%@次",_persionModel.frequency];
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:orginStr];
    NSRange range = [orginStr rangeOfString:_persionModel.frequency];
    [str beginEditing];
    [str addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xea8625) range:range];
    [str endEditing];
    _numLabel.attributedText = str;
    [_starView displayRating:[_persionModel.star floatValue]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
