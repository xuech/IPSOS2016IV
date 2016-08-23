//
//  QuestionsData.h
//  IPSOS
//
//  Created by 沈鹏 on 14-8-8.
//  Copyright (c) 2014年 沈鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionsData : NSObject

@property (strong,nonatomic) NSArray *data;

-(id)initWithPlistPath:(NSString*)plistPath;
-(NSArray*)getProductList;
-(NSMutableArray*)getQuestions:(NSString*)productName;
-(BOOL)writeToPlist:(NSString*)plistPath;
@end
