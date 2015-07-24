//
//  HomeViewController.m
//  Renovation
//
//  Created by duwen on 15/5/21.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "HomeViewController.h"
//#import "PersionViewController.h"
//#import "LocationManager.h"

#import "WorkSiteListViewController.h"
#import "SearchViewController.h"
#import "MyAnimatedAnnotationView.h"
#import "CustomAnnotation.h"
#import "RatingBar.h"
#import "WorkerDetailViewController.h"
#import "AppService.h"
#import "NearSiteListModel.h"
#import "ForemenListModel.h"
#import "UserModel.h"
#import "MessageListModel.h"

@interface HomeViewController ()<BMKLocationServiceDelegate,MyAnimatedAnnotationViewDelegate>
{
    BOOL _isShowUserLocation;
    BMKPointAnnotation* pointAnnotation;
    BOOL _isNearWorker;
}

@property (nonatomic, strong) NSArray * messageArr;
@property (nonatomic, strong) NSMutableArray * foremenArr;
@property (nonatomic, strong) NSMutableArray * nearArr;
@end

@implementation HomeViewController

-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self;
    _locService.delegate = self;
    _geocodesearch.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
    _locService.delegate = nil;
    _geocodesearch.delegate = nil;
    [SVProgressHUD dismiss];
}

- (void)config{
    _isNearWorker = YES;
    _geocodesearch = [[BMKGeoCodeSearch alloc]init];
    startIndex = 0;
    _isShowUserLocation = NO;
    [_nearFactoryBtn backGroundCustomNorImage:@"btn01" selImage:@"btn01"];
    [_nearWorkBtn backGroundCustomNorImage:@"btn01" selImage:@"btn01"];
    [_workerBtn backGroundCustomNorImage:@"btn02" selImage:@"btn02"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self config];
    _locService = [[BMKLocationService alloc]init];
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
//    [_locService startUserLocationService];
    _mapView.delegate = self;
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeNone;
    _mapView.showsUserLocation = YES;
    _mapView.isSelectedAnnotationViewFront = YES;
    

    // 消息请求
//    NSDictionary * dic = [[NSUserDefaults standardUserDefaults] objectForKey:USERINFO];
//    UserInfoModel * uInfoModel = [[NSUserDefaults standardUserDefaults] objectForKey:USERINFO];
//    [[AppService sharedManager] request_message_Http_userId:[dic objectForKey:@"userId"] success:^(id responseObject) {
//        MessageListModel * msgListModel = (MessageListModel *)responseObject;
//        if ([RETURN_CODE_SUCCESS isEqualToString:msgListModel.retcode]) {
//            _messageArr = [NSArray arrayWithArray:msgListModel.doc];
//            if (_messageArr.count > 0) {
//                _numBgIV.hidden = NO;
//                _messageNumLab.hidden = NO;
//                _messageNumLab.text = [NSString stringWithFormat:@"%lu",(unsigned long)_messageArr.count];
//            }
//        }else{
//            [SVProgressHUD showErrorWithStatus:msgListModel.retinfo];
//        }
//    } failure:^(NSError *error) {
//        [SVProgressHUD showErrorWithStatus:OTHER_ERROR_MESSAGE];
//    }];
    
    
    
    
    
    ForemenModel * fModel1 = [[ForemenModel alloc] init];
    fModel1.contractorId = @"1";
    fModel1.name = @"马选集";
    fModel1.headUrl = @"foremen1";
    fModel1.star = @"5";
    fModel1.homeTown = @"安徽省";
    fModel1.year = @"17";
    fModel1.distance = @"1.5";
    fModel1.frequency = @"27";
    fModel1.tel = @"18211195962";
    fModel1.lat = @"39.905206";
    fModel1.lng = @"116.390356";

    ForemenModel * fModel2 = [[ForemenModel alloc] init];
    fModel2.contractorId = @"2";
    fModel2.name = @"陈远寿";
    fModel2.headUrl = @"foremen2";
    fModel2.star = @"4";
    fModel2.homeTown = @"安徽省";
    fModel2.year = @"15";
    fModel2.distance = @"0.9";
    fModel2.frequency = @"10";
    fModel2.tel = @"18610117705";
    fModel2.lat = @"39.905906";
    fModel2.lng = @"116.390957";
    
    _foremenArr = [[NSMutableArray alloc] initWithObjects:fModel1,fModel2, nil];
    
    
    NearSiteModel * nModel1 = [[NearSiteModel alloc] init];
    nModel1.nearbySiteId = @"001";
    nModel1.name = @"001";
    nModel1.headUrl = @"001";
    nModel1.distance = @"001";
    nModel1.num = @"1";
    nModel1.lat = @"39.905806";
    nModel1.lng = @"116.390656";
    
    NearSiteModel * nModel2 = [[NearSiteModel alloc] init];
    nModel2.nearbySiteId = @"002";
    nModel2.name = @"002";
    nModel2.headUrl = @"001";
    nModel2.distance = @"001";
    nModel2.num = @"2";
    nModel2.lat = @"39.904806";
    nModel2.lng = @"116.391656";
    
    _nearArr = [[NSMutableArray alloc] initWithObjects:nModel1,nModel2, nil];
    
    for (ForemenModel * foremenModel in _foremenArr) {
        [self addForemenAnnotation:foremenModel];
    }
    [_mapView setZoomLevel:17];
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(39.905206, 116.390356)animated:YES];
}

- (void)addForemenAnnotation:(ForemenModel *)foremenModel {
    CustomAnnotation *animatedAnnotation = [[CustomAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = [foremenModel.lat doubleValue];
    coor.longitude = [foremenModel.lng doubleValue];
    animatedAnnotation.coordinate = coor;
    animatedAnnotation.title = nil;
    animatedAnnotation.name = foremenModel.name;
    animatedAnnotation.url = foremenModel.headUrl;
    animatedAnnotation.star = foremenModel.star;
    animatedAnnotation.siteNum = nil;
    animatedAnnotation.workerID = foremenModel.contractorId;
    animatedAnnotation.fModel = foremenModel;
    [_mapView addAnnotation:animatedAnnotation];
}

- (void)addNearSiteAnnotation:(NearSiteModel *)nearSiteModel{
    CustomAnnotation *animatedAnnotation = [[CustomAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = [nearSiteModel.lat doubleValue];
    coor.longitude = [nearSiteModel.lng doubleValue];
    animatedAnnotation.coordinate = coor;
    animatedAnnotation.title = nil;
    animatedAnnotation.name = nearSiteModel.name;
    animatedAnnotation.url = nearSiteModel.headUrl;
    animatedAnnotation.siteNum = nearSiteModel.num;
    animatedAnnotation.workerID = nearSiteModel.nearbySiteId;
    [_mapView addAnnotation:animatedAnnotation];
}

- (IBAction)messageButtonClick:(id)sender {
    if (_messageArr.count > 0) {
        
    }else{
        [SVProgressHUD showErrorWithStatus:@"亲~暂时没有消息哦！"];
    }
}

- (IBAction)searchButtonClick:(id)sender {
    SearchViewController * vc = [[SearchViewController alloc] init];
    vc.callBack = ^(double lat, double lng, NSString * name, NSString * content){
        CLLocationCoordinate2D pt = (CLLocationCoordinate2D){lat, lng};
        pointAnnotation = [[BMKPointAnnotation alloc]init];
        pointAnnotation.coordinate = pt;
        pointAnnotation.title = name;
        pointAnnotation.subtitle = content;
        [_mapView setCenterCoordinate:pt animated:YES];
        [_mapView addAnnotation:pointAnnotation];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)LocationButtonClick:(id)sender {
    if (!_isShowUserLocation) {
        _isShowUserLocation = YES;
        [_locService startUserLocationService];
        _mapView.showsUserLocation = NO;//先关闭显示的定位图层
        _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
        _mapView.showsUserLocation = YES;//显示定位图层
    }
}

- (IBAction)nearFactoryButtonClick:(id)sender {
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    _isNearWorker = YES;
    
    for (ForemenModel * foremenModel in _foremenArr) {
        [self addForemenAnnotation:foremenModel];
    }
}

- (IBAction)nearWorkButtonClick:(id)sender {
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    _isNearWorker = NO;
    for (NearSiteModel * nearSite in _nearArr) {
        [self addNearSiteAnnotation:nearSite];
    }
}

- (IBAction)workerButtonClick:(id)sender {
    // 客服电话
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"4000000878"];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}

#pragma mark - BMKMapViewDelegate
- (void)mapViewDidFinishLoading:(BMKMapView *)mapView{
    NSLog(@"定位成功");
    // 北京
    CLLocationCoordinate2D pt = mapView.centerCoordinate;
    [_mapView setCenterCoordinate:pt animated:YES];
    [SVProgressHUD dismiss];
}

/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser
{
    NSLog(@"start locate");
    [SVProgressHUD showWithStatus:@"努力定位中..." maskType:SVProgressHUDMaskTypeClear];
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    NSLog(@"heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    ++startIndex;
    NSLog(@"index ;%d",startIndex);
    if (startIndex == 1) {
        [_mapView setZoomLevel:14];
        [_mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
        
        [self reverseGeocode:userLocation.location];
        [_locService stopUserLocationService];
    }
    
    [_mapView updateLocationData:userLocation];
    if (_isShowUserLocation) {
        _isShowUserLocation = NO;
        [_mapView setZoomLevel:14];
        [_mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
        [self reverseGeocode:userLocation.location];
        [_locService stopUserLocationService];
    }
    
    NSNumber *latNumber = [NSNumber numberWithDouble:userLocation.location.coordinate.latitude];
    NSString *lat = [latNumber stringValue];
    NSNumber *lngNumber = [NSNumber numberWithDouble:userLocation.location.coordinate.longitude];
    NSString *lng = [lngNumber stringValue];
    [[NSUserDefaults standardUserDefaults] setObject:lat forKey:@"Userlatitude"];
    [[NSUserDefaults standardUserDefaults] setObject:lng forKey:@"Userlongitude"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
    [SVProgressHUD dismiss];
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
    if (_isShowUserLocation) {
        _isShowUserLocation = NO;
    }
    startIndex = 0;
    [SVProgressHUD dismiss];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"39.905206" forKey:@"Userlatitude"];
    [[NSUserDefaults standardUserDefaults] setObject:@"116.390356" forKey:@"Userlongitude"];
    [[NSUserDefaults standardUserDefaults] setObject:@"北京市天安门" forKey:@"USERADDRESS"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)reverseGeocode:(CLLocation *)location{
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = location.coordinate;
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
}

#pragma mark - BMKGeoCodeSearchDelegate
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    NSLog(@"address:%@",result.address);
    [[NSUserDefaults standardUserDefaults] setObject:result.address forKey:@"USERADDRESS"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if (annotation == pointAnnotation) {
        // 生成重用标示identifier
        NSString *AnnotationViewID = @"PointMark";
        // 检查是否有重用的缓存
        BMKAnnotationView* annotationView = [view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
        // 缓存没有命中，自己构造一个，一般首次添加annotation代码会运行到此处
        if (annotationView == nil) {
            annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
            ((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorRed;
            // 设置重天上掉下的效果(annotation)
            ((BMKPinAnnotationView*)annotationView).animatesDrop = YES;
        }
        // 设置位置
        annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
        annotationView.annotation = annotation;
        // 单击弹出泡泡，弹出泡泡前提annotation必须实现title属性
        annotationView.canShowCallout = NO;
        // 设置是否可以拖拽
        annotationView.draggable = NO;
        return annotationView;
    }
    
    NSString *AnnotationViewID = @"AnimatedAnnotation";
    MyAnimatedAnnotationView *annotationView = (MyAnimatedAnnotationView *)[view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    if (annotationView == nil) {
        annotationView = [[MyAnimatedAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
    }
    annotationView.delegate = self;
    annotationView.customAnnotation = (CustomAnnotation *)annotation;
    annotationView.image = _isNearWorker ?[self getImageFromView:[self workerView:(CustomAnnotation *)annotation]] : [self getImageFromView:[self workSiteView:(CustomAnnotation *)annotation]];
    return annotationView;
}

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    [mapView bringSubviewToFront:view];
    [mapView setNeedsDisplay];
}


- (UIView *)workerView:(CustomAnnotation *)customAn{
    UIView *viewForImage=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 150, 64)];
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:viewForImage.frame];
    [imageview setImage:[UIImage imageNamed:@"speed_bg02"]];
    [viewForImage addSubview:imageview];
    
    UIImageView * icon = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 40, 40)];
    icon.layer.masksToBounds = YES;
    icon.layer.cornerRadius = 20;
    [icon setImage:[UIImage imageNamed:customAn.url]];
    [viewForImage addSubview:icon];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(50, 10, 75, 15)];
    label.text = customAn.name;
    label.font = [UIFont boldSystemFontOfSize:15];
    label.backgroundColor=[UIColor clearColor];
    [viewForImage addSubview:label];
    
    RatingBar * rate = [[RatingBar alloc] initWithFrame:CGRectMake(50, 35, 70, 16)];
    rate.isIndicator = YES;
    rate.height = 15.0;rate.width = 18.2;
    [rate setImageDeselected:@"start_icon01" halfSelected:nil fullSelected:@"start_icon01_1" andDelegate:nil];
    [rate displayRating:[customAn.star floatValue]];
    [viewForImage addSubview:rate];
    return viewForImage;
}

- (UIView *)workSiteView:(CustomAnnotation *)customAn{
    UIView *viewForImage=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 150, 64)];
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:viewForImage.frame];
    [imageview setImage:[UIImage imageNamed:@"speed_bg04"]];
    [viewForImage addSubview:imageview];
    
    UIImageView * icon = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 40, 40)];
    icon.layer.masksToBounds = YES;
    icon.layer.cornerRadius = 20;
    [icon setImage:[UIImage imageNamed:@"head"]];
    [viewForImage addSubview:icon];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(50, 12, 75, 15)];
    label.text = customAn.name;
    label.font = [UIFont boldSystemFontOfSize:15];
    label.backgroundColor=[UIColor clearColor];
    [viewForImage addSubview:label];
    
    UILabel *numLab=[[UILabel alloc]initWithFrame:CGRectMake(50, 35, 75, 15)];
    numLab.text =  [NSString stringWithFormat:@"工地数:%@",customAn.siteNum];
    numLab.font = [UIFont systemFontOfSize:14];
    numLab.backgroundColor=[UIColor clearColor];
    [viewForImage addSubview:numLab];
    return viewForImage;
}

-(UIImage *)getImageFromView:(UIView *)view{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)showMsgWithAnonotation:(CustomAnnotation *)annotation{
    WorkerDetailViewController * vc = [[WorkerDetailViewController alloc] init];
    vc.contractorId = annotation.workerID;
    vc.workerName = annotation.name;
    vc.model = annotation.fModel;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
