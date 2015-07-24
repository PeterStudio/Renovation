//
//  MyRepairViewController.m
//  Renovation
//
//  Created by duwen on 15/6/3.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "MyRepairViewController.h"
#import "NearWorkersTableViewCell.h"

#define cellIndentifier @"NearWorkersTableViewCellIdentifier"
@interface MyRepairViewController ()

@end

@implementation MyRepairViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"我的装修";
    
    UINib *cellNib = [UINib nibWithNibName:@"NearWorkersTableViewCell" bundle:nil];
    [_mainTableView registerNib:cellNib forCellReuseIdentifier:cellIndentifier];
    self.prototypeCell  = [_mainTableView dequeueReusableCellWithIdentifier:cellIndentifier];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;//[self.sourceArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NearWorkersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90.0f;
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
