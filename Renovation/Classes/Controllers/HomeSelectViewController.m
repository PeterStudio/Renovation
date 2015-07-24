//
//  HomeSelectViewController.m
//  Renovation
//
//  Created by duwen on 15/6/11.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "HomeSelectViewController.h"
#import "AppService.h"
#import "DecorationsModel.h"
#import "SVProgressHUD.h"

@interface HomeSelectViewController ()
@property (nonatomic, strong) NSMutableArray * dataSourceArr;
@end

@implementation HomeSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"房屋选择";
    
    [SVProgressHUD showWithStatus:@"加载中" maskType:SVProgressHUDMaskTypeClear];
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults] objectForKey:USERINFO];
    [[AppService sharedManager] request_decorations_Http_userId:[dic objectForKey:@"userId"] state:@"0" success:^(id responseObject) {
        DecorationsModel * dModel = (DecorationsModel *)responseObject;
        if ([RETURN_CODE_SUCCESS isEqualToString:dModel.retcode]) {
            DecorationsInfoModel * DFModel = (DecorationsInfoModel *)dModel.doc;
            _dataSourceArr = [NSMutableArray arrayWithArray:DFModel.homeInfo];
            [_mainTableView reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:dModel.retinfo];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:OTHER_ERROR_MESSAGE];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSourceArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"HOMECELL";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    HomeModel * hModel = (HomeModel *)[_dataSourceArr objectAtIndex:indexPath.row];
    cell.textLabel.text = hModel.address;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeModel * hModel = (HomeModel *)[_dataSourceArr objectAtIndex:indexPath.row];
    if (self.callBack)
    {
        self.callBack(hModel.homeId);
    }
    [self.navigationController popViewControllerAnimated:YES];
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
