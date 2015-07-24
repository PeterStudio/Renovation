//
//  AppointmentView.h
//  Renovation
//
//  Created by duwen on 15/6/11.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AppointmentViewDelegate <NSObject>
- (void)arrowBtnSelected:(NSInteger)section isSelected:(BOOL)_isSelected;
@end

@interface AppointmentView : UIView
@property (assign, nonatomic) id<AppointmentViewDelegate> delegate;
@property (assign, nonatomic) NSInteger section;
@property (strong, nonatomic) IBOutlet UILabel *numLab;
@property (strong, nonatomic) IBOutlet UILabel *addressLab;
@property (strong, nonatomic) IBOutlet UIButton *arrowBtn;
@end
