//
//  DataManager.m
//  IPSOS
//
//  Created by 沈鹏 on 14-7-27.
//  Copyright (c) 2014年 沈鹏. All rights reserved.
//

#import "DataManager.h"
static DataManager *instance;

@implementation DataManager
{
    NSMutableArray *shopData;
    AFHTTPRequestOperationManager *manager;
}

+(instancetype)shareDataManager
{
    if (instance == nil) {
        instance = [[DataManager alloc] init];
    }
    return instance;
}

-(id)init
{
    if (self) {
        shopData = [NSMutableArray new];
        manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:SERVER]];
        [self plistInit];
    }
    
    return self;
}

-(void)plistInit
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"shopData" ofType:@"plist"];
    _plistDataTemplate = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
}

-(void)refreshShopData
{
    [manager POST:SHOP_DATA(UID) parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([self.delegate respondsToSelector:@selector(shopDataRefreshSuccess:)]) {

            [self.delegate shopDataRefreshSuccess:[responseObject valueForKey:@"data"]];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if ([self.delegate respondsToSelector:@selector(shopDataRefreshFaile:)]) {
            [self.delegate shopDataRefreshFaile:error];
        }
    }];
    
}

-(void)searchShop:(NSString*)keyword
{
    keyword = [keyword stringByReplacingOccurrencesOfString:@" " withString:@""];
    [manager POST:SHOP_SEARCH(keyword,UID) parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([self.delegate respondsToSelector:@selector(shopDataRefreshSuccess:)]) {
            [self.delegate shopDataRefreshSuccess:[responseObject valueForKey:@"data"]];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if ([self.delegate respondsToSelector:@selector(shopDataRefreshFaile:)]) {
            [self.delegate shopDataRefreshFaile:error];
        }
    }];
}

//-(void)shopChecked:(NSString*)storeId withUserId:(NSString*) userId
//{
//    [manager POST:SHOP_ISCHECKED(storeId, userId) parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        if ([self.delegate respondsToSelector:@selector(shopIsCheckedSuccess)]) {
//            [self.delegate shopIsCheckedSuccess];
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
////        if ([self.delegate respondsToSelector:@selector(shopIsCheckedFaile:)]) {
////            [self.delegate shopIsCheckedFaile:error];
////        }
//        if ([self.delegate respondsToSelector:@selector(shopIsCheckedSuccess)]) {
//            [self.delegate shopIsCheckedSuccess];
//        }
//    }];
//}

-(void)postJson:(NSString *)plistPath
{
    
    NSDictionary *plistData = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    NSString* jsonDate = [plistData JSONString];
    
    NSURL *url = [NSURL URLWithString:POST_JSON];
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    NSData *datas = [jsonDate dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:datas];
    [request setAllHTTPHeaderFields:@{@"Content-Type": @"application/json"}];
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *str = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    NSDictionary *dic = [str objectFromJSONString];
    if ([[dic valueForKey:@"success"] boolValue]) {
        if ([self.delegate respondsToSelector:@selector(postJsonSuccess)]) {
            [self.delegate postJsonSuccess];
        }else{
            if ([self.delegate respondsToSelector:@selector(postJsonFaile:)]) {
                [self.delegate postJsonFaile:[dic valueForKey:@"errors"]];
            }
        }
    }
}

-(void)login:(NSString *)username withPassword:(NSString *)password
{
    [manager POST:LoginApi parameters:@{@"username":username,@"password":password} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[responseObject valueForKey:@"success"] boolValue]) {
            NSDictionary *data = [responseObject valueForKey:@"data"];
            [USER_DEFAULT setValue:[[data valueForKey:@"Id"] stringValue] forKey:@"uid"];
            if ([self.delegate respondsToSelector:@selector(loginSuccess)]) {
                [self.delegate loginSuccess];
            }
        }else{
            if ([self.delegate respondsToSelector:@selector(loginFaile:)]) {
                [self.delegate loginFaile:nil];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if ([self.delegate respondsToSelector:@selector(loginFaile:)]) {
            [self.delegate loginFaile:error];
        }
    }];
}

-(void)shopisError:(int)scheduleId withResult:(NSString*)result
{
    [manager POST:STOREISERROR parameters:@{@"ScheduleId":[NSNumber numberWithInt:scheduleId],@"ErrorMessage":result} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([self.delegate respondsToSelector:@selector(shopIsErrorSuccess)]) {
                [self.delegate shopIsErrorSuccess];
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        if ([self.delegate respondsToSelector:@selector(shopIsErrorFaile:)]) {
//            [self.delegate shopIsErrorFaile:error];
//        }
        if ([self.delegate respondsToSelector:@selector(shopIsErrorSuccess)]) {
            [self.delegate shopIsErrorSuccess];
        }
    }];
}
@end
