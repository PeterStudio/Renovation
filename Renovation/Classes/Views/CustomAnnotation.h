//
//  CustomAnnotation.h
//  Renovation
//
//  Created by duwen on 15/6/5.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI/BMKPointAnnotation.h>
#import "ForemenListModel.h"

@interface CustomAnnotation : BMKPointAnnotation
@property (nonatomic, strong) NSString * url;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * star;
@property (nonatomic, strong) NSString * siteNum;
@property (nonatomic, strong) NSString * workerID;
@property (nonatomic, strong) ForemenModel * fModel;
@end
