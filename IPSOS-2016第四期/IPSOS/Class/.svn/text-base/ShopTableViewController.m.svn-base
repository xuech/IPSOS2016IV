//
//  ShopTableViewController.m
//  IPSOS
//
//  Created by 沈鹏 on 14-7-25.
//  Copyright (c) 2014年 沈鹏. All rights reserved.
//

#import "ShopTableViewController.h"
//#import "ShopDetailsViewController.h"

@interface ShopTableViewController ()<DataManagerDelegate,UISearchBarDelegate>
{
    NSMutableArray *dataSource;
    int selectNum;
}

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation ShopTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = RGBCOLOR(107, 169, 169);
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    dataSource = [NSMutableArray new];
    
    self.textPull = @"下拉刷新";
    self.textRelease = @"松开刷新";
    self.textLoading = @"正在刷新。。。";
    
    [DataManager shareDataManager].delegate = self;
    _searchBar.delegate = self;
    [ZAActivityBar showWithStatus:@"正在从服务器获取数据。。。。。"];
    
}



-(void)refresh
{
//    [[DataManager shareDataManager] refreshShopData];
    [self searchBarCancelButtonClicked:self.searchBar];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.title = @"店铺";
    [self performSelector:@selector(refreshData) withObject:nil afterDelay:0.5f];
}

-(void)refreshData
{
    [DataManager shareDataManager].delegate = self;
    [[DataManager shareDataManager] refreshShopData];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.title = @"";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - DataManagerDelegate
-(void)shopDataRefreshSuccess:(id)data
{
   
    dataSource = [data copy];
    [ZAActivityBar dismiss];
    [self stopLoading];
    [self.tableView reloadData];
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"YYYY年MM月dd日";
    int count = 0;
    for (NSDictionary *dic in data) {
        NSDate *endDate = [formatter dateFromString:[dic valueForKey:@"EndDate"]];
        if([endDate timeIntervalSinceDate:[NSDate date]]<0){
            count++;
        }
    }
    if (count == [data count]) {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        [ZAActivityBar showErrorWithStatus:@"所有任务已过期！"];
    }
}

-(void)shopDataRefreshFaile:(NSError *)error
{
    [self stopLoading];
    [ZAActivityBar showErrorWithStatus:@"数据获取失败！"];
}

#pragma mark - UISearchBarDelegate
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [_searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar endEditing:YES];
    [[DataManager shareDataManager] searchShop:searchBar.text];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = @"";
    [searchBar endEditing:YES];
    [_searchBar setShowsCancelButton:NO animated:YES];
    [[DataManager shareDataManager] refreshShopData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    UIImageView *icon = (UIImageView*)VIEWWITHTAG([cell contentView], 1);
    UILabel *shopName = (UILabel*)VIEWWITHTAG([cell contentView], 2);
    UIImageView *mark = (UIImageView*)VIEWWITHTAG([cell contentView], 3);
    
    StoreData *storeData = [[StoreData alloc] init:[dataSource objectAtIndex:indexPath.row]];
    
    shopName.text = storeData.storeName;
//    BOOL isChecked = storeData.isChecked;
    int checkStatus = storeData.checkStatus;
    
    if (checkStatus == 1) {
        [mark setImage:IMAGENAMED(@"icon-done")];
    }else if(checkStatus == 0){
        [mark setImage:IMAGENAMED(@"icon-undo")];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectNum = indexPath.row;
    [_searchBar endEditing:YES];
    [_searchBar setShowsCancelButton:NO animated:NO];
    
    StoreData *storeData = [[StoreData alloc] init:[dataSource objectAtIndex:selectNum]];

    //判断是否完成过
    if (storeData.checkStatus != 0) {
        return;
    }
    if ([storeData.endDate timeIntervalSinceDate:[NSDate date]]<0) {
        [ZAActivityBar showErrorWithStatus:@"任务已过期！"];
        return;
    }
    
    //判断店铺相关数据文件夹
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *storeId = storeData.storeId;
    NSString *storeIdPath = storeData.storeIdPath;
    NSString *plistPath = storeData.plistPath;
    
    NSError *error;
    [fileManager createDirectoryAtPath:storeIdPath withIntermediateDirectories:YES attributes:nil error:&error];
    
    if (error) {
        [ZAActivityBar showErrorWithStatus:@"数据文件夹创建失败"];
        return;
    }
    
    BOOL isCreate = YES;
    if (![fileManager fileExistsAtPath:plistPath]) {
        //获取plist模版数据
        NSMutableDictionary *plistData = [NSMutableDictionary dictionaryWithDictionary:[[DataManager shareDataManager] plistDataTemplate]];
        
        [plistData setValue:storeId forKey:@"storeId"];
        [plistData setValue:storeData.scheduleCategory forKey:@"scheduleCategory"];
        [plistData setValue:[NSNumber numberWithInt:storeData.scheduleId] forKey:@"schedule"];
    
        isCreate = WRITE_PLISTDATA(plistData, plistPath);
        //生成json文件
        NSString *jsonData = [plistData JSONString];
//        [jsonData writeToFile:[NSString stringWithFormat:@"%@/aaa.json",storeData.storeIdPath] atomically:YES];
    }
    
    if (isCreate) {
        //将数据缓存到单例里面
        [[DataManager shareDataManager] setStoreData:storeData];
        [self performSegueWithIdentifier:@"ShopDetails" sender:nil];
    }else{
        [ZAActivityBar showErrorWithStatus:@"数据文件创建失败"];
    }
    
    
}
- (IBAction)logout:(id)sender {
    //删除本地通知
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [USER_DEFAULT setValue:@"" forKey:@"uid"];
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
    [Flurry logEvent:@"注销" withParameters:[Context getSystemInfo]];
}



@end
