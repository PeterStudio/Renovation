//
//  SearchViewController.h
//  Renovation
//
//  Created by duwen on 15/6/3.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "PTViewController.h"
#import <BaiduMapAPI/BMapKit.h>
#import "SVProgressHUD.h"

@interface SearchViewController : PTViewController<UITableViewDataSource,UITableViewDelegate,BMKPoiSearchDelegate,UITextFieldDelegate>
{
    BMKPoiSearch* _poisearch;
}

@property (strong, nonatomic) IBOutlet UITableView *mainTableView;
@property (strong, nonatomic) UITableViewCell *prototypeCell;
@property (strong, nonatomic) IBOutlet UITextField *searchTF;

@property(nonatomic,copy)void (^callBack)(double lat,double lng,NSString * name,NSString * content);

@end
