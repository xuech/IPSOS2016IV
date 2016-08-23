//
//  ErrorViewController.m
//  IPSOS
//
//  Created by 沈鹏 on 14-8-12.
//  Copyright (c) 2014年 沈鹏. All rights reserved.
//

#import "ErrorViewController.h"
#import "ProductsDetailsCollectionViewController.h"
#import <MapKit/MapKit.h>

@interface ErrorViewController ()<DataManagerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,ProductsDetailsCollectionViewControllerDelegate,CLLocationManagerDelegate>
{
    NSInteger selectedPicNum;
    NSInteger selectedCVNum;
    BOOL isSelected;
    UIButton *currentButton;
    NSMutableArray *photosData;
    ProductsDetailsCollectionViewController *p;
    StoreData *storeData;
    MBProgressHUD *hud;
    Reachability *reachability;
    CLLocation *userLocation;
}

@property (weak, nonatomic) IBOutlet UICollectionView *takePhotoView;
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UIImageView *img3;
@property (weak, nonatomic) IBOutlet UIImageView *img4;
@property (weak, nonatomic) IBOutlet UIImageView *img5;

@property (strong, nonatomic) DLSFTPConnection *connection;
@property (nonatomic, strong) DLSFTPRequest *request;

@end

@implementation ErrorViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    isSelected = false;
    storeData = [[DataManager shareDataManager] storeData];
    photosData = [NSMutableArray new];
    
    [Flurry logEvent:@"报错" withParameters:[Context getSystemInfo]];

    p =[ProductsDetailsCollectionViewController new];
    p.delegate = self;
    p.num = 0;
    p.photoData = photosData;
    p.cv = self.takePhotoView;
    self.takePhotoView.delegate = p;
    self.takePhotoView.dataSource = p;
    
    NSMutableArray *checkPhoto = [[NSMutableDictionary dictionaryWithContentsOfFile:storeData.plistPath] objectForKey:@"checkPhotos"];
    
    for (NSDictionary *dic in checkPhoto) {
        NSString *name = [dic valueForKey:@"name"];
        NSArray *arr = [dic valueForKey:@"res"];
        if (![name isEqualToString:@"报错"]) {
            continue;
        }
        for (NSString *imageName in arr) {
            
            NSString *path = [[storeData.storeIdPath stringByAppendingPathComponent:@"Photos"] stringByAppendingPathComponent:imageName];
            NSData *imgData = [NSData dataWithContentsOfFile:path];
            [photosData addObject:imgData];
        }
    }
    
    hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:hud];

//    CLLocationManager *locationManager;//定义Manager
//    // 判断定位操作是否被允许
//    if([CLLocationManager locationServicesEnabled]) {
//        locationManager = [CLLocationManager new];
//        
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//        locationManager.delegate = self;
//        // 开始定位
//        [locationManager startUpdatingLocation];
//    }else {
//        //提示用户无法进行定位操作
//        [ZAActivityBar showErrorWithStatus:@"无法定位，请在设置中开启定位"];
//    }
    
    

}

-(void)viewWillDisappear:(BOOL)animated
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *imagePath= [storeData.storeIdPath stringByAppendingPathComponent:@"Photos"];
    
    NSError *error;
    [fileManager createDirectoryAtPath:imagePath withIntermediateDirectories:YES attributes:nil error:&error];
    
    if (error) {
        [ZAActivityBar showErrorWithStatus:@"数据文件夹创建失败"];
        return;
    }
    //删除产品目录下的所有jpeg文件
//    NSString *extension = @"jpeg";
//    NSArray *contents = [fileManager contentsOfDirectoryAtPath:imagePath error:NULL];
//    NSEnumerator *e = [contents objectEnumerator];
//    NSString *filename;
    NSMutableArray *checkPhotos = [[NSMutableDictionary dictionaryWithContentsOfFile:storeData.plistPath] objectForKey:@"checkPhotos"];
    NSMutableArray *otherPhotos = [NSMutableArray new];
    for (NSDictionary *dic in checkPhotos) {
        NSArray *arr = [dic valueForKey:@"res"];
        NSString *name = [dic valueForKey:@"name"];
        if(![name isEqualToString:@"报错"]){
            [otherPhotos addObject:dic];
            continue;
        }
        for (NSString *imageName in arr) {
            NSString *path = [imagePath stringByAppendingPathComponent:imageName];
            [fileManager removeItemAtPath:path error:NULL];
        }
    }
//    while ((filename = [e nextObject])) {
//        if ([[filename pathExtension] isEqualToString:extension]) {
//            [fileManager removeItemAtPath:[imagePath stringByAppendingPathComponent:filename] error:NULL];
//        }
//    }
    
    //将collectionView中的image存到本地
    int i = 0;
    NSMutableArray *photosName = [NSMutableArray new];
    
    for (NSData *imgData in photosData) {
        NSString *imageName = [NSString stringWithFormat:@"error-%d-%d.jpeg",i,i];
        if([imgData writeToFile:[imagePath stringByAppendingPathComponent:imageName] options:NSDataWritingAtomic error:nil])
        {
            [photosName addObject:imageName];
            i++;
        }
    }
    
    checkPhotos = [[NSMutableArray alloc] initWithArray:otherPhotos];
    NSMutableDictionary *dicData = [NSMutableDictionary new];
    [dicData setValue:@"报错" forKey:@"name"];
    [dicData setObject:photosName forKey:@"res"];
    
    [checkPhotos addObject:dicData];
   
   
    NSMutableDictionary *plistData = [NSMutableDictionary dictionaryWithContentsOfFile:storeData.plistPath];
    [plistData setObject:checkPhotos forKey:@"checkPhotos"];
    if(!WRITE_PLISTDATA(plistData, storeData.plistPath)){
        [ZAActivityBar showErrorWithStatus:@"数据文件写入失败"];
    }

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectedEvent:(id)sender {
    isSelected = true;
    [_img1 setImage:IMAGENAMED(@"icon-checkbox")];
    [_img2 setImage:IMAGENAMED(@"icon-checkbox")];
    [_img3 setImage:IMAGENAMED(@"icon-checkbox")];
    [_img4 setImage:IMAGENAMED(@"icon-checkbox")];
    [_img5 setImage:IMAGENAMED(@"icon-checkbox")];
    switch ([sender tag]) {
        case 1:
            [_img1 setImage:IMAGENAMED(@"icon-checkboxselected")];
            break;
        case 2:
            [_img2 setImage:IMAGENAMED(@"icon-checkboxselected")];
            break;
        case 3:
            [_img3 setImage:IMAGENAMED(@"icon-checkboxselected")];
            break;
        case 4:
            [_img4 setImage:IMAGENAMED(@"icon-checkboxselected")];
            break;
        case 5:
            [_img5 setImage:IMAGENAMED(@"icon-checkboxselected")];
            break;
            
        default:
            break;
    }
    currentButton = (UIButton*)sender;
}


- (IBAction)completeEvent:(id)sender {
//    if (userLocation == nil){
//        [ZAActivityBar showErrorWithStatus:@"正在定位中。。。"];
//        return;
//    }
    if (!isSelected) {
        [ZAActivityBar showErrorWithStatus:@"请先选择错误的信息"];
        return;
    }
    BOOL verification = true;
    if ([photosData count] == 0) {
        verification = false;
    }
    
    if (verification) {
        [self viewWillDisappear:true];
        
        NSDictionary *plistData = [NSMutableDictionary dictionaryWithContentsOfFile:storeData.plistPath];
        //设置签到GPS位置
//        [plistData setValue:@{@"lat":[NSNumber numberWithDouble:userLocation.coordinate.latitude],@"lng":[NSNumber numberWithDouble:userLocation.coordinate.longitude]} forKey:@"signInLatLng"];
        
        [plistData setValue:[NSNumber numberWithBool:YES] forKey:@"isCheckPhotos"];
        //设置是否已经签到
        [plistData setValue:[NSNumber numberWithBool:true] forKey:@"isSignIn"];
        //设置签到日期
        [plistData setValue:[[NSDate date] description] forKey:@"signInDate"];

        [plistData setValue:[NSNumber numberWithBool:true] forKey:@"IsError"];
        [plistData setValue:@"" forKey:@"mData"];
        [plistData setValue:@"" forKey:@"taskData"];
        [plistData setValue:@"" forKey:@"taskData2"];
        if(!WRITE_PLISTDATA(plistData, storeData.plistPath)){
            [ZAActivityBar showErrorWithStatus:@"数据文件写入失败"];
        }else{
            [self uploadZip];
//            [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        [ZAActivityBar showErrorWithStatus:@"请至少拍摄一张照片"];
    }
    
    
}

//-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
//{
//    //此处locations存储了持续更新的位置坐标值，取最后一个值为最新位置，如果不想让其持续更新位置，则在此方法中获取到一个值之后让locationManager stopUpdatingLocation
//    userLocation = [locations lastObject];
//    
//    
//    //[self.locationManager stopUpdatingLocation];
//    
//}
//
//- (void)locationManager:(CLLocationManager *)manager
//       didFailWithError:(NSError *)error {
//    
//    if (error.code == kCLErrorDenied) {
//        // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
//    }
//    userLocation = nil;
//    [ZAActivityBar showErrorWithStatus:@"定位失败，无法报错"];
//}


//上传数据
-(void)uploadZip
{
    //判断网络是否正常
    if ([self isConnectionAvailable] == 0) {
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"网络异常";
        [hud show:YES];
        [hud hide:YES afterDelay:2];
        return;
    }
//    if ([self isConnectionAvailable] != 1) {
//        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"您当前不是wifi网络,可能会导致上传失败。" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"上传" otherButtonTitles:nil, nil];
//        [actionSheet showInView:self.navigationController.view];
//        return;
//    }
    /****************************/
    //侦听网络
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name: kReachabilityChangedNotification
                                               object: nil];
    reachability = [Reachability reachabilityWithHostName:@"www.apple.com"];
    [reachability startNotifier];
    
    [Flurry logEvent:@"上传开始" withParameters:[Context getSystemInfo]];
//    [self uploadZip];
    
    NSStringEncoding gbkEncoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
    
    NSString *documentPath = PATH_OF_DOCUMENT;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDirectoryEnumerator *filesList = [fileManager enumeratorAtPath:storeData.storeIdPath];
    
    //压缩文件
    NSString *zipFile = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.zip",storeData.storeId]];
    ZipArchive *zipArchive = [[ZipArchive alloc] init];
    //必须转成gbk编码。不然windows下解压会乱码
    [zipArchive setStringEncoding:gbkEncoding];
    [zipArchive CreateZipFile2:zipFile];
    
    //遍历文件添加到压缩包里
    NSString *filePath;
    BOOL isDir;
    while ((filePath = [filesList nextObject]) != nil) {
        [fileManager fileExistsAtPath:[storeData.storeIdPath stringByAppendingPathComponent:filePath] isDirectory:&isDir];
        if (!isDir) {
            [zipArchive addFileToZip:[storeData.storeIdPath stringByAppendingPathComponent:filePath] newname:[[storeData.scheduleCategory stringByAppendingPathComponent:storeData.storeId] stringByAppendingPathComponent:filePath]];
        }
    }
    if([zipArchive CloseZipFile2]){
        [hud setMode:MBProgressHUDModeDeterminateHorizontalBar];
        [hud setLabelText:@"正在连接服务器"];
        [hud show:YES];
        /*************************************************************************/
        //使用DLSFTP
        DLSFTPConnection *connection = [[DLSFTPConnection alloc] initWithHostname:FTP_SERVER
                                                                             port:FTP_PORT
                                                                         username:FTP_USERNAME
                                                                         password:FTP_PASSWORD];
        
        self.connection = connection;
        DLSFTPClientSuccessBlock successBlock = ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                //                NSLog(@"successful");
                [hud setLabelText:@"正在上传数据"];
                DLSFTPClientProgressBlock progressBlock = ^void(unsigned long long bytesSent, unsigned long long bytesTotal) {
                    float progress = (float)bytesSent / (float)bytesTotal;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //                        NSLog(@"%f",progress);
                        hud.progress = progress;
                    });
                };
                
                DLSFTPClientFileTransferSuccessBlock successBlock = ^(DLSFTPFile *file, NSDate *startTime, NSDate *finishTime) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSTimeInterval duration = round([finishTime timeIntervalSinceDate:startTime]);
                        unsigned long long rate = (file.attributes.fileSize / duration);
                        NSLog(@"%llu",rate);
                        hud.labelText = @"上传成功";
                        [hud hide:YES afterDelay:1];
                        [[NSNotificationCenter defaultCenter] removeObserver:self];
                        
                        [[DataManager shareDataManager] setDelegate:self];
                        [[DataManager shareDataManager] postJson:storeData.plistPath];
                    });
                };
                
                DLSFTPClientFailureBlock failureBlock = ^(NSError *error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //                        NSLog(@"faile");
                        hud.labelText = @"上传失败";
                        [hud hide:YES afterDelay:1];
                        [[NSNotificationCenter defaultCenter] removeObserver:self];
                    });
                };
                
                self.request = [[DLSFTPUploadRequest alloc] initWithRemotePath:[NSString stringWithFormat:@"%@.zip",storeData.storeId]
                                                                     localPath:zipFile
                                                                  successBlock:successBlock
                                                                  failureBlock:failureBlock
                                                                 progressBlock:progressBlock];
                
                [self.connection submitRequest:self.request];
            });
        };
        
        DLSFTPClientFailureBlock failureBlock = ^(NSError *error){
            dispatch_async(dispatch_get_main_queue(), ^{
                //                NSLog(@"faile");
                hud.labelText = @"服务器连接失败";
                [hud hide:YES afterDelay:1];
                [[NSNotificationCenter defaultCenter] removeObserver:self];
            });
        };
        
        [connection connectWithSuccessBlock:successBlock
                               failureBlock:failureBlock];
        
    }else{
        [ZAActivityBar showErrorWithStatus:@"文件压缩失败，上传中止"];
    }
    
}

-(NSInteger) isConnectionAvailable{
    
    int existenceNetwork = 0;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            existenceNetwork = 0;
            //NSLog(@"notReachable");
            break;
        case ReachableViaWiFi:
            existenceNetwork = 1;
            //NSLog(@"WIFI");
            break;
        case ReachableViaWWAN:
            existenceNetwork = 2;
            //NSLog(@"3G");
            break;
    }
    
    return existenceNetwork;
}

//网络改变时执行
- (void)reachabilityChanged:(NSNotification *)note {
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    NetworkStatus status = [curReach currentReachabilityStatus];
    
    if (status == NotReachable) {
        hud.labelText = @"上传失败";
        [hud hide:YES afterDelay:1];
        [self.connection cancelAllRequests];
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

#pragma mark - DataManagerDelegate
-(void)postJsonSuccess
{
    //    [[DataManager shareDataManager] shopChecked:storeData.storeId withUserId:UID];
    [hud hide:YES];
   
    [Flurry logEvent:@"上传完成" withParameters:[Context getSystemInfo]];
    [DataManager shareDataManager].delegate =self;
    [[DataManager shareDataManager] shopisError:[[DataManager shareDataManager] storeData].scheduleId withResult:[currentButton currentTitle]];

}

-(void)postJsonFaile:(NSError *)error
{
    [ZAActivityBar showErrorWithStatus:@"报错失败，请尝试重新提交"];
}

-(void)shopIsErrorSuccess
{
    [Flurry logEvent:@"报错完成" withParameters:[Context getSystemInfo]];
    [ZAActivityBar showErrorWithStatus:@"报错完成"];
     [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)shopIsErrorFaile:(NSError *)error
{
    [ZAActivityBar showErrorWithStatus:@"报错失败，请尝试重新提交"];
}


#pragma mark -FTPManagerDelegate
-(void)ftpManagerUploadProgressDidChange:(NSDictionary *)processInfo
{
    hud.progress = [[processInfo valueForKey:@"progress"] doubleValue];
    if(hud.progress >= 1)
    {
        hud.labelText = @"上传成功";
    }
}


-(void)openCamera:(NSInteger)num
{
    selectedCVNum = num;
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
    picker.delegate = self;
    picker.allowsEditing = NO;//设置可编辑
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:nil];//进入照相界面
}

#pragma mark - UIImagePickerControllerDelegate and UINavigationControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(saveSate:didFinishSavingWithError:contextInfo:), nil);
        NSMutableArray *res = photosData;
        UIImage *img = nil;
        if (image.imageOrientation == UIImageOrientationRight) {
            img = [self image:image rotation:UIImageOrientationRight];
        }else if(image.imageOrientation == UIImageOrientationLeft){
            img = [self image:image rotation:UIImageOrientationLeft];
        }else if(image.imageOrientation == UIImageOrientationDown){
            img = [self image:image rotation:UIImageOrientationDown];
        }else{
            img = image;
        }
        [res addObject:UIImageJPEGRepresentation(img, 0.1f)];
        [self refreshCollectionView];
    }];
    
}
-(void)saveSate:(UIImage *)image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    if (error) {
        [ZAActivityBar showErrorWithStatus:@"签到照片保存到本地相册失败"];
        return;
    }
    
}

-(void)deleteImage:(NSInteger)row withNum:(NSInteger)num
{
    selectedCVNum = num;
    selectedPicNum = row;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除该照片" otherButtonTitles:nil, nil];
    [actionSheet showInView:self.navigationController.view];
}

#pragma mark -ActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSMutableArray *res = photosData;
        [res removeObjectAtIndex:selectedPicNum];
    }
    [self refreshCollectionView];
}

-(void)refreshCollectionView
{
    [p refreshCollectionView];
 
}

- (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation
{
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic;
}

@end
