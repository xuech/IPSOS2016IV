//
//  MViewController.m
//  IPSOS
//
//  Created by 沈鹏 on 14-8-12.
//  Copyright (c) 2014年 沈鹏. All rights reserved.
//

#import "MViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "TextViewViewController.h"

@interface MViewController ()<ViewPagerDataSource, ViewPagerDelegate,AVAudioPlayerDelegate,TextViewDelegate>
{
    NSMutableArray *titles;
    StoreData *storeData;
    NSMutableArray *decs;
    NSMutableArray *views;
}
@property (retain,nonatomic) AVAudioPlayer *player;
@property (weak, nonatomic) IBOutlet UISlider *progress;

@property (weak, nonatomic) IBOutlet UIButton *button;
@end

@implementation MViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"记录";
    storeData = [[DataManager shareDataManager]storeData];
    self.dataSource = self;
    self.delegate = self;
    
    titles = [NSMutableArray new];
    views = [NSMutableArray new];
    decs = [NSMutableArray new];
    NSDictionary *mData = [[NSDictionary dictionaryWithContentsOfFile:storeData.plistPath] valueForKey:@"mData"];

    if ([[mData valueForKey:@"M3"] boolValue]) {
        [titles addObject:@"希爱力PRN"];
        [decs addObject:[mData valueForKey:@"PRNDesc"]];
        [views addObject:[self.storyboard instantiateViewControllerWithIdentifier:@"textView1"]];
    }
    if([[mData valueForKey:@"M4"] boolValue]){
        [titles addObject:@"希爱力OaD"];
        [decs addObject:[mData valueForKey:@"OaDDesc"]];
        [views addObject:[self.storyboard instantiateViewControllerWithIdentifier:@"textView2"]];
    }
    
    if([[mData valueForKey:@"M5"] boolValue]){
        [titles addObject:@"希刻劳 Liquid"];
        [decs addObject:[mData valueForKey:@"LiquidDesc"]];
        [views addObject:[self.storyboard instantiateViewControllerWithIdentifier:@"textView3"]];
    }
    if([[mData valueForKey:@"M6"] boolValue]){
        [titles addObject:@"优泌林/优泌乐"];
        [decs addObject:[mData valueForKey:@"YoumiDesc"]];
        [views addObject:[self.storyboard instantiateViewControllerWithIdentifier:@"textView4"]];
    }

    if([[mData valueForKey:@"M7"] boolValue]){
        [titles addObject:@"百优解"];
        [decs addObject:[mData valueForKey:@"BaiyouDesc"]];
        [views addObject:[self.storyboard instantiateViewControllerWithIdentifier:@"textView5"]];
    }

    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(completeEvent)];
    
    self.navigationItem.rightBarButtonItem = button;
    
    NSString *recordPath = [NSString stringWithFormat:@"%@/audio.caf",storeData.storeIdPath];
    NSError *error;
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:[recordPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] error:&error];
    [_player setVolume:1];
    _player.delegate = self;
}

-(void)completeEvent
{
    NSMutableDictionary *plistData = PLISTDATA(storeData.plistPath);
    NSMutableDictionary *mData = [plistData valueForKeyPath:@"mData"];
    NSString *dec1,*dec2,*dec3,*dec4,*dec5;
    switch (titles.count) {
        case 1:
            dec1 = ((TextViewViewController*)[views objectAtIndex:0]).getText;
            if (dec1.length<1) {
                [ZAActivityBar showErrorWithStatus:@"原话记录不能为空"];
                return;
            }
            [mData setValue:dec1 forKey:@"LiquidDesc"];
            break;
        case 2:
            dec1 = ((TextViewViewController*)[views objectAtIndex:0]).getText;
            dec2 = ((TextViewViewController*)[views objectAtIndex:1]).getText;
            [mData setValue:dec1 forKey:@"PRNDesc"];
            [mData setValue:dec2 forKey:@"OaDDesc"];
            if (dec1.length<1||dec2.length<1) {
                [ZAActivityBar showErrorWithStatus:@"原话记录不能为空"];
                return;
            }
            break;
        case 3:
            dec1 = ((TextViewViewController*)[views objectAtIndex:0]).getText;
            dec2 = ((TextViewViewController*)[views objectAtIndex:1]).getText;
            dec3 = ((TextViewViewController*)[views objectAtIndex:2]).getText;
            [mData setValue:dec1 forKey:@"PRNDesc"];
            [mData setValue:dec2 forKey:@"OaDDesc"];
            [mData setValue:dec3 forKey:@"LiquidDesc"];
            
            if (dec1.length<1||dec2.length<1||dec3.length<1) {
                [ZAActivityBar showErrorWithStatus:@"原话记录不能为空"];
                return;
            }
            break;
        case 4:
            dec1 = ((TextViewViewController*)[views objectAtIndex:0]).getText;
            dec2 = ((TextViewViewController*)[views objectAtIndex:1]).getText;
            dec3 = ((TextViewViewController*)[views objectAtIndex:2]).getText;
            dec4 = ((TextViewViewController*)[views objectAtIndex:3]).getText;
            [mData setValue:dec1 forKey:@"PRNDesc"];
            [mData setValue:dec2 forKey:@"OaDDesc"];
            [mData setValue:dec3 forKey:@"LiquidDesc"];
            [mData setValue:dec4 forKey:@"YoumiDesc"];
            if (dec1.length<1||dec2.length<1||dec3.length<1||dec4.length<1) {
                [ZAActivityBar showErrorWithStatus:@"原话记录不能为空"];
                return;
            }
            break;
        case 5:
            dec1 = ((TextViewViewController*)[views objectAtIndex:0]).getText;
            dec2 = ((TextViewViewController*)[views objectAtIndex:1]).getText;
            dec3 = ((TextViewViewController*)[views objectAtIndex:2]).getText;
            dec4 = ((TextViewViewController*)[views objectAtIndex:3]).getText;
            dec5 = ((TextViewViewController*)[views objectAtIndex:4]).getText;
            [mData setValue:dec1 forKey:@"PRNDesc"];
            [mData setValue:dec2 forKey:@"OaDDesc"];
            [mData setValue:dec3 forKey:@"LiquidDesc"];
            [mData setValue:dec4 forKey:@"YoumiDesc"];
            [mData setValue:dec5 forKey:@"BaiyouDesc"];
            if (dec1.length<1||dec2.length<1||dec3.length<1||dec4.length<1||dec5.length<1) {
                [ZAActivityBar showErrorWithStatus:@"原话记录不能为空"];
                return;
            }
            break;
        default:
            break;
    }
    
    [plistData setValue:[NSNumber numberWithBool:true] forKeyPath:@"isMData"];
    [plistData writeToFile:storeData.plistPath atomically:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    NSMutableDictionary *plistData = PLISTDATA(storeData.plistPath);
    NSMutableDictionary *mData = [plistData valueForKeyPath:@"mData"];
    NSString *dec1,*dec2,*dec3,*dec4,*dec5;
    switch (titles.count) {
        case 1:
            dec1 = ((TextViewViewController*)[views objectAtIndex:0]).getText;
            if (dec1.length>0) {
               [mData setValue:dec1 forKey:@"LiquidDesc"];
            }
            break;
        case 2:
            dec1 = ((TextViewViewController*)[views objectAtIndex:0]).getText;
            dec2 = ((TextViewViewController*)[views objectAtIndex:1]).getText;
            if (dec1.length>0) {
                [mData setValue:dec1 forKey:@"PRNDesc"];
            }
            if (dec2.length>0) {
                [mData setValue:dec2 forKey:@"OaDDesc"];
            }
            
            break;
        case 3:
            dec1 = ((TextViewViewController*)[views objectAtIndex:0]).getText;
            dec2 = ((TextViewViewController*)[views objectAtIndex:1]).getText;
            dec3 = ((TextViewViewController*)[views objectAtIndex:2]).getText;
            if (dec1.length>0) {
                [mData setValue:dec1 forKey:@"PRNDesc"];
            }
            if (dec2.length>0) {
                [mData setValue:dec2 forKey:@"OaDDesc"];
            }
            if (dec3.length>0) {
                [mData setValue:dec3 forKey:@"LiquidDesc"];
            }
            break;
            
        case 4:
            dec1 = ((TextViewViewController*)[views objectAtIndex:0]).getText;
            dec2 = ((TextViewViewController*)[views objectAtIndex:1]).getText;
            dec3 = ((TextViewViewController*)[views objectAtIndex:2]).getText;
            dec4 = ((TextViewViewController*)[views objectAtIndex:3]).getText;
            if (dec1.length>0) {
                [mData setValue:dec1 forKey:@"PRNDesc"];
            }
            if (dec2.length>0) {
                [mData setValue:dec2 forKey:@"OaDDesc"];
            }
            if (dec3.length>0) {
                [mData setValue:dec3 forKey:@"LiquidDesc"];
            }
            if (dec4.length>0) {
                [mData setValue:dec4 forKey:@"YoumiDesc"];
            }
            break;
        case 5:
            dec1 = ((TextViewViewController*)[views objectAtIndex:0]).getText;
            dec2 = ((TextViewViewController*)[views objectAtIndex:1]).getText;
            dec3 = ((TextViewViewController*)[views objectAtIndex:2]).getText;
            dec4 = ((TextViewViewController*)[views objectAtIndex:3]).getText;
            dec5 = ((TextViewViewController*)[views objectAtIndex:4]).getText;
            if (dec1.length>0) {
                [mData setValue:dec1 forKey:@"PRNDesc"];
            }
            if (dec2.length>0) {
                [mData setValue:dec2 forKey:@"OaDDesc"];
            }
            if (dec3.length>0) {
                [mData setValue:dec3 forKey:@"LiquidDesc"];
            }
            if (dec4.length>0) {
                [mData setValue:dec4 forKey:@"YoumiDesc"];
            }
            if (dec5.length>0) {
                [mData setValue:dec5 forKey:@"BaimiDesc"];
            }
            break;
        default:
            break;
    }

    [plistData writeToFile:storeData.plistPath atomically:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playEvent:(id)sender {
    
    if ([_player isPlaying]) {
        [_player stop];
        [sender setTitle:@"播放" forState:UIControlStateNormal];
        [_button setImage:IMAGENAMED(@"btn-play") forState:UIControlStateNormal];
        return;
    }
    [_button setImage:IMAGENAMED(@"btn-suspend") forState:UIControlStateNormal];
    _progress.value = 0;
    
    [_player prepareToPlay];
    [_player play];
    NSLog(@"time:%f",[_player duration]);
    [sender setTitle:@"停止" forState:UIControlStateNormal];
    dispatch_queue_t queue = dispatch_queue_create("queue", nil);
    dispatch_async(queue, ^{
        do{
            float x =_player.currentTime/_player.duration;
            dispatch_async(dispatch_get_main_queue(), ^{
                _progress.value = x;
            });
            
        }while ([_player isPlaying]) ;
    });
}

#pragma mark - TextViewDelegate
-(void)textContectChange:(NSString *)text withNum:(NSInteger)num
{
    [decs replaceObjectAtIndex:num withObject:text];
}


#pragma mark - AVAudioPlayerDelegate
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [_button setTitle:@"播放" forState:UIControlStateNormal];
    [_button setImage:IMAGENAMED(@"btn-play") forState:UIControlStateNormal];
}


#pragma mark - ViewPagerDataSource
- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager {
    return [titles count];
}
- (UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index {
    
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:12.0];
    label.text = [titles objectAtIndex:index];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    [label sizeToFit];

    return label;
}

- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index {
    
    TextViewViewController *v = [views objectAtIndex:index];
    NSString *dec = [decs objectAtIndex:index];
    if (dec.length>0) {
        v.contect = [decs objectAtIndex:index];
    }
    v.num = index;
    v.delegate = self;
    return v;
}

#pragma mark - ViewPagerDelegate
- (CGFloat)viewPager:(ViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value {

    switch (option) {
        case ViewPagerOptionStartFromSecondTab:
            return 0.0;
        case ViewPagerOptionCenterCurrentTab:
            return 1.0;
        case ViewPagerOptionTabLocation:
            return 1.0;
        case ViewPagerOptionTabHeight:
            return 49.0;
        case ViewPagerOptionTabOffset:
            return 36.0;
        case ViewPagerOptionTabWidth:
            return UIInterfaceOrientationIsLandscape(self.interfaceOrientation) ? 128.0 : 96.0;
        case ViewPagerOptionFixFormerTabsPositions:
            return 1.0;
        case ViewPagerOptionFixLatterTabsPositions:
            return 1.0;
        default:
            return value;
    }
}
- (UIColor *)viewPager:(ViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color {
    return color;
//    switch (component) {
//        case ViewPagerIndicator:
//            return [[UIColor redColor] colorWithAlphaComponent:0.64];
//        case ViewPagerTabsView:
//            return [[UIColor lightGrayColor] colorWithAlphaComponent:0.32];
//        case ViewPagerContent:
//            return [[UIColor darkGrayColor] colorWithAlphaComponent:0.32];
//        default:
//            return color;
//    }
}



@end
