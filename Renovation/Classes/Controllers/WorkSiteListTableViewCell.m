//
//  WorkSiteListTableViewCell.m
//  Renovation
//
//  Created by duwen on 15/6/2.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "WorkSiteListTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation WorkSiteListTableViewCell

- (void)awakeFromNib {
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = 5.0f;
}

- (void)refrshWithPicModel:(PicModel *)pModel{
    NSArray * arr = [NSArray arrayWithArray:pModel.url];
    if (arr.count > 0) {
        UrlModel * uModel = (UrlModel *)[arr objectAtIndex:0];
//        [_headImageView sd_setImageWithURL:[NSURL URLWithString:uModel.thumbnailUrl] placeholderImage:nil];
        [_headImageView setImage:[UIImage imageNamed:uModel.thumbnailUrl]];
    }
    _nameLabel.text = pModel.name;
    _numLabel.text = [NSString stringWithFormat:@"%lu张",arr.count];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
