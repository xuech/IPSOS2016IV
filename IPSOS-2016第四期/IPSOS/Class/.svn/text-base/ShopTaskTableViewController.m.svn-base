//
//  ShopTaskTableViewController.m
//  IPSOS
//
//  Created by 沈鹏 on 14-7-30.
//  Copyright (c) 2014年 沈鹏. All rights reserved.
//

#import "ShopTaskTableViewController.h"
#import "ProductsDetailsTableViewController.h"
#import "ShopTaskTableViewCell.h"

@interface ShopTaskTableViewController ()<ShopTaskTableViewCellDelegate>
{
    NSDictionary *dataSource;
    NSArray *productList;
    NSArray *questionsOptions;
    NSString *productName;
    
    StoreData *storeData;
    NSArray *taskData;
    QuestionsData *questionData;
}

@end

@implementation ShopTaskTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    storeData = [[DataManager shareDataManager] storeData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = @"店检商品";

    questionData = [[QuestionsData alloc] initWithPlistPath:storeData.plistPath];
    productList = [questionData data];
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

- (IBAction)completeEvent:(id)sender {
    for (NSDictionary *dic in productList) {
        if (![[dic valueForKey:@"isSelected"] boolValue]) {
            [ZAActivityBar showErrorWithStatus:@"请确认所有产品已经记录完成"];
            return;
        }
    }
    NSMutableDictionary *plistData = PLISTDATA(storeData.plistPath);
    NSMutableArray *taskData2 = [plistData valueForKey:@"taskData2"];
    
//    BOOL allNO = true;
//    for (NSDictionary *dic in productList) {
//        
//        if ([[dic valueForKey:@"isHave"] boolValue]) {
//                if ([[[[dic valueForKey:@"questions"] objectAtIndex:2] valueForKey:@"result"] count] != 0) {
//                    if ([[[[[dic valueForKey:@"questions"] objectAtIndex:2] valueForKey:@"result"] objectAtIndex:0] isEqualToString:@"有"]) {
//                        NSString *name = [[dic valueForKey:@"productName"] substringToIndex:2];
//                        for (NSMutableDictionary *d in taskData2) {
//                            NSString *name2 = [[d valueForKey:@"productName"] substringToIndex:2];
//                            if ([[dic valueForKey:@"productName"]  isEqualToString:@"希爱力28片装(5mg)"]) {
//                                if ([[d valueForKey:@"productName"]  isEqualToString:@"希爱力28片装(5mg)"]) {
//                                    [d setValue:[NSNumber numberWithBool:YES] forKey:@"isHave"];
//                                }
//                            }else if(![[d valueForKey:@"productName"]  isEqualToString:@"希爱力28片装(5mg)"]){
//                                if ([name isEqualToString:name2]) {
//                                    
//                                    [d setValue:[NSNumber numberWithBool:YES] forKey:@"isHave"];
//                                }
//                            }
//                        }
//                        allNO = false;
//                    }
//                
//            }
//        }
//        
//    }
//    if (allNO) {
//        [plistData setValue:[NSNumber numberWithBool:YES] forKey:@"isTaskData2"];
//    }
    
    for (NSMutableDictionary *d in taskData2) {
        [d setValue:[NSNumber numberWithBool:YES] forKey:@"isHave"];
        
    }

    
    [plistData setValue:[NSNumber numberWithBool:YES] forKey:@"isTaskData"];
    if([plistData writeToFile:storeData.plistPath atomically:YES]){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [ZAActivityBar showErrorWithStatus:@"数据文件写入失败"];
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *headName = @"";
    if (section == 0) {
        headName = @"ED";
    }else if (section == 1){
        headName = @"抗生素";
    }else if (section == 2){
        headName = @"糖尿病类药物";
    }else if (section == 3){
        headName = @"抗抑郁类药物";
    }
    return headName;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 0;
    if (section == 0) {
        count = 10;
    }else if (section == 1){
        count = 6;
    }else if (section == 2){
        count = 8;
    }else if (section == 3){
        count = 2;
    }
    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
//    if (indexPath.section != 0) {
//        row = row+9;
//    }
    switch (indexPath.section) {
        case 0:
            
            break;
        case 1:
            row = row+10;
            break;
        case 2:
            row = row+16;
            break;
        case 3:
            row = row+16+8;
            break;
            
        default:
            break;
    }
    ShopTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.delegate = self;
    cell.productName = [[productList objectAtIndex:row] valueForKey:@"productName"];
    cell.isSelected = [[[productList objectAtIndex:row] valueForKey:@"isSelected"] boolValue];
    cell.isHave = [[[productList objectAtIndex:row] valueForKey:@"isHave"] boolValue];
    cell.productLabel.text = [[productList objectAtIndex:row] valueForKey:@"productName"];
    
    return cell;
}

-(void)ShopTaskTableViewCellHaveEvent:(NSString *)tProductName
{
    
    productName = tProductName;
    for (NSDictionary *dic in productList) {
        if ([[dic valueForKey:@"productName"] isEqualToString:tProductName]) {
            [dic setValue:[NSNumber numberWithBool:true] forKey:@"isSelected"];
            [dic setValue:[NSNumber numberWithBool:true] forKey:@"isHave"];
        }
    }
    [questionData writeToPlist:storeData.plistPath];
#warning 这个是无选择项的
//    if ([productName isEqualToString:@"糖尿病类药物"]){
//        return;
//    }
//    
//    if ([productName isEqualToString:@"抗抑郁类药物"]){
//        return;
//    }
    
//    if ([productName isEqualToString:@"优泌林&优泌林70/30&优泌林中效"]){
//        return;
//    }
//    if ([productName isEqualToString:@"优泌乐&优泌乐25&优泌乐50"]){
//        return;
//    }
//    if ([productName isEqualToString:@"优伴II&优伴经典"]){
//        return;
//    }
//    if ([productName isEqualToString:@"百优解"]){
//        return;
//    }
    [self performSegueWithIdentifier:@"ProductDetails" sender:nil];
}
-(void)ShopTaskTableViewCellNoHaveEvent:(NSString *) tProductName
{
    for (NSDictionary *dic in productList) {
        if ([[dic valueForKey:@"productName"] isEqualToString:tProductName]) {
            [dic setValue:[NSNumber numberWithBool:true] forKey:@"isSelected"];
            [dic setValue:[NSNumber numberWithBool:false] forKey:@"isHave"];
        }
    }
    [questionData writeToPlist:storeData.plistPath];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ProductDetails"]) {
        [segue.destinationViewController setTitle:productName];
    }
    
}

@end
