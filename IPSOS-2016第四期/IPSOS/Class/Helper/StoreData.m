//
//  StoreData.m
//  IPSOS
//
//  Created by 沈鹏 on 14-8-1.
//  Copyright (c) 2014年 沈鹏. All rights reserved.
//

#import "StoreData.h"

@implementation StoreData

-(id)init:(NSDictionary *)data
{
    if (self) {
        NSDictionary *store = [data valueForKey:@"Store"];
        _scheduleCategory = ![[data valueForKey:@"ScheduleCategory"]isKindOfClass:[NSNull class]]?[data valueForKey:@"ScheduleCategory"]:@"任务";
        if ([_scheduleCategory isEqualToString:@""]) {
            _scheduleCategory = @"任务";
        }
        _scheduleId = [[data valueForKey:@"Id"] intValue];
        _storeId = [[store valueForKey:@"Id"] stringValue];
        _storeName = ![[store valueForKey:@"StoreName"]isKindOfClass:[NSNull class]]?[store valueForKey:@"StoreName"]:@"";
        _city = ![[store valueForKey:@"City"]isKindOfClass:[NSNull class]]?[store valueForKey:@"City"]:@"";

        _contact = ![[store valueForKey:@"NewRep"]isKindOfClass:[NSNull class]]?[store valueForKey:@"NewRep"]:@"";
        _telephone = [[store valueForKey:@"Telephone"] isKindOfClass:[NSNull class]]?@"":[store valueForKey:@"Telephone"];
        _address = ![[store valueForKey:@"Address"]isKindOfClass:[NSNull class]]?[store valueForKey:@"Address"]:@"";
//        _isChecked = [[data valueForKey:@"IsChecked"] boolValue];
        _checkStatus = [[data valueForKey:@"CheckStatus"] intValue];
        _scheduleCategoryPath = [PATH_OF_DOCUMENT stringByAppendingPathComponent:_scheduleCategory];
        _storeIdPath = [_scheduleCategoryPath stringByAppendingPathComponent:_storeId];
        NSString *plistName = [_storeId stringByAppendingString:@".plist"];
        
        _plistPath = [_storeIdPath stringByAppendingPathComponent:plistName];
        
        NSDateFormatter *formatter = [NSDateFormatter new];
        formatter.dateFormat = @"YYYY年MM月dd日";
        _endDate = [formatter dateFromString:[data valueForKey:@"EndDate"]];
    }
    
    return self;
}

@end
