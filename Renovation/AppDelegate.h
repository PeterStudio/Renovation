//
//  AppDelegate.h
//  Renovation
//
//  Created by duwen on 15/5/18.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI/BMapKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKLocationServiceDelegate,UIAlertViewDelegate>
{
    BMKMapManager* _mapManager;
    BMKLocationService* _locService;
}
@property (strong, nonatomic) UIWindow *window;


@end

