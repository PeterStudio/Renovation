//
//  SearchTableViewCell.h
//  Renovation
//
//  Created by duwen on 15/6/3.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UILabel *contentLab;

- (void)refrashDataWithTitle:(NSString *)_title content:(NSString *)_content;
@end
