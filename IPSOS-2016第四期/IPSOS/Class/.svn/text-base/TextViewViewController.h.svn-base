//
//  TextFieldViewController.h
//  IPSOS
//
//  Created by 沈鹏 on 14-8-13.
//  Copyright (c) 2014年 沈鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TextViewDelegate <NSObject>

-(void)textContectChange:(NSString *)text withNum:(NSInteger)num;

@end

@interface TextViewViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic) NSInteger num;
@property (strong,nonatomic) id<TextViewDelegate> delegate;
@property (strong,nonatomic) NSString *contect;

-(NSString*)getText;

@end

