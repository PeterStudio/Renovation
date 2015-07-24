//
//  AppDelegate.m
//  Renovation
//
//  Created by duwen on 15/5/18.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "AppDelegate.h"

#import "PTDefine.h"
//#import "LocationManager.h"
#import "RegistViewController.h"
//#import "HomeViewController.h"
#import "AppService.h"
#import "UIDevice+IdentifierAddition.h"
#import "VersionModel.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];

    
    [self updateVersion];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8) {
        //由于IOS8中定位的授权机制改变 需要进行手动授权
        CLLocationManager  *locationManager = [[CLLocationManager alloc] init];
        //获取授权认证
        [locationManager requestAlwaysAuthorization];
        [locationManager requestWhenInUseAuthorization];
    }
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"nByscOMa0BllCByQrvdZsxVC"  generalDelegate:nil];
    if (ret) {
        _locService = [[BMKLocationService alloc]init];
        _locService.delegate = self;
        [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
        [_locService startUserLocationService];
    }
    
//    [LocationManager sharedInstance];
    
    RegistViewController * registVC = [[RegistViewController alloc] init];
//    HomeViewController * vc = [[HomeViewController alloc] init];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:registVC];
    nav.navigationItem.backBarButtonItem = nil;
    [self.window setRootViewController:nav];
    [self.window makeKeyAndVisible];
    
    // Override point for customization after application launch.
//    [[LocationManager sharedInstance] in]
    return YES;
}

- (void)updateVersion{
    NSString *curVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    if (!curVersion) {
        curVersion=@"1.0";
    }
    NSString *imeiStr = [[UIDevice currentDevice] myGlobalDeviceId];
    [[AppService sharedManager] request_update_Http_version:curVersion type:@"1" imei:imeiStr success:^(id responseObject) {
        VersionModel * versionModel = (VersionModel *)responseObject;
        if ([RETURN_CODE_SUCCESS isEqualToString:versionModel.retcode]) {
            VersionInfoModel * vModel = (VersionInfoModel *)versionModel.doc;
            if ([@"0" isEqualToString:vModel.isUpdate]) {
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"有新版本~" message:vModel.content delegate:self cancelButtonTitle:@"稍后更新" otherButtonTitles:@"更新", nil];
                alert.tag = 100;
                [alert show];
            }else{
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"有新版本~" message:vModel.content delegate:self cancelButtonTitle:@"立即更新" otherButtonTitles:nil, nil];
                alert.tag = 101;
                [alert show];
            }
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    NSNumber *latNumber = [NSNumber numberWithDouble:userLocation.location.coordinate.latitude];
    NSString *lat = [latNumber stringValue];
    NSNumber *lngNumber = [NSNumber numberWithDouble:userLocation.location.coordinate.longitude];
    NSString *lng = [lngNumber stringValue];
    [[NSUserDefaults standardUserDefaults] setObject:lat forKey:@"Userlatitude"];
    [[NSUserDefaults standardUserDefaults] setObject:lng forKey:@"Userlongitude"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [_locService stopUserLocationService];
    _locService.delegate = nil;
}

- (void)didFailToLocateUserWithError:(NSError *)error{
    [[NSUserDefaults standardUserDefaults] setObject:@"39.905206" forKey:@"Userlatitude"];
    [[NSUserDefaults standardUserDefaults] setObject:@"116.390356" forKey:@"Userlongitude"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [_locService stopUserLocationService];
    _locService.delegate = nil;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 100) {
        if (buttonIndex == 1) {
            // 测试
            NSLog(@"更新");
            //        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@", kAPPID]]];
        }
    }else{
        if (buttonIndex == 0) {
            NSLog(@"立即更新");
        }
    }
    
}

@end
