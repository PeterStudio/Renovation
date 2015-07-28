//
//  MyRepairViewController.m
//  Renovation
//
//  Created by duwen on 15/6/3.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "MyRepairViewController.h"
//#import "NearWorkersTableViewCell.h"
#import "WorkerDetailViewController.h"
#import "RepairTableViewCell.h"

#define cellIndentifier @"RepairTableViewCellIdentifier"
@interface MyRepairViewController ()
@property (nonatomic, strong) NSMutableArray * dataSourceArr;
@end

@implementation MyRepairViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"我的装修";
    
    UINib *cellNib = [UINib nibWithNibName:@"RepairTableViewCell" bundle:nil];
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
    
    _dataSourceArr = [[NSMutableArray alloc] initWithObjects:fModel1,fModel2, nil];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;//[self.dataSourceArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RepairTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//    ForemenModel * temp = (ForemenModel *)[self.dataSourceArr objectAtIndex:indexPath.row];
//    [cell refrashDataWithForemenModel:temp];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    WorkerDetailViewController * vc = [[WorkerDetailViewController alloc] init];
//    vc.contractorId = annotation.workerID;
//    vc.workerName = annotation.name;
//    vc.model = annotation.fModel;
//    [self.navigationController pushViewController:vc animated:YES];
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
