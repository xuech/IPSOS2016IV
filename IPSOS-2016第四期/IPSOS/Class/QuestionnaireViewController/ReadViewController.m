//
//  ReadViewController.m
//  IPSOS
//
//  Created by xuech on 16/3/1.
//  Copyright (c) 2016年 沈鹏. All rights reserved.
//

#import "ReadViewController.h"
#import "M4ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ReadViewController ()<AVAudioRecorderDelegate>
{
    StoreData *storeData;
    NSMutableDictionary *mData;
}
@property (retain,nonatomic) AVAudioRecorder *recorder;
@end

@implementation ReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    storeData = [[DataManager shareDataManager] storeData];
    mData = [[NSMutableDictionary dictionaryWithContentsOfFile:storeData.plistPath] valueForKey:@"mData"];
    
    [self audioInit];
    [_recorder record];
    [mData setValue:[[NSDate date] description] forKey:@"QAStartTime"];
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


- (IBAction)nextStep:(UIBarButtonItem *)sender {
    NSLog(@"ok");
//    [mData setValue:[NSNumber numberWithBool:YES] forKey:@"M3"];
//    [ZAActivityBar dismiss];
//    [_recorder stop];
    [mData setValue:[[NSDate date] description] forKey:@"QAEendTime"];
    NSMutableDictionary *dic = PLISTDATA(storeData.plistPath);
    [dic setValue:mData forKey:@"mData"];
    [dic writeToFile:storeData.plistPath atomically:YES];
    
    M4ViewController* m4 = [self.storyboard instantiateViewControllerWithIdentifier:@"M4"];
    [self.navigationController pushViewController:m4 animated:YES];
}

#pragma mark - <AVAudioRecorderDelegate>
-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    
}
@end
