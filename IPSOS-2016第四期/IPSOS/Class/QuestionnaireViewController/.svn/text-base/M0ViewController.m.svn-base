//
//  M0ViewController.m
//  IPSOS
//
//  Created by 沈鹏 on 14-8-21.
//  Copyright (c) 2014年 沈鹏. All rights reserved.
//

#import "M0ViewController.h"

@interface M0ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;

@end

@implementation M0ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

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

- (IBAction)yesEvent:(id)sender {
    [_img1 setImage:IMAGENAMED(@"icon-checkboxselected")];
    [_img2 setImage:IMAGENAMED(@"icon-checkbox")];
    [self.delegate m0Event:YES];
}

- (IBAction)noEvent:(id)sender {
    [_img1 setImage:IMAGENAMED(@"icon-checkbox")];
    [_img2 setImage:IMAGENAMED(@"icon-checkboxselected")];
    [self.delegate m0Event:NO];
}


@end
