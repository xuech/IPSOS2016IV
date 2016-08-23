//
//  LoginViewController.m
//  IPSOS
//
//  Created by 沈鹏 on 14-7-25.
//  Copyright (c) 2014年 沈鹏. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()<DataManagerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *uidTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginEvent:(id)sender {
    [self.view endEditing:YES];
    
    NSString *username = _uidTextField.text;
    NSString *password = _passwordTextField.text;
    
    if (username.length<1 || password.length<1) {
        [ZAActivityBar showErrorWithStatus:@"用户名或密码不能为空"];
        return;
    }
    [USER_DEFAULT setValue:username forKeyPath:@"username"];
    [USER_DEFAULT setValue:password forKeyPath:@"password"];
    [ZAActivityBar showWithStatus:@"正在登录中。。。"];
    [DataManager shareDataManager].delegate = self;
    [[DataManager shareDataManager] login:username withPassword:password];
//    [self performSelector:@selector(myTask) withObject:nil afterDelay:2];
    
//    [self addNotification];
}
-(void)addNotification
{
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    
    if (localNotif == nil)
        
        return;
    
    
    //    NSDate * now = [NSDate new];
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"HH:mm";
    [formatter dateFromString:@"16:00"];
    
    localNotif.fireDate = [formatter dateFromString:@"21:00"];;
    
    
    localNotif.timeZone = [NSTimeZone defaultTimeZone];
    
    localNotif.repeatInterval = kCFCalendarUnitDay;
    // Notification details
    
    localNotif.alertBody = @"对于未提交的任务请及时提交。";
    
    // Set the action button
    
    localNotif.alertAction = @"View";
    
    
    localNotif.soundName = UILocalNotificationDefaultSoundName;
    
    //    localNotif.applicationIconBadgeNumber = 1;
    
    
    // Specify custom data for the notification
    
    NSDictionary *infoDict = [NSDictionary dictionaryWithObject:@"someValue" forKey:@"someKey"];
    
    localNotif.userInfo = infoDict;
    
    
    // Schedule the notification
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
    
    
    
    
}

-(void)loginSuccess
{
    [self addNotification];
    [ZAActivityBar dismiss];
    [self dismissViewControllerAnimated:NO completion:nil];
    [Flurry logEvent:@"登录" withParameters:[Context getSystemInfo]];
}

-(void)loginFaile:(NSError *)error
{
    [ZAActivityBar showErrorWithStatus:@"登录失败。请检查帐号或密码是否正确"];
}


//-(void)myTask
//{
//    [ZAActivityBar dismiss];
//    [self dismissViewControllerAnimated:NO completion:nil];
//}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)endKeyboard:(id)sender {
    [self.view endEditing:YES];
}



@end
