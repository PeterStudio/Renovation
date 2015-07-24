//
//  HomeViewController.h
//  Renovation
//
//  Created by duwen on 15/5/21.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "PTViewController.h"
#import <BaiduMapAPI/BMapKit.h>
#import "SVProgressHUD.h"

@interface HomeViewController : PTViewController<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
{
//    BMKMapView* _mapView;
    BMKLocationService* _locService;
    BMKGeoCodeSearch* _geocodesearch;
    int startIndex;
}

@property (strong, nonatomic) IBOutlet BMKMapView *mapView;

@property (strong, nonatomic) IBOutlet UIButton *nearFactoryBtn;
@property (strong, nonatomic) IBOutlet UIButton *nearWorkBtn;
@property (strong, nonatomic) IBOutlet UIButton *workerBtn;

@property (strong, nonatomic) IBOutlet UIImageView *numBgIV;
@property (strong, nonatomic) IBOutlet UILabel *messageNumLab;





@end
