//
//  ProductsDetailsTableViewController.m
//  IPSOS
//
//  Created by 沈鹏 on 14-7-31.
//  Copyright (c) 2014年 沈鹏. All rights reserved.
//

#import "ProductsDetailsTableViewController2.h"


@interface ProductsDetailsTableViewController2 ()<UINavigationControllerDelegate,UIActionSheetDelegate,UIAlertViewDelegate>
{

    StoreData *storeData;
    
    NSMutableArray *dataSource;
    QuestionsData2 *questionData;

    UILabel *label2;

}
@property (nonatomic ,strong)UITextField *textfield;
@end

@implementation ProductsDetailsTableViewController2

- (void)viewDidLoad {
    [super viewDidLoad];

    storeData = [[DataManager shareDataManager] storeData];
    questionData = [[QuestionsData2 alloc] initWithPlistPath:storeData.plistPath];
    dataSource = [questionData getQuestions:self.title];
  
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)completeEvent:(id)sender {
    BOOL verification = true;
    //遍历所有问题。判断问题选项有没有为空
    for (NSDictionary *dic in dataSource) {
        if ([[dic valueForKey:@"result"] count] == 0) {
            verification = false;
        }
        for (NSString* res in [dic valueForKey:@"result"]) {
            if ([res isEqualToString:@"主画面指引吊牌"] && [[dic valueForKey:@"tagNum"] integerValue]<1) {
                
                [ZAActivityBar showErrorWithStatus:@"请查看吊牌数量"];
                return;
                
            }
//            else if ([[dic valueForKey:@"flagNum"] integerValue]<1&&[res isEqualToString:@"【店内】吊旗"]){
//              
//                
//                [ZAActivityBar showErrorWithStatus:@"请查看吊旗数量"];
//                return;
//                
//            }
        }
        
    }

    if(verification){
        if([questionData writeToPlist:storeData.plistPath]){
                [self.navigationController popViewControllerAnimated:YES];
        }else{
                [ZAActivityBar showErrorWithStatus:@"数据文件写入失败"];
        }
    }else{
        [ZAActivityBar showErrorWithStatus:@"请查看是否有问题没有选择"];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [dataSource count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[dataSource objectAtIndex:section] valueForKey:@"name"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [[[dataSource objectAtIndex:section] valueForKey:@"options"] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 43;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;

    cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    UILabel *label = (UILabel*)[cell.contentView viewWithTag:1];
    label2 = (UILabel*)[cell.contentView viewWithTag:11];
    label2.backgroundColor = [UIColor grayColor];
    label2.hidden = YES;
    
    label.text = [[[dataSource objectAtIndex:indexPath.section] valueForKey:@"options"] objectAtIndex:indexPath.row];
    label.font = [UIFont systemFontOfSize:13];
    label.adjustsFontSizeToFitWidth = true;
    
    NSArray *result = [[dataSource objectAtIndex:indexPath.section] valueForKey:@"result"];
    
    NSString* numText = [[dataSource objectAtIndex:indexPath.section] valueForKey:@"tagNum"];
//    NSString* numText2 = [[dataSource objectAtIndex:indexPath.section] valueForKey:@"flagNum"];
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    
    for (NSString *res in result) {
        if ([res isEqualToString:label.text]) {
            if ([res isEqualToString:@"主画面指引吊牌"]&&[numText integerValue]>0) {
                label2.hidden = NO;
                label2.text = [NSString stringWithFormat:@"%@个",numText];
               
            }
//            else if ([res isEqualToString:@"【店内】吊旗"]&&[numText2 integerValue]>0){
//                label2.hidden = NO;
//                label2.text = [NSString stringWithFormat:@"%@个",numText2];
//                
//            }
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        }
    }

    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *options = [[[dataSource objectAtIndex:indexPath.section] valueForKey:@"options"] objectAtIndex:indexPath.row];
    
    NSMutableArray *result = [[dataSource objectAtIndex:indexPath.section] valueForKey:@"result"];
    

    if ([[tableView cellForRowAtIndexPath:indexPath] accessoryType] == UITableViewCellAccessoryCheckmark) {
        [result removeObject:options];
        
    }else{
        if ([options isEqualToString:@"主画面指引吊牌"]) {

            UIAlertView *dialog = [[UIAlertView alloc] initWithTitle:@"吊牌个数" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
            [dialog setAlertViewStyle:UIAlertViewStylePlainTextInput];
            dialog.tag = 1;
            [[dialog textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
            [dialog show];
        }
//        else if ([options isEqualToString:@"【店内】吊旗"]){
//            UIAlertView *dialog = [[UIAlertView alloc] initWithTitle:@"吊旗个数" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
//            [dialog setAlertViewStyle:UIAlertViewStylePlainTextInput];
//            dialog.tag = 2;
//            [[dialog textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
//            [dialog show];
//        }
        [result addObject:options];
       
    }



    NSArray *arr = [[dataSource objectAtIndex:indexPath.section] valueForKey:@"options"];
    if (indexPath.row == arr.count-1) {
        [result removeAllObjects];
        [result addObject:options];
    }else{
        [result removeObject:@"以上皆无"];
    }

    [tableView reloadData];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSDictionary* dic = [dataSource objectAtIndex:0];
    if (alertView.tag == 1) {
        if (buttonIndex == 0) {
            NSString* text = [alertView textFieldAtIndex:0].text;
            if (text==nil || [text integerValue]<1){
                [ZAActivityBar showErrorWithStatus:@"吊牌个数必须大于0"];
                return;
            };
            
            [dic setValue:[alertView textFieldAtIndex:0].text forKey:@"tagNum"];
            [self.tableView reloadData];
            
        }
    }
//    else{
//        if (buttonIndex == 0) {
//            NSString* text = [alertView textFieldAtIndex:0].text;
//            if (text==nil || [text integerValue]<1){
//                [ZAActivityBar showErrorWithStatus:@"吊旗个数必须大于0"];
//                return;
//            };
//            
//            [dic setValue:[alertView textFieldAtIndex:0].text forKey:@"flagNum"];
//            [self.tableView reloadData];
//            
//        }
//    }
    
}

@end
