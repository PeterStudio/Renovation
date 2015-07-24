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
    
    
    [SVProgressHUD showWithStatus:@"加载中。。。" maskType:SVProgressHUDMaskTypeClear];
    [[AppService sharedManager] request_foremanDetail_Http_contractorId:_contractorId success:^(id responseObject) {
        ForemanDetailModel * foremanDetailModel = (ForemanDetailModel *)responseObject;
        if ([RETURN_CODE_SUCCESS isEqualToString:foremanDetailModel.retcode]) {
            ForemanDetailInfoModel * detail = (ForemanDetailInfoModel *)foremanDetailModel.doc;
            [self refashDataWithForemanDetailInfoModel:detail];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
            [SVProgressHUD showErrorWithStatus:foremanDetailModel.retinfo];
        }
    } failure:^(NSError *error) {
        [self.navigationController popViewControllerAnimated:YES];
        [SVProgressHUD showErrorWithStatus:OTHER_ERROR_MESSAGE];
    }];
}


- (void)refashDataWithForemanDetailInfoModel:(ForemanDetailInfoModel *)_model{
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:_model.headUrl] placeholderImage:nil];
    _nameLabel.text = _model.name;
    _appointmentNumLabel.text = [NSString stringWithFormat:@"被预约%@次",_model.frequency];
    [_ratingBarView displayRating:[_model.star floatValue]];
    
    _FromLabel.text = [NSString stringWithFormat:@"%@公里",_model.distance];
    _yearLabel.text = [NSString stringWithFormat:@"%@年",_model.year];
    _addressLabel.text = _model.homeTown;
    
    _dataArr1 = [NSMutableArray arrayWithArray:_model.performances];
    _dataArr2 = [NSMutableArray arrayWithArray:_model.appraise];
    
    _currentWorkNumLabel.text = [NSString stringWithFormat:@"正在施工（%lu）",_dataArr1.count];
    _currentRecommendLabel.text = [NSString stringWithFormat:@"评价详情（%lu）",_dataArr2.count];
    
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
    if (!_placeholdLab.hidden) {
        [SVProgressHUD showErrorWithStatus:@"请输入评价内容"];
        return;
    }
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults] objectForKey:USERINFO];
    NSString * star = [NSString stringWithFormat:@"%d",(int)_sRateBarView.rating];
    [SVProgressHUD showWithStatus:@"加载中" maskType:SVProgressHUDMaskTypeClear];
    [[AppService sharedManager] request_appraise_Http_userId:[dic objectForKey:@"userId"] contractorId:_contractorId content:_wTextView.text start:star success:^(id responseObject) {
        BaseModel * baseModel = (BaseModel *)responseObject;
        if ([RETURN_CODE_SUCCESS isEqualToString:baseModel.retcode]) {
            [SVProgressHUD showSuccessWithStatus:baseModel.retinfo];
        }else{
            [SVProgressHUD showErrorWithStatus:baseModel.retinfo];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:OTHER_ERROR_MESSAGE];
    }];
}

- (IBAction)liJiYuYueClick:(id)sender {
    HomeSelectViewController * vc = [[HomeSelectViewController alloc] init];
    vc.callBack = ^(NSString * homeId){
        NSDictionary * dic = [[NSUserDefaults standardUserDefaults] objectForKey:USERINFO];
        [SVProgressHUD showWithStatus:@"加载中" maskType:SVProgressHUDMaskTypeClear];
        [[AppService sharedManager] request_reservate_Http_homeId:homeId userId:[dic objectForKey:@"userId"] contractorId:_contractorId success:^(id responseObject) {
            BaseModel * baseModel = (BaseModel *)responseObject;
            if ([RETURN_CODE_SUCCESS isEqualToString:baseModel.retcode]) {
                [SVProgressHUD showSuccessWithStatus:baseModel.retinfo];
            }else{
                [SVProgressHUD showErrorWithStatus:baseModel.retinfo];
            }
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:OTHER_ERROR_MESSAGE];
        }];
    };
    [self.navigationController pushViewController:vc animated:YES];
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
        SecondTableViewCell *cell = (SecondTableViewCell *)self.secondCell;
        AppraiseModel * aModel = (AppraiseModel *)[_dataArr2 objectAtIndex:indexPath.row];
        [cell refrashWithAppraiseModel:aModel];
        CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        return size.height > 95 ? 1 + size.height:95;
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
