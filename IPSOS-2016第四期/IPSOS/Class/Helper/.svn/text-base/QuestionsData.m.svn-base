//
//  QuestionsData.m
//  IPSOS
//
//  Created by 沈鹏 on 14-8-8.
//  Copyright (c) 2014年 沈鹏. All rights reserved.
//

#import "QuestionsData.h"

@implementation QuestionsData


-(id)initWithPlistPath:(NSString*)plistPath
{
    if (self) {
            _data = [PLISTDATA(plistPath) valueForKey:@"taskData"];
    }
    
    return self;
}

-(NSArray*)getProductList
{
    NSMutableArray *arr = [NSMutableArray new];
    for (NSDictionary *dic in _data) {
        [arr addObject:[dic valueForKey:@"productName"]];
    }
    return arr;
}

-(NSMutableArray*)getQuestions:(NSString*)productName
{
    NSMutableArray *arr;
    for (NSDictionary *dic in _data) {
        if ([[dic valueForKey:@"productName"] isEqualToString:productName]) {
            arr = [dic valueForKey:@"questions"];
        }
    }
    return arr;
}

-(BOOL)writeToPlist:(NSString*)plistPath
{
    NSMutableDictionary *data = PLISTDATA(plistPath);
    [data setObject:_data forKey:@"taskData"];
    return WRITE_PLISTDATA(data, plistPath);
}


@end
