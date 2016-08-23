//
//  M1ViewController.h
//  IPSOS
//
//  Created by 沈鹏 on 14-8-11.
//  Copyright (c) 2014年 沈鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol M1Delegate <NSObject>

-(void)m1Event:(BOOL)sign;

@end

@interface M1ViewController : UIViewController

@property (strong,nonatomic) id<M1Delegate> delegate;

@end

