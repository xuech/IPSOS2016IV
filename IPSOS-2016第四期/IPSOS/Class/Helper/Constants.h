//
//  Constants.h
//  IPSOS
//
//  Created by 沈鹏 on 14-7-28.
//  Copyright (c) 2014年 沈鹏. All rights reserved.
//

#ifndef IPSOS_Constants_h
#define IPSOS_Constants_h

#define UID [USER_DEFAULT valueForKey:@"uid"]
//#define SERVER @"http://dnn.kc328.com/"
#define SERVER @"http://ipsos.futureitsm.com/"
#define SHOP_LIST @"api/home/GetStoreList"
#define SHOP_DATA(UserId) [NSString stringWithFormat:@"Api/home/GetscheduleList?UserId=%@",UserId]
#define SHOP_SEARCH(StoreName,UserId) [[NSString stringWithFormat:@"api/home/getschedulelist?StoreName=%@&UserId=%@",StoreName,UserId] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
//#define SHOP_ISCHECKED(StoreId,UserId) [NSString stringWithFormat:@"ipsosapi/home/IsCheckedSchedule?StoreId=%@&UserId=%@&CheckStatus=1&format=json",StoreId,UserId]
#define POST_JSON @"http://ipsos.futureitsm.com/api/home/SubmitStoreCheck"
#define STOREISERROR @"api/home/StoreIsError"

#define PLISTDATA(plistPath)  [NSMutableDictionary dictionaryWithContentsOfFile:plistPath]
#define WRITE_PLISTDATA(PlistData,PlistPath) [PlistData writeToFile:PlistPath atomically:YES]
//FTP
#define FTP_SERVER @"121.41.77.89"
#define FTP_PORT 22
#define FTP_USERNAME @"ipsos"
#define FTP_PASSWORD @"97tjH4zH"
#define LoginApi @"api/account/login"


#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

//登录者ID
//

#endif
