//
//  M1ViewController.m
//  IPSOS
//
//  Created by 沈鹏 on 14-8-11.
//  Copyright (c) 2014年 沈鹏. All rights reserved.
//

#import "M1ViewController.h"

@interface M1ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;

@end

@implementation M1ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)yesEvent:(id)sender {
    [_img1 setImage:IMAGENAMED(@"icon-checkboxselected")];
    [_img2 setImage:IMAGENAMED(@"icon-checkbox")];
    [self.delegate m1Event:YES];
}

- (IBAction)noEvent:(id)sender {
    [_img1 setImage:IMAGENAMED(@"icon-checkbox")];
    [_img2 setImage:IMAGENAMED(@"icon-checkboxselected")];
    [self.delegate m1Event:NO];
}

@end
