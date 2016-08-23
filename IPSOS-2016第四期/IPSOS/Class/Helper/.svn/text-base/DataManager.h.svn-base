//
//  DataManager.h
//  IPSOS
//
//  Created by 沈鹏 on 14-7-27.
//  Copyright (c) 2014年 沈鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataManagerDelegate <NSObject>

@required
-(void)shopDataRefreshSuccess:(id)data;
-(void)shopDataRefreshFaile:(NSError*)error;
//-(void)shopIsCheckedSuccess;
//-(void)shopIsCheckedFaile:(NSError*)error;
-(void)postJsonSuccess;
-(void)postJsonFaile:(NSError*)error;
-(void)shopIsErrorSuccess;
-(void)shopIsErrorFaile:(NSError*)error;
-(void)loginSuccess;
-(void)loginFaile:(NSError*)error;

@end

@interface DataManager : NSObject

@property (retain,nonatomic) id<DataManagerDelegate> delegate;
@property (readonly,nonatomic) NSMutableDictionary* plistDataTemplate;
@property (retain,nonatomic) StoreData *storeData;

+(instancetype)shareDataManager;
-(id)init;
-(void)plistInit;
-(void)refreshShopData;
-(void)searchShop:(NSString*)keyword;
//-(void)shopChecked:(NSString*)storeId withUserId:(NSString*) userId;
-(void)postJson:(NSString *)jsonPath;
-(void)login:(NSString*)username withPassword:(NSString*)password;
-(void)shopisError:(int)scheduleId withResult:(NSString*)result;
@end


