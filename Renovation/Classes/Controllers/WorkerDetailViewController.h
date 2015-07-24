//
//  WorkerDetailViewController.h
//  Renovation
//
//  Created by duwen on 15/6/3.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "PTViewController.h"
#import "RatingBar.h"
#import "AppService.h"


@interface WorkerDetailViewController : PTViewControllerWithBack<UITableViewDelegate, UITableViewDataSource,UITextViewDelegate>
@property (strong, nonatomic) NSString * contractorId;
@property (strong, nonatomic) NSString * workerName;
@property (strong, nonatomic) UITableViewCell *firstCell;
@property (strong, nonatomic) UITableViewCell *secondCell;

@property (strong, nonatomic) IBOutlet UIImageView *headImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *appointmentNumLabel;
@property (strong, nonatomic) IBOutlet RatingBar *ratingBarView;

@property (strong, nonatomic) IBOutlet UILabel *FromLabel;
@property (strong, nonatomic) IBOutlet UILabel *yearLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;

@property (strong, nonatomic) IBOutlet UILabel *currentWorkNumLabel;
@property (strong, nonatomic) IBOutlet UILabel *currentRecommendLabel;


@property (strong, nonatomic) IBOutlet UITableView *TableView1;


@property (strong, nonatomic) IBOutlet UIView *RecommendListView;
@property (strong, nonatomic) IBOutlet UITableView *TableView2;
@property (strong, nonatomic) IBOutlet UIButton *recommendBtn;


@property (strong, nonatomic) IBOutlet UIScrollView *scrollerView;
@property (strong, nonatomic) IBOutlet RatingBar *sRateBarView;
@property (strong, nonatomic) IBOutlet UITextView *wTextView;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;

@property (strong, nonatomic) IBOutlet UILabel *placeholdLab;



@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomLC;

@end
