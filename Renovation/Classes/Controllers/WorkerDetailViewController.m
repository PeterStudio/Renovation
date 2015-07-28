//
//  WorkerDetailViewController.m
//  Renovation
//
//  Created by duwen on 15/6/3.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "WorkerDetailViewController.h"
#import "FirstTableViewCell.h"
#import "SecondTableViewCell.h"
#import "WorkSiteListViewController.h"
#import "ForemanDetailModel.h"
#import "SVProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "HomeSelectViewController.h"

#define cellIndentifier1 @"FirstTableViewCellIdentifier"
#define cellIndentifier2 @"SecondTableViewCellIdentifier"

@interface WorkerDetailViewController ()
@property (nonatomic, strong) NSMutableArray * dataArr1;
@property (nonatomic, strong) NSMutableArray * dataArr2;
@end

@implementation WorkerDetailViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [SVProgressHUD dismiss];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _workerName;
    
    UINib *cellNib1 = [UINib nibWithNibName:@"FirstTableViewCell" bundle:nil];
    [_TableView1 registerNib:cellNib1 forCellReuseIdentifier:cellIndentifier1];
    self.firstCell  = [_TableView1 dequeueReusableCellWithIdentifier:cellIndentifier1];
    
    UINib *cellNib2 = [UINib nibWithNibName:@"SecondTableViewCell" bundle:nil];
    [_TableView2 registerNib:cellNib2 forCellReuseIdentifier:cellIndentifier2];
    self.secondCell  = [_TableView2 dequeueReusableCellWithIdentifier:cellIndentifier2];
    
    
    [_recommendBtn backGroundCustomNorImage:@"reg_bg01" selImage:@"reg_bg01_1"];
    [_submitBtn backGroundCustomNorImage:@"reg_bg01" selImage:@"reg_bg01_1"];
    
    _ratingBarView.isIndicator = YES;
    _ratingBarView.height = 15;
    _ratingBarView.width = 18.2;
    _sRateBarView.height = 40;
    _sRateBarView.width = 45;
    [_sRateBarView displayRating:1.0f];
    [_ratingBarView setImageDeselected:@"start_icon01" halfSelected:nil fullSelected:@"start_icon01_1" andDelegate:nil];
    [_sRateBarView setImageDeselected:@"start_icon01" halfSelected:nil fullSelected:@"start_icon01_1" andDelegate:nil];
    
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = 25;
    
    [self refashDataWithForemanDetailInfoModel];
    
    _TableView1.hidden = YES;
    _RecommendListView.hidden = NO;
    _scrollerView.hidden = YES;
}


- (void)refashDataWithForemanDetailInfoModel{
    [_headImageView setImage:[UIImage imageNamed:_model.headUrl]];
    
    _nameLabel.text = _model.name;
    _appointmentNumLabel.text = [NSString stringWithFormat:@"被预约%@次",_model.frequency];
    [_ratingBarView displayRating:[_model.star floatValue]];
    
    _FromLabel.text = [NSString stringWithFormat:@"%@公里",_model.distance];
    _yearLabel.text = [NSString stringWithFormat:@"%@年",_model.year];
    _addressLabel.text = _model.homeTown;
    
    PerformancesModel * pModel1 = [[PerformancesModel alloc] init];
    pModel1.address = @"大兴区东大桥18号楼3单元***";
    pModel1.customerName = @"贾女士";
    
    PerformancesModel * pModel2 = [[PerformancesModel alloc] init];
    pModel2.address = @"朝阳区西直门双子塔2号楼5单元***";
    pModel2.customerName = @"杜先生";
    
    _dataArr1 = [[NSMutableArray alloc] initWithObjects:[@"1" isEqualToString:_model.contractorId]?pModel1:pModel2, nil];
    
    
    AppraiseModel * aModel1 = [[AppraiseModel alloc] init];
    aModel1.content = @"很不错哦";
    aModel1.star = @"5";
    aModel1.time = @"20150724082101";
    aModel1.name =  @"Jack";
    
    AppraiseModel * aModel2 = [[AppraiseModel alloc] init];
    aModel2.content = @"做工不错，用料有保证";
    aModel2.star = @"5";
    aModel2.time = @"20150726112120";
    aModel2.name =  @"追风";
    
    AppraiseModel * aModel3 = [[AppraiseModel alloc] init];
    aModel3.content = @"基本还算满意哦";
    aModel3.star = @"4";
    aModel3.time = @"20150725092430";
    aModel3.name =  @"提拉米苏";
    
    if([@"1" isEqualToString:_model.contractorId]){
        _dataArr2 = [[NSMutableArray alloc] initWithObjects:aModel1,aModel2, nil];
    }else{
        _dataArr2 = [[NSMutableArray alloc] initWithObjects:aModel3, nil];
    }
//    _dataArr2 = [[NSMutableArray alloc] initWithObjects:pModel2, nil];
    
    _currentWorkNumLabel.text = [NSString stringWithFormat:@"正在施工（%d）",[@"1" isEqualToString:_model.contractorId]?1:1];
    _currentRecommendLabel.text = [NSString stringWithFormat:@"评价详情（%d）",[@"1" isEqualToString:_model.contractorId]?2:1];
    
    [_TableView1 reloadData];
    [_TableView2 reloadData];
}

- (IBAction)recommendBtnClick:(id)sender {
    _TableView1.hidden = YES;
    _RecommendListView.hidden = YES;
    _scrollerView.hidden = NO;
}


- (IBAction)leftViewClick:(id)sender {
    _TableView1.hidden = NO;
    _RecommendListView.hidden = YES;
    _scrollerView.hidden = YES;
}

- (IBAction)rightViewClick:(id)sender {
    _TableView1.hidden = YES;
    _RecommendListView.hidden = NO;
    _scrollerView.hidden = YES;
}


- (IBAction)submitBtnClick:(id)sender {
    [_wTextView resignFirstResponder];
    if ((int)_sRateBarView.rating == 0) {
        [SVProgressHUD showErrorWithStatus:@"请先给工长评星哦～"];
        return;
    }
    if (!_placeholdLab.hidden) {
        [SVProgressHUD showErrorWithStatus:@"请输入评价内容"];
        return;
    }
    [SVProgressHUD showSuccessWithStatus:@"评价成功"];
    
//    NSDictionary * dic = [[NSUserDefaults standardUserDefaults] objectForKey:USERINFO];
//    NSString * star = [NSString stringWithFormat:@"%d",(int)_sRateBarView.rating];
//    [SVProgressHUD showWithStatus:@"加载中" maskType:SVProgressHUDMaskTypeClear];
//    [[AppService sharedManager] request_appraise_Http_userId:[dic objectForKey:@"userId"] contractorId:_contractorId content:_wTextView.text start:star success:^(id responseObject) {
//        BaseModel * baseModel = (BaseModel *)responseObject;
//        if ([RETURN_CODE_SUCCESS isEqualToString:baseModel.retcode]) {
//            [SVProgressHUD showSuccessWithStatus:baseModel.retinfo];
//        }else{
//            [SVProgressHUD showErrorWithStatus:baseModel.retinfo];
//        }
//    } failure:^(NSError *error) {
//        [SVProgressHUD showErrorWithStatus:OTHER_ERROR_MESSAGE];
//    }];
}

- (IBAction)liJiYuYueClick:(id)sender {
    [SVProgressHUD showSuccessWithStatus:@"预约成功"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _TableView1) {
        return _dataArr1.count;
    }
    return _dataArr2.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _TableView1) {
        FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier1];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        PerformancesModel * pModel = (PerformancesModel *)[_dataArr1 objectAtIndex:indexPath.row];
        cell.houseNameLab.text = pModel.address;
        cell.userName.text = pModel.customerName;
        return cell;
    }
    SecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier2];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    AppraiseModel * aModel = (AppraiseModel *)[_dataArr2 objectAtIndex:indexPath.row];
    [cell refrashWithAppraiseModel:aModel];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _TableView1) {
        return 44.0f;
    }else{
//        SecondTableViewCell *cell = (SecondTableViewCell *)self.secondCell;
//        AppraiseModel * aModel = (AppraiseModel *)[_dataArr2 objectAtIndex:indexPath.row];
//        [cell refrashWithAppraiseModel:aModel];
//        CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        return 80;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _TableView1) {
        WorkSiteListViewController * vc = [[WorkSiteListViewController alloc] init];
        vc.pModel = (PerformancesModel *)[_dataArr1 objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    int keyboardhight = 0;
    if(kbSize.height == 216)
    {
        keyboardhight = 0;
    }
    else
    {
        keyboardhight = 36;
    }
    _bottomLC.constant = - keyboardhight - kbSize.height;
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    _bottomLC.constant = 0;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    _placeholdLab.hidden = textView.text.length > 0;
    if (textView.markedTextRange == nil && textView.text.length > 200) {
        NSString * str = textView.text;
        textView.text = [str substringToIndex:200];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
