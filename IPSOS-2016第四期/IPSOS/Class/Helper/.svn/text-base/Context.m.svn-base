//
//  Context.m
//  iconnect
//
//  Created by obizsoft on 14-4-11.
//  Copyright (c) 2014年 com.obizsoft. All rights reserved.
//

#import "Context.h"

@implementation Context


+(NSDictionary *)getSystemInfo
{
    NSString *username = [USER_DEFAULT valueForKey:@"username"];
    NSDictionary *dicInfo = [[NSBundle mainBundle] infoDictionary];
    NSDictionary *dic = @{@"登陆用户名": username,
                          @"当前系统":[[UIDevice currentDevice]systemName],
                          @"系统版本": [[UIDevice currentDevice]systemVersion],
                          @"设备名称":[[UIDevice currentDevice] name],
                          @"设备类型":[[UIDevice currentDevice] model],
                          @"应用版本":[dicInfo objectForKey:@"CFBundleShortVersionString"]
                          };
    return dic;
}

@end
