//
//  M2ViewController.h
//  IPSOS
//
//  Created by 沈鹏 on 14-8-11.
//  Copyright (c) 2014年 沈鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol M2Delegate <NSObject>

-(void)m2Event:(BOOL)sign withSec:(NSArray*)sec;
-(void)m2Enable:(BOOL)enable;

@end

@interface M2ViewController : UIViewController

@property (strong,nonatomic) id<M2Delegate> delegate;

@end
