//
//  M2ViewController.h
//  IPSOS
//
//  Created by 沈鹏 on 14-8-11.
//  Copyright (c) 2014年 沈鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol M4Delegate <NSObject>

-(void)m4Event:(BOOL)sign;
-(void)m4Dic:(NSDictionary*)dic;

@end

@interface M4ViewController : UIViewController

@property (strong,nonatomic) id<M4Delegate> delegate;

@end
