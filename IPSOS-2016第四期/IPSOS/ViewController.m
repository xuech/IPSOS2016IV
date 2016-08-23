//
//  ViewController.m
//  IPSOS
//
//  Created by 沈鹏 on 14-7-25.
//  Copyright (c) 2014年 沈鹏. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.navigationBar.backgroundColor = [UIColor redColor];
    
}

-(void)viewDidAppear:(BOOL)animated
{
//    [USER_DEFAULT setValue:@"" forKeyPath:@"uid"];
    NSString *uid  = [USER_DEFAULT valueForKey:@"uid"];
    
    if (uid.length<1) {
        [self performSegueWithIdentifier:@"loginView" sender:nil];
    }else{
        [self performSegueWithIdentifier:@"shopTable" sender:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
