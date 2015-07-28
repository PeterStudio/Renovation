//
//  NearWorkersViewController.m
//  Renovation
//
//  Created by duwen on 15/5/27.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "NearWorkersViewController.h"
#import "WorkerDetailViewController.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"
#import "AppService.h"
#import "ForemenListModel.h"
#import "SearchViewController.h"

#define cellIndentifier @"NearWorkersTableViewCellIdentifier"

@interface NearWorkersViewController ()
{
//    NSString * userId;
    NSString * queryTime;
    NSString * latStr;
    NSString * lngStr;
    NSString * address;
}
@property (strong, nonatomic) NSMutableArray * dataSourceArray;
@property (assign, nonatomic) int page;
@property (assign, nonatomic) BOOL      isPulling;
@property (assign, nonatomic) BOOL      hasMore;
@end

@implementation NearWorkersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:UIColorFromRGB(0xf5f5f5)];
    
    _locationLab.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"USERADDRESS"];
    
    UINib *cellNib = [UINib nibWithNibName:@"NearWorkersTableViewCell" bundle:nil];
    [_mainTableView registerNib:cellNib forCellReuseIdentifier:cellIndentifier];
    self.prototypeCell  = [_mainTableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
    
    
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
    self.dataSourceArray = [[NSMutableArray alloc] initWithObjects:fModel1,fModel2, nil];
    
    
    
    
//    latStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"Userlatitude"]?[[NSUserDefaults standardUserDefaults] objectForKey:@"Userlatitude"]:@"39.905206";
//    lngStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"Userlongitude"]?[[NSUserDefaults standardUserDefaults] objectForKey:@"Userlongitude"]:@"116.390356";
//    address = [[NSUserDefaults standardUserDefaults] objectForKey:@"USERADDRESS"]?[[NSUserDefaults standardUserDefaults] objectForKey:@"USERADDRESS"]:@"北京市";
//    queryTime = @"FIRST";
//    _isPulling = YES;
//    _page = 1;
//    _hasMore = YES;
//    __weak UITableView * weaktb = _mainTableView;
//    [weaktb addHeaderWithCallback:^{
//        _isPulling = YES;
//        queryTime = @"FIRST";
//        _page = 1;
//        _hasMore = YES;
//        [self requestDataWithPage:_page];
//        if (_mainTableView.footerHidden) {
//            [_mainTableView setFooterHidden:NO];
//        }
//    }];
//    [weaktb addFooterWithCallback:^{
//        _isPulling = NO;
//        if (_hasMore) {
//            [self requestDataWithPage:++_page];
//        }
//    }];
//    [self requestDataWithPage:_page];
}

- (void)requestDataWithPage:(int)page{
    [SVProgressHUD showWithStatus:@"加载中" maskType:SVProgressHUDMaskTypeClear];
    [[AppService sharedManager] request_nearbyForemen_Http_lat:latStr lng:lngStr adddress:address page:[NSString stringWithFormat:@"%d",page] num:NUMBER_FOR_REQUEST queryTime:queryTime success:^(id responseObject) {
        ForemenListModel * foremenListModel = (ForemenListModel *)responseObject;
        if ([RETURN_CODE_SUCCESS isEqualToString:foremenListModel.retcode]) {
            if (_isPulling) {
                [_dataSourceArray removeAllObjects];
                [_mainTableView headerEndRefreshing];
            }else{
                [_mainTableView footerEndRefreshing];
            }
            if (foremenListModel.doc.count < 10) {
                _hasMore = NO;
                [_mainTableView setFooterHidden:YES];
                [_mainTableView footerEndRefreshing];
            }
            [_dataSourceArray addObjectsFromArray:foremenListModel.doc];
            [_mainTableView reloadData];
            queryTime = foremenListModel.queryTime;
            [SVProgressHUD dismiss];
        }else{
            if ([_dataSourceArray count]) {
                [SVProgressHUD showErrorWithStatus:foremenListModel.retinfo];
            }else{
                [SVProgressHUD dismiss];
            }
            [self endRefreshing];
        }
    } failure:^(NSError *error) {
        if ([_dataSourceArray count]) {
            [SVProgressHUD showErrorWithStatus:OTHER_ERROR_MESSAGE];
        }else{
            [SVProgressHUD dismiss];
        }
        [self endRefreshing];
    }];
}

/**
 *  停止数据刷新UI
 */
- (void)endRefreshing{
    if (_isPulling) {
        [_mainTableView headerEndRefreshing];
    }else{
        [_mainTableView footerEndRefreshing];
    }
}

- (IBAction)searchLocationBtnClick:(id)sender {
    SearchViewController * vc = [[SearchViewController alloc] init];
    __weak __typeof(self)weakSelf = self;
    vc.callBack = ^(double lat, double lng, NSString * name, NSString * content){
        weakSelf.locationLab.text = content;
        _isPulling = YES;
        queryTime = @"FIRST";
        _page = 1;
        _hasMore = YES;
        latStr = [NSString stringWithFormat:@"%lf",lat];
        lngStr = [NSString stringWithFormat:@"%lf",lng];
        address = content;
        [self requestDataWithPage:_page];
    };
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;//[_dataSourceArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NearWorkersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    ForemenModel * foremenModel = (ForemenModel *)[_dataSourceArray objectAtIndex:indexPath.row];
    [cell refrashDataWithForemenModel:foremenModel];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ForemenModel * foremenModel = (ForemenModel *)[_dataSourceArray objectAtIndex:indexPath.row];
    WorkerDetailViewController * vc = [[WorkerDetailViewController alloc] init];
    vc.contractorId = foremenModel.contractorId;
    vc.workerName = foremenModel.name;
    vc.model = foremenModel;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
