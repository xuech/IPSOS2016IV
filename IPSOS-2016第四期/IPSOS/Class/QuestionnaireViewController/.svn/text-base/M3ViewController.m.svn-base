//
//  M3ViewController.m
//  IPSOS
//
//  Created by 沈鹏 on 14-8-11.
//  Copyright (c) 2014年 沈鹏. All rights reserved.
//

#import "M3ViewController.h"
#import "ShopTaskTableViewCell.h"

@interface M3ViewController ()<ShopTaskTableViewCellDelegate>
{
    StoreData *storeData;
    NSMutableDictionary *mData;
    NSMutableArray *m3Questions;
    NSMutableDictionary *dic;
}
@property(nonatomic,strong)NSMutableArray* m5Array;
@property(nonatomic,strong)NSMutableArray* m6_7Array;
@property(nonatomic,strong)NSMutableArray* x2Array;

@property(nonatomic,strong)NSMutableArray* m5Selected;
@property(nonatomic,strong)NSMutableArray* m6_7Selected;
@end

@implementation M3ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    dic = [NSMutableDictionary dictionary];
    self.m5Selected = [NSMutableArray array];
    self.m6_7Selected = [NSMutableArray array];
    
    [self getData];
    
    
//    NSMutableDictionary *plistData = PLISTDATA(storeData.plistPath);
    
    self.m5Array = [NSMutableArray array];
    self.m6_7Array = [NSMutableArray array];
    self.x2Array = [NSMutableArray array];
    

    //解决最后一行显示不全的问题
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getData) name:@"refreshData" object:nil];
}

-(void) getData{
    storeData = [[DataManager shareDataManager] storeData];
    mData = [[NSMutableDictionary dictionaryWithContentsOfFile:storeData.plistPath] valueForKey:@"mData"];
    NSLog(@"mData======%@",mData);
//    NSArray* array = [mData allKeys];
//    NSLog(@"mdata==%@",mData);
//    [self.m5Selected removeAllObjects];
//    [self.m6_7Selected removeAllObjects];
//    for (NSString* key in array) {
//        if ([key hasPrefix:@"M5"]&& key.length>2) {
//            [self.m5Selected addObject:key];
//            [self.m5Selected sortedArrayUsingSelector:@selector(compare:)];
//            NSLog(@"m5Selected===%@",self.m5Selected);
//        }else if ([key hasPrefix:@"M6"]||[key hasPrefix:@"M7"])
//        {
//            [self.m6_7Selected addObject:key];
//        }
//    }
//    [self.tableView reloadData];
    
}
-(void)setDataSource:(NSMutableArray *)dataSource
{
    _dataSource = dataSource;
    for (NSString* name in self.dataSource) {

         NSLog(@"name====%@",name);
        

        if ([name hasPrefix:@"M5"]) {
            
            [self.m5Array addObject:name];
            NSString* m5String = [name substringToIndex:3];
            [self.m5Selected addObject:m5String];
            
            
        }else if ([name hasPrefix:@"M6"] || [name hasPrefix:@"M7"]){
            
            [self.m6_7Array addObject:name];
            NSString* m6String = [name substringToIndex:3];
            [self.m6_7Selected addObject:m6String];
            NSLog(@"m6_7Selected===%@",self.m6_7Selected);
            
        }else if ([name hasPrefix:@"X2"]){
            [self.x2Array addObject:name];
        }
    }
//     [self.tableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 0;
    if (section == 0) {
        count = self.x2Array.count;
    }else if (section == 1){
        count = self.m5Array.count;
    }else if (section == 2){
        count = self.m6_7Array.count;
    }
    return count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (indexPath.section == 0) {
            ShopTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"X2Cell"];
            cell.delegate = self;
            cell.productLabel.text = self.x2Array[indexPath.row];
            cell.productName = self.x2Array[indexPath.row];

            NSString* x2 = [NSString stringWithFormat:@"%@",[mData valueForKey:@"X2"]];
            if ([x2 isEqualToString:@"1"]) {
                cell.isSelected = YES;
                cell.isHave = YES;
            }else if([x2 isEqualToString:@"2"]){
                cell.isSelected = YES;
                cell.isHave = NO;
            }else{
                cell.isSelected = NO;
            }

            return cell;
        }else if (indexPath.section == 1) {
            ShopTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
            cell.delegate = self;
            cell.productLabel.text = [self.m5Array objectAtIndex:indexPath.row];
            cell.productName = [self.m5Array objectAtIndex:indexPath.row];
            
            NSString* m5String = self.m5Selected[indexPath.row];
            NSString* m5 = [NSString stringWithFormat:@"%@",[mData valueForKey:m5String]];
            if ([m5 isEqualToString:@"1"]) {
                cell.isSelected = YES;
                cell.isHave = YES;
            }else if([m5 isEqualToString:@"2"]){
                cell.isSelected = YES;
                cell.isHave = NO;
            }else{
                cell.isSelected = NO;
            }

            return cell;
        }else {
            ShopTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductCell"];
            cell.delegate = self;
            cell.productLabel.text = [self.m6_7Array objectAtIndex:indexPath.row];
            cell.productName = [self.m6_7Array objectAtIndex:indexPath.row];
            
            NSString* m6String = self.m6_7Selected[indexPath.row];
            NSString* m6 = [NSString stringWithFormat:@"%@",[mData valueForKey:m6String]];
            if ([m6 isEqualToString:@"1"]) {
                cell.isSelected = YES;
                cell.isHave = YES;
            }else if([m6 isEqualToString:@"2"]){
                cell.isSelected = YES;
                cell.isHave = NO;
            }else{
                cell.isSelected = NO;
            }

            return cell;
        }
//        else{
//            
//            UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DeviceCell"] ;
//            cell.textLabel.text = _dataSource[indexPath.row];
//            cell.textLabel.numberOfLines = 0;
//            
//            return cell;
//        }

   
}
-(void)ShopTaskTableViewCellHaveEvent:(NSString *)tProductName{
    
    if ([tProductName hasPrefix:@"X2"]) {
        tProductName = [tProductName substringToIndex:2];
    }else{
        tProductName = [tProductName substringToIndex:3];
    }
    NSLog(@"aaaaa===%@",tProductName);
    
    [self.delegate m3Event:YES withNum:1 withProductName:tProductName];
//    [dic setValue:[NSNumber numberWithBool:YES] forKeyPath:tProductName];
//    NSLog(@"dic==%@",dic);
//    NSArray* array = [dic allKeys];
//    NSLog(@"array==%@",array);
//    for (NSString* key in array) {
//        if ([key hasPrefix:@"M5"]) {
//            [self.m5Selected addObject:key];
//        }else if ([key hasPrefix:@"M6"]||[key hasPrefix:@"M7"])
//        {
//            [self.m6_7Selected addObject:key];
//        }
//    }
//    [self.tableView reloadData];
    
}

-(void)ShopTaskTableViewCellNoHaveEvent:(NSString *)productName
{
    if ([productName hasPrefix:@"X2"]) {
        productName = [productName substringToIndex:2];
    }else{
        productName = [productName substringToIndex:3];
    }

     NSLog(@"bbbbb===%@",productName);
    
    [self.delegate m3Event:NO withNum:2 withProductName:productName];
//    [dic setValue:[NSNumber numberWithBool:NO] forKeyPath:productName];
//    
//    NSArray* array = [dic allKeys];
//    for (NSString* key in array) {
//        if ([key hasPrefix:@"M5"]) {
//            [self.m5Selected addObject:key];
//        }else if ([key hasPrefix:@"M6"]||[key hasPrefix:@"M7"])
//        {
//            [self.m6_7Selected addObject:key];
//        }
//    }
//    [self.tableView reloadData];

}

- (IBAction)m3ButtonEvent:(id)sender {
    
    
//    [_img1 setImage:IMAGENAMED(@"icon-checkbox")];
//    [_img2 setImage:IMAGENAMED(@"icon-checkbox")];
//    switch ([sender tag]) {
//        case 1:
//            [_img1 setImage:IMAGENAMED(@"icon-checkboxselected")];
//            [self.delegate m3Event:YES withNum:1];
//            break;
//        case 2:
//            [_img2 setImage:IMAGENAMED(@"icon-checkboxselected")];
//            [self.delegate m3Event:NO withNum:1];
//            break;
//            
//        default:
//            break;
//    }
   
    
}

- (IBAction)m4ButtonEvent:(id)sender {
//    [_img3 setImage:IMAGENAMED(@"icon-checkbox")];
//    [_img4 setImage:IMAGENAMED(@"icon-checkbox")];
//    switch ([sender tag]) {
//        case 1:
//            [_img3 setImage:IMAGENAMED(@"icon-checkboxselected")];
//            [self.delegate m3Event:YES withNum:2];
//            break;
//        case 2:
//            [_img4 setImage:IMAGENAMED(@"icon-checkboxselected")];
//            [self.delegate m3Event:NO withNum:2];
//            break;
//            
//        default:
//            break;
//    }
}
@end
