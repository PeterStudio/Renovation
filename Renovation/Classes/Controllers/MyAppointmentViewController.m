//
//  MyAppointmentViewController.m
//  Renovation
//
//  Created by duwen on 15/6/2.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "MyAppointmentViewController.h"
#import "NearWorkersTableViewCell.h"
#import "AppService.h"
#import "ReservationModel.h"
#import "SVProgressHUD.h"
#import "AppointmentView.h"
#import "WorkerDetailViewController.h"

#define cellIndentifier @"NearWorkersTableViewCellIdentifier"
@interface MyAppointmentViewController ()<AppointmentViewDelegate>
@property (strong, nonatomic) NSMutableArray * dataSourceArr;
@property (strong, nonatomic) NSMutableArray * rowNumArr;
@end

@implementation MyAppointmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的预约";
    _rowNumArr = [[NSMutableArray alloc] init];
    UINib *cellNib = [UINib nibWithNibName:@"NearWorkersTableViewCell" bundle:nil];
    [_mainTableView registerNib:cellNib forCellReuseIdentifier:cellIndentifier];
    self.prototypeCell  = [_mainTableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
//    [self requestData];
}

- (void)requestData{
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults] objectForKey:USERINFO];
    [SVProgressHUD showWithStatus:@"加载中" maskType:SVProgressHUDMaskTypeClear];
    [[AppService sharedManager] request_reservations_Http_userId:[dic objectForKey:@"userId"] success:^(id responseObject) {
        ReservationModel * rModel = (ReservationModel *)responseObject;
        if ([RETURN_CODE_SUCCESS isEqualToString:rModel.retcode]) {
            ReservationInfoModel * rfModel = (ReservationInfoModel *)responseObject;
            _appointmentNumLabel.text = [NSString stringWithFormat:@"%@人",rfModel.reservationNum];
            _dataSourceArr = [NSMutableArray arrayWithArray:rfModel.houseList];
            _RepairNumLabel.text = [NSString stringWithFormat:@"%ld套",_dataSourceArr.count];
            for (int i = 0;i < _dataSourceArr.count;i++) {
                [_rowNumArr addObject:[NSNumber numberWithInt:0]];
            }
            [_mainTableView reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:rModel.retinfo];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:OTHER_ERROR_MESSAGE];
        [self.navigationController popViewControllerAnimated:YES];
    }];

}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataSourceArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSNumber * number = (NSNumber *)[_rowNumArr objectAtIndex:section];
    return [number integerValue];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSArray * nibArr = [[NSBundle mainBundle] loadNibNamed:@"AppointmentView" owner:nil options:nil];
    AppointmentView * aView = [nibArr objectAtIndex:0];
    aView.delegate = self;
    aView.section = section;
    aView.numLab.text = [NSString stringWithFormat:@"0%ld",section+1];
    Persion1Model * pModel = (Persion1Model *)[_dataSourceArr objectAtIndex:section];
    aView.addressLab.text = pModel.address;
    NSNumber * number = (NSNumber *)[_rowNumArr objectAtIndex:section];
    if ([number integerValue] == 0) {
        aView.arrowBtn.selected = NO;
    }else{
        aView.arrowBtn.selected = YES;
    }
    return aView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NearWorkersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    Persion1Model * pModel = (Persion1Model *)[_dataSourceArr objectAtIndex:indexPath.section];
    NSArray * arr = [NSArray arrayWithArray:pModel.personList];
    PersionModel * pFModel = (PersionModel *)[arr objectAtIndex:indexPath.row];
    [cell refrashDataWithPersionModel:pFModel];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Persion1Model * pModel = (Persion1Model *)[_dataSourceArr objectAtIndex:indexPath.section];
    NSArray * arr = [NSArray arrayWithArray:pModel.personList];
    PersionModel * pFModel = (PersionModel *)[arr objectAtIndex:indexPath.row];
    WorkerDetailViewController * vc = [[WorkerDetailViewController alloc] init];
    vc.contractorId = pFModel.contractorId;
    vc.workerName = pFModel.name;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)arrowBtnSelected:(NSInteger)section isSelected:(BOOL)_isSelected{
    if (_isSelected) {
        [_rowNumArr replaceObjectAtIndex:section withObject:[NSNumber numberWithInt:0]];
    }else{
        NSArray * tempArr = [NSArray arrayWithArray:_rowNumArr];
        for (NSNumber * num in tempArr) {
            if ([num integerValue] != 0) {
                NSInteger index = [tempArr indexOfObject:num];
                [_rowNumArr replaceObjectAtIndex:index withObject:[NSNumber numberWithInt:0]];
            }
        }
        [_rowNumArr replaceObjectAtIndex:section withObject:[NSNumber numberWithInt:3]];
    }
    [_mainTableView reloadData];
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
