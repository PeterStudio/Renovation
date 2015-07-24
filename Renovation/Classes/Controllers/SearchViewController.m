//
//  SearchViewController.m
//  Renovation
//
//  Created by duwen on 15/6/3.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "SearchViewController.h"
#import "PersionViewController.h"
#import "SearchTableViewCell.h"


#define cellIndentifier @"SearchTableViewCellIdentifier"

@interface SearchViewController ()
@property (nonatomic, strong) NSMutableArray * dataSource;
@end

@implementation SearchViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _poisearch.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    _poisearch.delegate = nil;
    [SVProgressHUD dismiss];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _poisearch = [[BMKPoiSearch alloc]init];
    self.title = @"搜索";
    [self customNavView];
    [self.view setBackgroundColor:UIColorFromRGB(0xf5f5f5)];
    
    _dataSource = [[NSMutableArray alloc] init];
    NSString * address = [[NSUserDefaults standardUserDefaults] objectForKey:@"USERADDRESS"];
    if (address && address.length !=0) {
        NSDictionary * dic = @{@"title":@"当前位置",@"content":address};
        [_dataSource addObject:dic];
    }
    
    UINib *cellNib = [UINib nibWithNibName:@"SearchTableViewCell" bundle:nil];
    [_mainTableView registerNib:cellNib forCellReuseIdentifier:cellIndentifier];
    self.prototypeCell  = [_mainTableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
}

- (void)customNavView{
    UIImage * leftImg = [UIImage imageNamed:@"back02"];
//    UIImage * rightImg = [UIImage imageNamed:@"top_icon01"];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:leftImg forState:UIControlStateNormal];
    [leftBtn setFrame:CGRectMake(0, 0, leftImg.size.width, leftImg.size.height)];
    [leftBtn addTarget:self action:@selector(myInfoVC) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    
//    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [rightBtn setImage:rightImg forState:UIControlStateNormal];
//    [rightBtn setFrame:CGRectMake(0, 0, rightImg.size.width, rightImg.size.height)];
//    [rightBtn addTarget:self action:@selector(renovationListVC) forControlEvents:UIControlEventTouchUpInside];
//    [rightBtn setTag:100];
//    UIBarButtonItem * rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
//    self.navigationItem.rightBarButtonItem = rightBarItem;
    
//    UIImage * iconImg = [UIImage imageNamed:@"logo01"];
//    UIImage * titleImg = [UIImage imageNamed:@"logo02"];
//    UIView * customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iconImg.size.width + titleImg.size.width + 9, 44)];
//    UIImageView * icon = [[UIImageView alloc] init];
//    [icon setImage:iconImg];
//    [icon setFrame:CGRectMake(0, (customView.frame.size.height - iconImg.size.height) / 2, iconImg.size.width, iconImg.size.height)];
//    [customView addSubview:icon];
//    
//    UIImageView * title = [[UIImageView alloc] init];
//    [title setFrame:CGRectMake(icon.frame.origin.x + icon.frame.size.width + 9, (customView.frame.size.height - titleImg.size.height) / 2, titleImg.size.width, titleImg.size.height)];
//    [title setImage:titleImg];
//    [customView addSubview:title];
//    self.navigationItem.titleView = customView;
}

- (void)myInfoVC{
    [self.navigationController popViewControllerAnimated:YES];
//    PersionViewController * vc = [[PersionViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    NSDictionary * dic = [self.dataSource objectAtIndex:indexPath.row];
    [cell refrashDataWithTitle:dic[@"title"] content:dic[@"content"]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row != 0){
        NSDictionary * dic = [self.dataSource objectAtIndex:indexPath.row];
        NSString * lat = dic[@"lat"];
        NSString * lng = dic[@"lng"];
        if (self.callBack)
        {
            self.callBack([lat doubleValue],[lng doubleValue],dic[@"title"],dic[@"content"]);
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)renovationListVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [SVProgressHUD show];
    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
    citySearchOption.pageIndex = 1;
    citySearchOption.pageCapacity = 10;
    citySearchOption.city= @"";
    citySearchOption.keyword = _searchTF.text;
    BOOL flag = [_poisearch poiSearchInCity:citySearchOption];
    if(flag)
    {
        NSLog(@"城市内检索发送成功");
    }
    else
    {
        [SVProgressHUD dismiss];
        NSLog(@"城市内检索发送失败");
    }
    
    return YES;
}

#pragma mark -
#pragma mark implement BMKSearchDelegate
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error
{
    [SVProgressHUD dismiss];
    if (error == BMK_SEARCH_NO_ERROR) {
        [self.dataSource removeAllObjects];
        NSString * address = [[NSUserDefaults standardUserDefaults] objectForKey:@"USERADDRESS"];
        if (address && address.length !=0) {
            NSDictionary * dic = @{@"title":@"当前位置",@"content":address};
            [_dataSource addObject:dic];
        }
        for (int i = 0; i < result.poiInfoList.count; i++) {
            BMKPoiInfo* poi = [result.poiInfoList objectAtIndex:i];
            NSNumber *latNumber = [NSNumber numberWithDouble:poi.pt.latitude];
            NSString *lat = [latNumber stringValue];
            NSNumber *lngNumber = [NSNumber numberWithDouble:poi.pt.longitude];
            NSString *lng = [lngNumber stringValue];
            NSDictionary * dic = @{@"title":poi.name,@"content":poi.address,@"lat":lat,@"lng":lng};
            [_dataSource addObject:dic];
        }
        [self.mainTableView reloadData];
    } else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        NSLog(@"起始点有歧义");
    } else {
        // 各种情况的判断。。。
    }
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
