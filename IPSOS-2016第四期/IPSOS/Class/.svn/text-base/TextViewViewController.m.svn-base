//
//  TextFieldViewController.m
//  IPSOS
//
//  Created by 沈鹏 on 14-8-13.
//  Copyright (c) 2014年 沈鹏. All rights reserved.
//

#import "TextViewViewController.h"

@interface TextViewViewController ()<UITextViewDelegate>

@end

@implementation TextViewViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    _textView.delegate = self;
    
    if (_contect.length>0) {
        _textView.text = _contect;
        [_textView setTextColor:[UIColor blackColor]];
    }else{
        [_textView setTextColor:[UIColor lightGrayColor]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([_textView textColor] == [UIColor lightGrayColor]) {
        _textView.text = @"";
    }
    [_textView setTextColor:[UIColor blackColor]];
}

- (void)textViewDidChange:(UITextView *)textView
{
    [_delegate textContectChange:textView.text withNum:_num];
}

-(NSString*)getText
{
    if ([_textView textColor] == [UIColor lightGrayColor]) {
        return @"";
    }
    return _textView.text;
}

@end
