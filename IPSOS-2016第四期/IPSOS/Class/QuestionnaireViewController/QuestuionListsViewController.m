//
//  QuestuionListsViewController.m
//  IPSOS
//
//  Created by xuech on 16/3/1.
//  Copyright (c) 2016年 沈鹏. All rights reserved.
//

#import "QuestuionListsViewController.h"
#import "ShopTaskTableViewCell.h"
#import <AVFoundation/AVFoundation.h>

@interface QuestuionListsViewController ()<UITableViewDataSource,UITableViewDelegate,ShopTaskTableViewCellDelegate,AVAudioRecorderDelegate>
{
    StoreData *storeData;
    NSMutableDictionary *mData;
    NSMutableArray * questionsData;

    NSMutableArray * m5Selected;
    NSMutableArray * m7Array;
    NSMutableArray * m7Selected;
    NSMutableArray* selectedArray;
    BOOL refreshData;
    BOOL haveM5;
    BOOL haveM7;

}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (retain,nonatomic) AVAudioRecorder *recorder;
@end

@implementation QuestuionListsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initDataSource];
    [self audioInit];
    refreshData = NO;
    haveM5 = NO;
    haveM7 = NO;
    [_recorder record];
    [mData setValue:[[NSDate date] description] forKey:@"startTime"];
    //解决最后一行显示不全的问题
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationItem setHidesBackButton:YES];
}

-(void)audioInit
{
    NSError * err = nil;
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory :AVAudioSessionCategoryPlayAndRecord error:&err];
    
    UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
    
    AudioSessionSetProperty (kAudioSessionProperty_OverrideCategoryDefaultToSpeaker,sizeof (audioRouteOverride),&audioRouteOverride);
    
    if(err){
        NSLog(@"audioSession: %@ %ld %@", [err domain], (long)[err code], [[err userInfo] description]);
        return;
    }
    
    [audioSession setActive:YES error:&err];
    
    err = nil;
    if(err){
        NSLog(@"audioSession: %@ %ld %@", [err domain], (long)[err code], [[err userInfo] description]);
        return;
    }
    
    NSMutableDictionary * recordSetting = [NSMutableDictionary dictionary];
    
    [recordSetting setValue :[NSNumber numberWithInt:kAudioFormatAppleIMA4] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat:16000.0] forKey:AVSampleRateKey];
    [recordSetting setValue:[NSNumber numberWithInt: 1] forKey:AVNumberOfChannelsKey];
    StoreData *storeData = [[DataManager shareDataManager] storeData];
    NSString *recordPath = [NSString stringWithFormat:@"%@/qa.caf", storeData.storeIdPath];
    NSURL * url = [NSURL fileURLWithPath:recordPath];
    
    err = nil;
    
    NSData * audioData = [NSData dataWithContentsOfFile:[url path] options: 0 error:&err];
    
    if(audioData)
    {
        NSFileManager *fm = [NSFileManager defaultManager];
        [fm removeItemAtPath:[url path] error:&err];
    }
    
    err = nil;
    
    if(_recorder){[_recorder stop];_recorder = nil;}
    
    _recorder = [[AVAudioRecorder alloc] initWithURL:url settings:recordSetting error:&err];
    
    if(!_recorder){
        NSLog(@"recorder: %@ %ld %@", [err domain], (long)[err code], [[err userInfo] description]);
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle: @"Warning"
                                   message: [err localizedDescription]
                                  delegate: nil
                         cancelButtonTitle:@"OK"
                         otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    [_recorder setDelegate:self];
    [_recorder prepareToRecord];
    _recorder.meteringEnabled = YES;
}

-(void)initDataSource
{
    questionsData = [NSMutableArray array];
    
    m5Selected = [NSMutableArray array];
    m7Array = [NSMutableArray array];
    m7Selected = [NSMutableArray array];
    selectedArray = [NSMutableArray array];
    
    storeData = [[DataManager shareDataManager] storeData];
    mData = [[NSMutableDictionary dictionaryWithContentsOfFile:storeData.plistPath] valueForKey:@"mData"];
    NSMutableDictionary *plistData = PLISTDATA(storeData.plistPath);
    NSMutableArray *taskData2 = [plistData valueForKey:@"taskData2"];
    //问答
    NSMutableArray* questArray = [NSMutableArray new];
    
    NSMutableArray* optionsArray = [NSMutableArray new];
    
    for (int i = 0; i<taskData2.count; i++) {
        NSArray *result = [[[[taskData2 objectAtIndex:i] valueForKey:@"questions"] objectAtIndex:0] valueForKey:@"result"];
        NSArray* options = [[[[taskData2 objectAtIndex:i] valueForKey:@"questions"] objectAtIndex:0] valueForKey:@"options"];
        //2016 第三期
//        if (i == 2) {
//            [optionsArray addObjectsFromArray:options];
//            NSPredicate *thePredicate = [NSPredicate predicateWithFormat:@"NOT (SELF in %@)", result];
////            未选中的问题
//            [optionsArray filterUsingPredicate:thePredicate];
//            for (NSString* string in optionsArray) {
//                NSLog(@"%@",string);
//            }
//            
//            if ([[result objectAtIndex:0] isEqualToString:@"以上皆无"]) {
//                [self getM4aTobQuestionsArray];
//                [self getM4cToeQuestionsArray];
//                break;
//            }
//
//            if ([optionsArray containsObject:@"糖尿病健康知识宝典-陈列架"]&& [optionsArray containsObject:@"糖尿病心天地APP教育单页–陈列架"]) {
//                [self getM4aTobQuestionsArray];
//            }
//            if ([optionsArray containsObject:@"糖尿病健康知识宝典-患教书籍(茶杯)"]&&[optionsArray containsObject:@"糖尿病健康知识宝典-患教书籍(无茶杯)"]&&[optionsArray containsObject:@"糖尿病心天地APP教育单页–患教书籍"]) {
//                [self getM4cToeQuestionsArray];
//            }
//        }
        
//        if (i == 0) {
//            if ([[result objectAtIndex:0] isEqualToString:@"以上皆无"]) {
//                [self getFirstArray];
//            }
//        }
//        
//        if (i == 1) {
//            if ([[result objectAtIndex:0] isEqualToString:@"以上皆无"]) {
//                [self getSecordArray];
//            }
//        }
        if ([[result objectAtIndex:0] isEqualToString:@"以上皆无"]) {
            switch (i) {
                case 0:
                    [self getFirstArray];
                    break;
                case 1:
                    [self getSecordArray];
                    break;
                case 2:
                    [self getM4aTobQuestionsArray];
                    break;
                case 3:
                    [self getM5TableQuestionsArray];
                    break;
                case 4:
                    [self getM6TableQuestionsArray];
                    break;
                default:
                    break;
            }
        }
        
    }

    [self addSelectedArrayWith:questionsData];

}

#pragma mark- 问卷部分
/**
 *  这个逻辑应该是不会变得
 */
-(void)getFirstArray{
    [questionsData addObject:[NSString stringWithFormat:@"M1a. 请问，贵店是否有【希爱力】的【患者教育手册】宣传品呢？"]];
    [questionsData addObject:[NSString stringWithFormat:@"M1b. 请问，贵店是否有【希爱力】的【ED自测卡】宣传品呢？"]];
    [questionsData addObject:[NSString stringWithFormat:@"M1c. 请问，贵店是否有【希爱力】的【药师用药指导卡(彩色/黑白)】宣传品呢？"]];
    [questionsData addObject:[NSString stringWithFormat:@"M1d. 请问，贵店是否有【希爱力】的【OAD陈列架】宣传品呢？"]];
}

-(void)getSecordArray{
    [questionsData addObject:[NSString stringWithFormat:@"M2a. 请问，贵店是否有【希爱力】的【爱之力书籍】宣传品呢？"]];
    [questionsData addObject:[NSString stringWithFormat:@"M2b. 请问，贵店是否有【希爱力】的【性福加油站陈列架】宣传品呢？"]];
    [questionsData addObject:[NSString stringWithFormat:@"M2c. 请问，贵店是否有【希爱力】的【性福加油站挂架】宣传品呢？"]];
}


-(void)getM5TableQuestionsArray{
    
    [questionsData addObject:[NSString stringWithFormat:@"M5a. 请问，贵店是否有【糖尿病健康服务站】的【糖尿病健康知识宝典-患教书籍(茶杯)】宣传品呢？"]];
    [questionsData addObject:[NSString stringWithFormat:@"M5b. 请问，贵店是否有【糖尿病健康服务站】的【糖尿病健康知识宝典-患教书籍(无茶杯)】宣传品呢？"]];
    [questionsData addObject:[NSString stringWithFormat:@"M5c. 请问，贵店是否有【糖尿病健康服务站】的【糖尿病心天地APP教育单页–患教书籍】宣传品呢？[单选]"]];
    [questionsData addObject:[NSString stringWithFormat:@"M5d. 请问，贵店是否有【糖尿病健康服务站】的【教你避开胰岛素使用的7大误区-患教书籍】宣传品呢？"]];
}

-(void)getM4aTobQuestionsArray{
    
    [questionsData addObject:[NSString stringWithFormat:@"M4a. 请问，贵店是否有【糖尿病健康服务站】的【糖尿病健康知识宝典-陈列架】宣传品呢？"]];
    [questionsData addObject:[NSString stringWithFormat:@"M4b. 请问，贵店是否有【糖尿病健康服务站】的【糖尿病心天地APP教育单页 –陈列架】宣传品呢？"]];
    [questionsData addObject:[NSString stringWithFormat:@"M4c. 请问，贵店是否有【糖尿病健康服务站】的【教你避开胰岛素使用的7大误区 - 陈列架】宣传品呢？"]];
}




-(void)getM6TableQuestionsArray{
    
    [questionsData addObject:[NSString stringWithFormat:@"M6a. 请问，贵店是否有【糖尿病健康服务站】的【主画面灯箱】宣传品呢？"]];
    [questionsData addObject:[NSString stringWithFormat:@"M6b. 请问，贵店是否有【糖尿病健康服务站】的【主画面KT版】宣传品呢？"]];
    [questionsData addObject:[NSString stringWithFormat:@"M6c. 请问，贵店是否有【糖尿病健康服务站】的【主画面指引吊牌】宣传品呢？"]];
}

#pragma mark -问卷显示逻辑
-(void) addSelectedArrayWith:(NSMutableArray*)array{

    for (NSString* name in array) {
        NSLog(@"name====%@",name);
        NSString* string = [name substringToIndex:3];
        if ([string hasPrefix:@"M2"]) {
            [m5Selected addObject:string];
        }else{
            [m7Selected addObject:string];
        }
    }
    [selectedArray addObjectsFromArray:m5Selected];
    [selectedArray addObjectsFromArray:m7Selected];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return questionsData.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductCell"];
    cell.delegate = self;
    cell.productLabel.text = [questionsData objectAtIndex:indexPath.row];
    cell.productName = [questionsData objectAtIndex:indexPath.row];
    cell.indexOfCell = indexPath;
    NSString* prefixString = [cell.productName substringToIndex:3];
    NSLog(@"prefixString==%@",prefixString);
    NSString* m5 = [NSString stringWithFormat:@"%@",[mData valueForKey:prefixString]];
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
}

#pragma mark -代理方法 ，选中是和否时的判断
-(void)ShopTaskTableViewCellHaveEvent:(NSString *)tProductName andIndex:(NSIndexPath*)index{

    tProductName = [tProductName substringToIndex:3];

    if ([tProductName isEqualToString:@"M2a"]) {
        if (m7Array.count<=3 && ![[mData valueForKey:@"M2a"] isEqualToNumber:@1]) {
            [mData setValue:[NSNumber numberWithInteger:1] forKey:tProductName];
            [m7Array removeAllObjects];
            [m7Array addObject:[NSString stringWithFormat:@"M3a. 请问，贵店的【爱之力书籍】宣传品是否陈列在【OAD展架旁】呢？"]];
            [m7Array addObject:[NSString stringWithFormat:@"M3b. 请问，贵店的【爱之力书籍】宣传品是否陈列在【收银台】呢？"]];
            [m7Array addObject:[NSString stringWithFormat:@"M3c. 请问，贵店的【爱之力书籍】宣传品是否陈列在【药师咨询台】呢？"]];
//            [questionsData addObjectsFromArray:m7Array];

            //把增加的问题插入到5e下面，傻逼客户
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index.row+1, 3)];
            [questionsData insertObjects:m7Array atIndexes:indexSet];

            [self.tableView reloadData];
        }
    }else{
        [mData setValue:[NSNumber numberWithInteger:1] forKey:tProductName];
    }

}

-(void)ShopTaskTableViewCellNoHaveEvent:(NSString *)productName
{
    productName = [productName substringToIndex:3];
    NSLog(@"bbbbb===%@",productName);
    [mData setValue:[NSNumber numberWithInteger:2] forKey:productName];
    
    if ([[mData valueForKey:@"M2a"] isEqualToNumber:@2]&& [productName isEqualToString:@"M2a"]) {
        [questionsData removeObjectsInArray:m7Array];
        [mData setValue:[NSNumber numberWithInteger:0] forKey:@"M3a"];
        [mData setValue:[NSNumber numberWithInteger:0] forKey:@"M3b"];
        [mData setValue:[NSNumber numberWithInteger:0] forKey:@"M3c"];
        [self.tableView reloadData];
    }
}
#pragma mark -完成事件

- (IBAction)completeEvent:(UIBarButtonItem *)sender {
    
    for (NSString* questionString in questionsData) {
        NSLog(@"questionString-%@",questionString);
        NSString* prefixString = [questionString substringToIndex:3];
        NSString* tip = [NSString stringWithFormat:@"%@",[mData valueForKey:prefixString]];
        if ([tip isEqualToString:@"0"]) {
            [ZAActivityBar showErrorWithStatus:@"请确认所有问题都已完成"];
            return;
        }
    }
    [mData setValue:[NSNumber numberWithBool:YES] forKey:@"M3"];
    [ZAActivityBar dismiss];
    [_recorder stop];
    [mData setValue:[[NSDate date] description] forKey:@"endTime"];
    NSMutableDictionary *dic = PLISTDATA(storeData.plistPath);
    [dic setValue:mData forKey:@"mData"];
    [dic writeToFile:storeData.plistPath atomically:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - <AVAudioRecorderDelegate>
-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    
}
@end
