//
//  M3ViewController.h
//  IPSOS
//
//  Created by 沈鹏 on 14-8-11.
//  Copyright (c) 2014年 沈鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol M3Delegate <NSObject>
//num用来存放对应的int
-(void)m3Event:(BOOL)sign withNum:(NSInteger)num withProductName:(NSString*)productName;

@end

@interface M3ViewController : UITableViewController

@property (strong,nonatomic) NSMutableArray *dataSource;

@property (strong,nonatomic) id<M3Delegate> delegate;

@end
