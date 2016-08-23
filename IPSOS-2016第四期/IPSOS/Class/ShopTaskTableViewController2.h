//
//  ShopTaskTableViewController.h
//  IPSOS
//
//  Created by 沈鹏 on 14-7-30.
//  Copyright (c) 2014年 沈鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ShopTaskDelegate <NSObject>

-(void)shopTaskEvent:(BOOL)sign;
-(void)shopTaskDic:(NSDictionary*)dic;

@end
@interface ShopTaskTableViewController2 : UITableViewController
@property (weak,nonatomic) id<ShopTaskDelegate> delegate;
@end
