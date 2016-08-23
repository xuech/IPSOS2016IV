//
//  QuestionnaireViewController.m
//  IPSOS
//
//  Created by 沈鹏 on 14-8-10.
//  Copyright (c) 2014年 沈鹏. All rights reserved.
//

#import "QuestionnaireViewController.h"
#import "M0ViewController.h"
#import "M1ViewController.h"
#import "M2ViewController.h"
#import "M3ViewController.h"
#import "M4ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface QuestionnaireViewController ()<UIScrollViewDelegate,M0Delegate,M1Delegate,M2Delegate,M3Delegate,M4Delegate,AVAudioRecorderDelegate>
{
    BOOL m3;
    BOOL m4;
    BOOL m1;
    StoreData *storeData;
    NSMutableDictionary *mData;
    NSMutableArray *m3Questions;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain,nonatomic) AVAudioRecorder *recorder;
@end

@implementation QuestionnaireViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    m3Questions = [NSMutableArray new];

    BOOL xiaiFirst = NO;
    BOOL xiaiSec = NO;
    BOOL xiaiThird = NO;
    
    BOOL xike = NO;
    BOOL xiai2 = NO;
    BOOL yml = NO;
    BOOL yml2 = NO;
    BOOL yml3 = NO;
    BOOL byj = NO;

    storeData = [[DataManager shareDataManager] storeData];
    mData = [[NSMutableDictionary dictionaryWithContentsOfFile:storeData.plistPath] valueForKey:@"mData"];
    NSMutableDictionary *plistData = PLISTDATA(storeData.plistPath);

    //冷链设备
    [m3Questions addObject:@"X2: 该家门店店内是否有冷链设备【冷链设备指：包括冰箱、冷柜、阴凉柜在内的设备或者类似设备】？"];
    
    //问答
    for (NSDictionary *dic in [plistData valueForKey:@"taskData"]) {
        //只拿到未选中的数据
        if (![[dic valueForKey:@"isHave"] boolValue]) {
            NSString *name = [dic valueForKey:@"productName"];
            if ([name isEqualToString:@"希爱力1片装(20mg)"]) {
                xiaiFirst = true;
            }else if ([name isEqualToString:@"希爱力4片装(20mg)"]){
                xiaiSec = true;
            }else if ([name isEqualToString:@"希爱力8片装(20mg)"]){
                xiaiThird = true;
            }else if ([[dic valueForKey:@"productName"] isEqualToString:@"希爱力28片装(5mg)"]){
                xiai2 = true;
            }
            
            if ([name isEqualToString:@"希刻劳(6袋装)"]) {
                xike = true;
            }
            
            if ([name isEqualToString:@"优泌林&优泌林70/30&优泌林中效"]) {
                yml = true;
            }else if ([name isEqualToString:@"优泌乐&优泌乐25&优泌乐50"]){
                yml2 = true;
            }else if ([name isEqualToString:@"优伴II&优伴经典"]){
                yml3 = true;
            }
            if ([name isEqualToString:@"百优解"]) {
                byj = true;
            }
            
        }
    }
    if (xiaiFirst && xiaiSec && xiaiThird) {
        [m3Questions addObject:@"M5a: 请问，贵店是否有【希爱力1片&4片&8片装】产品售卖呢？"];
    }
    if (xiai2) {
        [m3Questions addObject:@"M5b: 请问，贵店是否有【希爱力28片装】产品售卖呢？"];
            }
    
    if (xike) {
        [m3Questions addObject:@"M5c: 请问，贵店是否有【希刻劳（6袋装】产品售卖呢？"];
       
    }
    if (yml) {
        [m3Questions addObject:@"M5d: 请问，贵店是否有【优泌林&优泌林70/30&优泌林中效】产品售卖呢？"];
    }
    if (yml2) {
        [m3Questions addObject:@"M5e: 请问，贵店是否有【优泌乐&优泌乐25&优泌乐50】产品售卖呢？"];
    }
    if (yml3) {
        [m3Questions addObject:@"M5f: 请问，贵店是否有【优伴II&优伴经典】产品售卖呢？"];
    }
    if (byj) {
        [m3Questions addObject:@"M5g: 请问，贵店是否有【百优解】产品售卖呢？"];

    }
    //柜台
    BOOL guitai1 = NO;
    BOOL guitai2 = NO;
    
    NSDictionary* xil = [[plistData valueForKey:@"taskData2"] firstObject];
    NSDictionary* xilQuestions = [[xil valueForKey:@"questions"] firstObject];
    NSMutableArray* xilResult = [xilQuestions valueForKey:@"result"];
    NSMutableArray* xilOptions = [xilQuestions valueForKey:@"options"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"NOT (SELF in %@)", xilResult];
    [xilOptions filterUsingPredicate:predicate];
    for (NSString* string in xilOptions) {
        if ([string isEqualToString:@"柜台陈列架"]) {

            guitai1 = YES;
            
        }else if ([string isEqualToString:@"疾病教育书籍"]){

            guitai2 = YES;
        }
        
    }
    if (guitai1){
        [m3Questions addObject:@"M6a. 请问，贵店是否有【希爱力1片&4片&8片&28片装】产品的【柜台陈列架】宣传品呢？"];
    }
    if (guitai2) {
        [m3Questions addObject:@"M6b. 请问，贵店是否有【希爱力1片&4片&8片&28片装】产品的【疾病教育书籍】宣传品呢？"];
    }
 

    
    //糖尿病
    NSDictionary* productDic = [[plistData valueForKey:@"taskData2"] lastObject];
    NSDictionary* questions = [[productDic valueForKey:@"questions"] firstObject];
    //选中的某个记录
    NSMutableArray* result = [questions valueForKey:@"result"];
    NSMutableArray* options = [questions valueForKey:@"options"];
        NSLog(@"result====%@",result);
        NSLog(@"过滤前====%@",options);
    [result addObjectsFromArray:@[@"其他",@"以上皆无"]];
    NSPredicate *thePredicate = [NSPredicate predicateWithFormat:@"NOT (SELF in %@)", result];
    
    [options filterUsingPredicate:thePredicate];
    
    NSString* m7 = nil;
    for (int i = 0; i<options.count; i++) {
        if ([options[i] hasSuffix:@"主画面灯箱"]) {
            m7 = [NSString stringWithFormat:@"M7a. 请问，贵店是否有【糖尿病健康服务站】的【%@】宣传品呢？",options[i]];
        }else if ([options[i] hasSuffix:@"主画面KT版"]){
            m7 = [NSString stringWithFormat:@"M7b. 请问，贵店是否有【糖尿病健康服务站】的【%@】宣传品呢？",options[i]];
        }else if ([options[i] hasSuffix:@"主画面指引吊牌"]){
            m7 = [NSString stringWithFormat:@"M7c. 请问，贵店是否有【糖尿病健康服务站】的【%@】宣传品呢？",options[i]];
        }else if ([options[i] hasSuffix:@"知识宝典【柜台陈列架】"]){
            m7 = [NSString stringWithFormat:@"M7d. 请问，贵店是否有【糖尿病健康服务站】的【%@】宣传品呢？",options[i]];
        }else if ([options[i] hasSuffix:@"知识宝典【患教书籍】"]){
            m7 = [NSString stringWithFormat:@"M7e. 请问，贵店是否有【糖尿病健康服务站】的【%@】宣传品呢？",options[i]];
        }else if ([options[i] hasSuffix:@"APP教育单页【柜台陈列架】"]){
            m7 = [NSString stringWithFormat:@"M7f. 请问，贵店是否有【糖尿病健康服务站】的【%@】宣传品呢？",options[i]];
        }else if ([options[i] hasSuffix:@"APP教育单页【患教书籍】"]){
            m7 = [NSString stringWithFormat:@"M7g. 请问，贵店是否有【糖尿病健康服务站】的【%@】宣传品呢？",options[i]];
        }else if ([options[i] hasSuffix:@"海报"]){
            m7 = [NSString stringWithFormat:@"M7h. 请问，贵店是否有【糖尿病健康服务站】的【%@】宣传品呢？",options[i]];
        }else if ([options[i] hasSuffix:@"吊旗"]){
            m7 = [NSString stringWithFormat:@"M7i. 请问，贵店是否有【糖尿病健康服务站】的【%@】宣传品呢？",options[i]];
          }
        [m3Questions addObject:m7];
    }
    
    
    
    NSLog(@"过滤后====%@",options);
    NSLog(@"m3Questions  %@",m3Questions);
    
    
    
    
    self.title =@"问卷调查";
    storeData = [[DataManager shareDataManager] storeData];
    CGRect frame;
    M3ViewController *view3 = [self.storyboard instantiateViewControllerWithIdentifier:@"M3"];
    frame = view3.view.frame;
    frame.origin.x = 0;
    [view3.view setFrame:frame];
    view3.delegate = self;
    view3.dataSource = m3Questions;


    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, _scrollView.contentSize.height);
    [_scrollView addSubview:view3.view];
    [self addChildViewController:view3];
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(nextEvent)];
    self.navigationItem.rightBarButtonItem = button;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    [self audioInit];
    [_recorder record];
    [mData setValue:[[NSDate date] description] forKey:@"startTime"];

    
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
	NSString *recordPath = [NSString stringWithFormat:@"%@/audio.caf", storeData.storeIdPath];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)nextEvent
{
    if ([self.navigationItem.rightBarButtonItem.title isEqualToString:@"完成"]) {
        
//        if (self.scrollView.contentOffset.x <= SCREEN_WIDTH) {
//            [mData setValue:[NSNumber numberWithBool:NO] forKey:@"M3"];
////            [mData setValue:[NSNumber numberWithBool:NO] forKey:@"M4"];
////            [mData setValue:[NSNumber numberWithBool:NO] forKey:@"M5"];
//        }else{
//            [mData setValue:[NSNumber numberWithBool:YES] forKey:@"M3"];
////            [mData setValue:[NSNumber numberWithBool:YES] forKey:@"M4"];
////            [mData setValue:[NSNumber numberWithBool:YES] forKey:@"M5"];
//        }
        [mData setValue:[NSNumber numberWithBool:YES] forKey:@"M3"];
        [ZAActivityBar dismiss];
//        [_recorder stop];
        [mData setValue:[[NSDate date] description] forKey:@"endTime"];
        NSMutableDictionary *dic = PLISTDATA(storeData.plistPath);
        [dic setValue:mData forKey:@"mData"];
        [dic writeToFile:storeData.plistPath atomically:YES];
        NSLog(@"submit === %@",dic);
        
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }/*
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
    if (m1) {
        [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH*2+_scrollView.contentOffset.x, 0) animated:YES];
        m1 = false;
        self.navigationItem.rightBarButtonItem.title = @"完成";
        [self.navigationItem.rightBarButtonItem setEnabled:YES];
    }else{
        [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH+_scrollView.contentOffset.x, 0) animated:YES];
    }

    if (_scrollView.contentOffset.x == SCREEN_WIDTH*3) {
        self.navigationItem.rightBarButtonItem.title = @"完成";
        [self.navigationItem.rightBarButtonItem setEnabled:YES];
    }*/
    
}

-(void)m0Event:(BOOL)sign
{
    [self.navigationItem.rightBarButtonItem setEnabled:YES];
    if (sign) {
        self.navigationItem.rightBarButtonItem.title = @"下一题";
        
    }else{
        self.navigationItem.rightBarButtonItem.title = @"下一题";
    }
    [mData setValue:[NSNumber numberWithBool:sign] forKey:@"M0"];
}

-(void)m1Event:(BOOL)sign
{
    [self.navigationItem.rightBarButtonItem setEnabled:YES];
    if (sign) {
        self.navigationItem.rightBarButtonItem.title = @"下一题";
        m1 = false;
    }else{
        self.navigationItem.rightBarButtonItem.title = @"下一题";
        m1 = true;
        if (m3Questions.count == 0) {
            self.navigationItem.rightBarButtonItem.title = @"完成";
        }
    }
   
    [mData setValue:[NSNumber numberWithBool:sign] forKey:@"M1"];
}

-(void)m2Event:(BOOL)sign withSec:(NSArray *)sec
{
    [self.navigationItem.rightBarButtonItem setEnabled:YES];
    if (sign) {
        self.navigationItem.rightBarButtonItem.title = @"下一题";
    }else{
        self.navigationItem.rightBarButtonItem.title = @"下一题";
    }
    
    if (m3Questions.count == 0) {
        self.navigationItem.rightBarButtonItem.title = @"完成";
    }
    [mData setValue:sec forKey:@"M2"];
}

-(void)m2Enable:(BOOL)enable
{
    [self.navigationItem.rightBarButtonItem setEnabled:enable];
}

-(void)m3Event:(BOOL)sign withNum:(NSInteger)num withProductName:(NSString *)productName
{
    m3 = true;
    [mData setValue:[NSNumber numberWithInteger:num] forKey:productName];
    

//    [mData setValue:[NSNumber numberWithBool:sign] forKey:@"M3"];
    
    NSMutableDictionary *dic = PLISTDATA(storeData.plistPath);
    [dic setValue:mData forKey:@"mData"];
    [dic writeToFile:storeData.plistPath atomically:YES];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshData" object:nil];

//    switch (num) {
//        case 1:
//            m3 = true;
//            [mData setValue:[NSNumber numberWithBool:sign] forKey:@"M3"];
//            NSLog(@"mdata======%@",mData);
//            break;
//        case 2:
//            m4 = true;
//            [mData setValue:[NSNumber numberWithBool:sign] forKey:@"M4"];
//            break;
//        default:
//            break;
//    }
//    if (m3&&m4) {
//        [self.navigationItem.rightBarButtonItem setEnabled:YES];
//        self.navigationItem.rightBarButtonItem.title = @"完成";
//    }
}

-(void)m4Dic:(NSDictionary *)dic
{
    NSString *name = [dic valueForKey:@"Name"];
    NSString *phone = [dic valueForKey:@"Phone"];
    [mData setValue:name forKey:@"M6Contact"];
    [mData setValue:phone forKey:@"M6PhoneNumber"];
}

-(void)m4Event:(BOOL)sign
{
    [mData setObject:[NSNumber numberWithBool:sign] forKey:@"M6"];
    [self.navigationItem.rightBarButtonItem setEnabled:YES];
    if (sign) {
        self.navigationItem.rightBarButtonItem.title = @"下一步";
    }else{
//        self.navigationItem.rightBarButtonItem.title = @"完成";
        self.navigationItem.rightBarButtonItem.title = @"下一步";
    }
    
}

#pragma mark - <AVAudioRecorderDelegate>
-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    
}


-(void)oldData{
    m3Questions = [NSMutableArray new];
    BOOL xiai = true;
    BOOL xike = true;
    BOOL xiai2 = true;
    storeData = [[DataManager shareDataManager] storeData];
    mData = [[NSMutableDictionary dictionaryWithContentsOfFile:storeData.plistPath] valueForKey:@"mData"];
    NSMutableDictionary *plistData = PLISTDATA(storeData.plistPath);
    for (NSDictionary *dic in [plistData valueForKey:@"taskData"]) {
        if ([[dic valueForKey:@"isHave"] boolValue]) {
            NSString *name = [[dic valueForKey:@"productName"] substringToIndex:2];
            if (![[dic valueForKey:@"productName"]  isEqualToString:@"希爱力28片装(5mg)"]) {
                if ([name isEqualToString:@"希爱"]) {
                    xiai = true;
                }
            }
            if ([[dic valueForKey:@"productName"]  isEqualToString:@"希爱力28片装(5mg)"]) {
                xiai2 = true;
            }
            if ([name isEqualToString:@"希刻"]) {
                xike = true;
            }
            
        }
    }
    
    if (xiai) {
        [m3Questions addObject:@"M3a: 请问，您所了解的，关于希爱力20mg产品的关键信息有哪些呢？"];
        //        [mData setValue:[NSNumber numberWithBool:YES] forKey:@"M3"];
        
    }
    
    if (xiai2) {
        [m3Questions addObject:@"M3b: 请问，您所了解的，关于希爱力5mg*28片产品的关键信息有哪些呢？"];
        //        [mData setValue:[NSNumber numberWithBool:YES] forKey:@"M4"];
    }
    
    if (xike) {
        [m3Questions addObject:@"M3c: 请问，您所了解的，关于希刻劳产品的关键信息有哪些呢？"];
        //        [mData setValue:[NSNumber numberWithBool:YES] forKey:@"M5"];
    }

}
@end
