//
//  WorkSiteListViewController.m
//  Renovation
//
//  Created by duwen on 15/6/2.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "WorkSiteListViewController.h"
#import "WorkSiteListTableViewCell.h"
#import "PhotosViewController.h"

#define cellIndentifier @"WorkSiteListTableViewCellIdentifier"
@interface WorkSiteListViewController ()<PhotosViewDatasource,PhotosViewDelegate>
@property (nonatomic, strong) NSMutableArray * sourceArray;
@property (nonatomic, strong) NSMutableArray * largeImageArray;
@end

@implementation WorkSiteListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"查看工地";
    UINib *cellNib = [UINib nibWithNibName:@"WorkSiteListTableViewCell" bundle:nil];
    [_mainTableView registerNib:cellNib forCellReuseIdentifier:cellIndentifier];
    self.prototypeCell  = [_mainTableView dequeueReusableCellWithIdentifier:cellIndentifier];
    _sourceArray = [[NSMutableArray alloc] initWithArray:_pModel.pic];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.sourceArray count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 44)];
    [view setBackgroundColor:UIColorFromRGB(0xf1f1f1)];
    UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(16, 15, tableView.frame.size.width - 32, 14)];
    
    [lab setText:_pModel.address];
    [lab setTextColor:UIColorFromRGB(0x333333)];
    [lab setFont:[UIFont systemFontOfSize:12.0f]];
    [view addSubview:lab];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WorkSiteListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    PicModel * pModel = (PicModel *)[_sourceArray objectAtIndex:indexPath.row];
    [cell refrshWithPicModel:pModel];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PicModel * pModel = (PicModel *)[_sourceArray objectAtIndex:indexPath.row];
    _largeImageArray = [NSMutableArray arrayWithArray:pModel.url];
    PhotosViewController      *photos = [[PhotosViewController alloc] init];
    photos.delegate = self;
    photos.datasource = self;
    photos.currentPage = 1;
    [self.navigationController pushViewController:photos animated:YES];
}

- (NSInteger)photosViewNumberOfCount {
    return self.largeImageArray.count;
}

- (NSString *)photosViewUrlAtIndex:(NSInteger)index {
    UrlModel * uModel = (UrlModel *)[_largeImageArray objectAtIndex:index];
    return uModel.HDUrl;
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
