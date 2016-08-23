//
//  ShopTaskTableViewController.m
//  IPSOS
//
//  Created by 沈鹏 on 14-7-30.
//  Copyright (c) 2014年 沈鹏. All rights reserved.
//

#import "ShopTaskTableViewController2.h"
#import "ProductsDetailsTableViewController.h"
#import "ShopTaskTableViewCell.h"

@interface ShopTaskTableViewController2 ()<ShopTaskTableViewCellDelegate>
{
    NSDictionary *dataSource;
    NSMutableArray *productList;
    NSArray *questionsOptions;
    NSString *productName;
    
    StoreData *storeData;
    NSArray *taskData;
    QuestionsData2 *questionData;
    NSArray *sectionData;
}

@end

@implementation ShopTaskTableViewController2


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    storeData = [[DataManager shareDataManager] storeData];
    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(completeEvent) name:@"completeEvent" object:nil];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = @"陈列品牌";

    questionData = [[QuestionsData2 alloc] initWithPlistPath:storeData.plistPath];
    NSArray *temp = [questionData data];
    productList = [NSMutableArray new];
    for (NSMutableDictionary *dic in temp) {
//        if ([[dic valueForKey:@"isHave"] boolValue]) {
//            [productList addObject:dic];
//        }
        [productList addObject:dic];
    }
    NSMutableArray *tempED = [NSMutableArray new];
    //2016 第三期改动 添加糖尿病类型的问卷
    NSMutableArray *tnbData = [NSMutableArray new];
    for (NSDictionary *dic in productList) {
        if ([[dic valueForKey:@"tag"] intValue] == 1) {
            [tempED addObject:@"ED"];
        }else {
            //2016 第三期改动
            [tnbData addObject:@"糖尿病"];
        }

    }
    //2016 第三期改动
//    sectionData = [[NSArray alloc] initWithObjects:tempED.count!=0?tempED:nil, nil];
    
    sectionData = [[NSArray alloc] initWithObjects:tempED,tnbData, nil];
    [self.tableView reloadData];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.title = @"";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)completeEvent{
    for (NSDictionary *dic in productList) {
        if (![[dic valueForKeyPath:@"isSelected"] boolValue]) {
            [ZAActivityBar showErrorWithStatus:@"请确认所有产品已经记录完成"];
            return;
        }
    }
    NSMutableDictionary *plistData = PLISTDATA(storeData.plistPath);
    [plistData setValue:[NSNumber numberWithBool:YES] forKey:@"isTaskData2"];
    if([plistData writeToFile:storeData.plistPath atomically:YES]){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [ZAActivityBar showErrorWithStatus:@"数据文件写入失败"];
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [sectionData count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
//    NSString *headName = @"ED";
//    if (section == 0&&sectionData.count>1) {
//        headName = @"ED";
//    }
//    else{
//        headName = @"糖尿病";
//    }
    return [[sectionData objectAtIndex:section] objectAtIndex:0];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [[sectionData objectAtIndex:section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if (indexPath.section != 0) {
        row = row+[[sectionData objectAtIndex:0] count];
    }
    ShopTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.delegate = self;
    cell.productName = [[productList objectAtIndex:row] valueForKey:@"productName"];
    cell.isSelected = [[[productList objectAtIndex:row] valueForKey:@"isSelected"] boolValue];
    cell.isHave = [[[productList objectAtIndex:row] valueForKey:@"isHave"] boolValue];
    cell.productLabel.text = [[productList objectAtIndex:row] valueForKey:@"productName"];
    
    if([[[productList objectAtIndex:row] valueForKey:@"isSelected"] boolValue]){
       
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if (indexPath.section != 0) {
        row = row+[[sectionData objectAtIndex:0] count];
    }
    productName = [[productList objectAtIndex:row] valueForKey:@"productName"];
    for (NSDictionary *dic in productList) {
        if ([[dic valueForKey:@"productName"] isEqualToString:productName]) {
            [dic setValue:[NSNumber numberWithBool:true] forKey:@"isSelected"];
//            [dic setValue:[NSNumber numberWithBool:true] forKey:@"isHave"];
        }
    }
    [questionData writeToPlist:storeData.plistPath];
    [self performSegueWithIdentifier:@"ProductDetails" sender:nil];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ProductDetails"]) {
        [segue.destinationViewController setTitle:productName];
    }
    
}

@end
