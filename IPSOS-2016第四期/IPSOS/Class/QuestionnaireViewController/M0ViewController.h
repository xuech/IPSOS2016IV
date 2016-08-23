//
//  M0ViewController.h
//  IPSOS
//
//  Created by 沈鹏 on 14-8-21.
//  Copyright (c) 2014年 沈鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol M0Delegate <NSObject>

-(void)m0Event:(BOOL)sign;

@end

@interface M0ViewController : UIViewController

@property (strong,nonatomic) id<M0Delegate> delegate;

@end
