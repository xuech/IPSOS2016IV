//
//  M2ViewController.m
//  IPSOS
//
//  Created by 沈鹏 on 14-8-11.
//  Copyright (c) 2014年 沈鹏. All rights reserved.
//

#import "M2ViewController.h"

@interface M2ViewController ()
{
    BOOL a,b,c,d,e,f,g,h;
    BOOL o;
    NSMutableArray *arr;
}

@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UIImageView *img3;
@property (weak, nonatomic) IBOutlet UIImageView *img4;
@property (weak, nonatomic) IBOutlet UIImageView *img5;
@property (weak, nonatomic) IBOutlet UIImageView *img6;
@property (weak, nonatomic) IBOutlet UIImageView *img7;
@property (weak, nonatomic) IBOutlet UIImageView *img8;
@end

@implementation M2ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    arr = [NSMutableArray new];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonEvent:(id)sender {
    BOOL temp = NO;
    switch ([sender tag]) {
        case 1:
            if (a) {
                [_img1 setImage:IMAGENAMED(@"icon-checkbox")];
                a=false;
                o=false;
                [arr removeObject:[sender currentTitle]];
            }else{
                a=true;
                o=true;
                [_img1 setImage:IMAGENAMED(@"icon-checkboxselected")];
                temp = YES;
                [arr addObject:[sender currentTitle]];
            }
            break;
        case 2:
            if (b) {
                [arr removeObject:[sender currentTitle]];
                [_img2 setImage:IMAGENAMED(@"icon-checkbox")];
                b=false;
            }else{
                b=true;
                [arr addObject:[sender currentTitle]];
                [_img2 setImage:IMAGENAMED(@"icon-checkboxselected")];
            }
            break;
        case 3:
            if (c) {
                [arr removeObject:[sender currentTitle]];
                [_img3 setImage:IMAGENAMED(@"icon-checkbox")];
                c=false;
            }else{
                c=true;
                [arr addObject:[sender currentTitle]];
                [_img3 setImage:IMAGENAMED(@"icon-checkboxselected")];
            }
            break;
        case 4:
            if (d) {
                [arr removeObject:[sender currentTitle]];
                [_img4 setImage:IMAGENAMED(@"icon-checkbox")];
                d=false;
            }else{
                d=true;
                [arr addObject:[sender currentTitle]];
                [_img4 setImage:IMAGENAMED(@"icon-checkboxselected")];
            }
            break;
        case 5:
            if (e) {
                [arr removeObject:[sender currentTitle]];
                [_img5 setImage:IMAGENAMED(@"icon-checkbox")];
                e = false;
            }else{
                e=true;
                [arr addObject:[sender currentTitle]];
                [_img5 setImage:IMAGENAMED(@"icon-checkboxselected")];
            }
            break;
        case 6:
            if (f) {
                [arr removeObject:[sender currentTitle]];
                [_img6 setImage:IMAGENAMED(@"icon-checkbox")];
                f=false;
            }else{
                f = true;
                [arr addObject:[sender currentTitle]];
                [_img6 setImage:IMAGENAMED(@"icon-checkboxselected")];
            }
            break;
        case 7:
            if (g) {
                [arr removeObject:[sender currentTitle]];
                [_img7 setImage:IMAGENAMED(@"icon-checkbox")];
                g= false;
            }else{
                g=true;
                [arr addObject:[sender currentTitle]];
                [_img7 setImage:IMAGENAMED(@"icon-checkboxselected")];
            }
            break;
        case 8:
            if (h) {
                [arr removeObject:[sender currentTitle]];
                [_img8 setImage:IMAGENAMED(@"icon-checkbox")];
                h = false;
            }else{
                h = true;
                [arr addObject:[sender currentTitle]];
                [_img8 setImage:IMAGENAMED(@"icon-checkboxselected")];
            }
            break;
            
        default:
            break;
    }
    if (o) {
        [self.delegate m2Event:o withSec:arr];
    }else{
        [self.delegate m2Event:temp withSec:arr];
    }
    if (!a&&!b&&!c&&!d&&!e&&!f&&!g&&!h) {
        [self.delegate m2Enable:NO];
    }else{
        [self.delegate m2Enable:YES];
    }
}


@end
