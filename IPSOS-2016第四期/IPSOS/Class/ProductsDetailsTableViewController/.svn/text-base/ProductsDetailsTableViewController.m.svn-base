//
//  ProductsDetailsTableViewController.m
//  IPSOS
//
//  Created by 沈鹏 on 14-7-31.
//  Copyright (c) 2014年 沈鹏. All rights reserved.
//

#import "ProductsDetailsTableViewController.h"
#import "ProductsDetailsCollectionViewController.h"

@interface ProductsDetailsTableViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,ProductsDetailsCollectionViewControllerDelegate>
{
    NSMutableArray *photoData1;
    NSMutableArray *photoData2;
    UICollectionView *myCollectionView1;
    UICollectionView *myCollectionView2;
    ProductsDetailsCollectionViewController *pDCV1;
    ProductsDetailsCollectionViewController *pDCV2;
    NSInteger selectedPicNum;
    NSInteger selectedCVNum;
    StoreData *storeData;
    
    NSMutableArray *dataSource;
    QuestionsData *questionData;
    NSMutableDictionary *tempP;
//    NSMutableDictionary *tempPOP;
}

@end

@implementation ProductsDetailsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    pDCV1 = [ProductsDetailsCollectionViewController new];
    pDCV1.num = 1;
    pDCV1.photoData = [NSMutableArray new];
    pDCV1.delegate = self;
    pDCV2 = [ProductsDetailsCollectionViewController new];
    pDCV2.num = 2;
    pDCV2.photoData = [NSMutableArray new];
    pDCV2.delegate = self;
    
    photoData1 = pDCV1.photoData;
    photoData2 = pDCV2.photoData;
    storeData = [[DataManager shareDataManager] storeData];
    questionData = [[QuestionsData alloc] initWithPlistPath:storeData.plistPath];
    dataSource = [questionData getQuestions:self.title];
    //缓存数据。
//    tempPOP = [dataSource objectAtIndex:dataSource.count-1];
    tempP = [NSMutableDictionary dictionaryWithDictionary:[dataSource objectAtIndex:0]];
//    [tempP setValue:@"拍照" forKey:@"name"];
//    [tempP setObject:@[@""] forKey:@"options"];
//    [dataSource insertObject:tempP atIndex:2];
//    [dataSource insertObject:tempP atIndex:dataSource.count];
    
    //POP陈列数据添加删除
//    if ([[[dataSource objectAtIndex:2] valueForKey:@"result"] count] == 0) {
//        [dataSource removeObjectAtIndex:dataSource.count-1];
//        [dataSource removeObjectAtIndex:dataSource.count-1];
//    }else if(![[[[dataSource objectAtIndex:2] valueForKey:@"result"] objectAtIndex:0] isEqualToString:@"有"]){
//        [dataSource removeObjectAtIndex:dataSource.count-1];
//        [dataSource removeObjectAtIndex:dataSource.count-1];
//    }
    
//    NSString *productPath = [storeData.storeIdPath stringByAppendingPathComponent:self.title];
//    for (NSDictionary *dic in dataSource) {
//        if ([[dic valueForKey:@"name"] isEqualToString:@"陈列位置（可复选）"]) {
//            if ([[dic valueForKey:@"pictures"] count]>0) {
//                for (NSString *imgName in [dic valueForKey:@"pictures"]) {
//                    NSString *imgPath = [productPath stringByAppendingPathComponent:imgName];
//                    NSData *imgData = [NSData dataWithContentsOfFile:imgPath];
//                    [photoData1 addObject:imgData];
//                }
//            }
//        }
//        if ([[dic valueForKey:@"name"] isEqualToString:@"POP陈列数量"]) {
//            if ([[dic valueForKey:@"pictures"] count]>0) {
//                for (NSString *imgName in [dic valueForKey:@"pictures"]) {
//                    NSString *imgPath = [productPath stringByAppendingPathComponent:imgName];
//                    NSData *imgData = [NSData dataWithContentsOfFile:imgPath];
//                    [photoData2 addObject:imgData];
//                }
//            }
//        }
//    }
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)completeEvent:(id)sender {
    BOOL verification = true;
    //遍历所有问题。判断问题选项有没有为空
    for (NSDictionary *dic in dataSource) {
        if ([[dic valueForKey:@"result"] count] == 0) {
            verification = false;
        }
    }
//    NSMutableArray *photoNames1 = [NSMutableArray new];
//    NSMutableArray *photoNames2 = [NSMutableArray new];
    if(verification){
//        NSFileManager *fileManager = [NSFileManager defaultManager];
//        NSString *imagePath= [storeData.storeIdPath stringByAppendingPathComponent:self.title];
        
//        NSError *error;
//        [fileManager createDirectoryAtPath:imagePath withIntermediateDirectories:YES attributes:nil error:&error];
//        
//        if (error) {
//            [ZAActivityBar showErrorWithStatus:@"数据文件夹创建失败"];
//            return;
//        }
        //删除产品目录下的所有jpeg文件
//        NSString *extension = @"jpeg";
//        NSArray *contents = [fileManager contentsOfDirectoryAtPath:imagePath error:NULL];
//        NSEnumerator *e = [contents objectEnumerator];
//        NSString *filename;
//        while ((filename = [e nextObject])) {
//            if ([[filename pathExtension] isEqualToString:extension]) {
//                [fileManager removeItemAtPath:[imagePath stringByAppendingPathComponent:filename] error:NULL];
//            }
//        }
        
        //将collectionView中的image存到本地
//        int i = 1;
//        for (NSData *img in photoData1) {
//            NSString *imageName = [NSString stringWithFormat:@"1-%d.jpeg",i];
//            
//            if([img writeToFile:[imagePath stringByAppendingPathComponent:imageName] options:NSDataWritingAtomic error:nil])
//            {
//                [photoNames1 addObject:imageName];
//            }
//            i++;
//        }
//        i=1;
//        for (NSData *img in photoData2) {
//            NSString *imageName = [NSString stringWithFormat:@"2-%d.jpeg",i];
//            
//            if([img writeToFile:[imagePath stringByAppendingPathComponent:imageName] options:NSDataWritingAtomic error:nil])
//            {
//                [photoNames2 addObject:imageName];
//            }
//            i++;
//        }
//        for (NSDictionary *dic in dataSource) {
//            if ([[dic valueForKey:@"name"] isEqualToString:@"陈列位置（可复选）"]) {
//                NSMutableArray *arr = [dic valueForKey:@"pictures"];
//                [arr removeAllObjects];
//                [arr addObjectsFromArray:photoNames1];
//            }
//            if ([[dic valueForKey:@"name"] isEqualToString:@"POP陈列数量"]) {
//                NSMutableArray *arr = [dic valueForKey:@"pictures"];
//                [arr removeAllObjects];
//                [arr addObjectsFromArray:photoNames2];
//            }
//        }
        //判断照片是否为空
//        if (photoNames1.count == 0) {
//            [ZAActivityBar showErrorWithStatus:@"请至少拍摄一张照片"];
//            return;
//        }
//        if ([[[[dataSource objectAtIndex:3] valueForKey:@"result"] objectAtIndex:0] isEqualToString:@"有"]) {
//            if (photoNames2.count == 0) {
//                [ZAActivityBar showErrorWithStatus:@"请至少拍摄一张照片"];
//                return;
//            }
//        }
        
        //将数据写入plist文件中，写之前先将拍照“标签”数据删除
//        [dataSource removeObject:tempP];
//        if (dataSource.count == 3) {
//            [dataSource addObject:tempPOP];
//        }
        
        if([questionData writeToPlist:storeData.plistPath]){
                [self.navigationController popViewControllerAnimated:YES];
        }else{
                [ZAActivityBar showErrorWithStatus:@"数据文件写入失败"];
        }
    }else{
        [ZAActivityBar showErrorWithStatus:@"请查看是否有问题没有选择"];
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
        switch (selectedCVNum) {
            case 1:
                [photoData1 addObject:UIImageJPEGRepresentation(image, 0.1f)];
                break;
            case 2:
                [photoData2 addObject:UIImageJPEGRepresentation(image, 0.1f)];
                break;
            default:
                break;
        }
        [myCollectionView1 reloadData];
        [myCollectionView2 reloadData];
    }];
    
}
-(void)saveSate:(UIImage *)image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    if (error) {
        [ZAActivityBar showErrorWithStatus:@"签到照片保存到本地相册失败"];
        return;
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [dataSource count];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [UILabel new];
    NSString *name =[[dataSource objectAtIndex:section] valueForKey:@"name"];
    if (section == 1) {
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@ 蓝色-货架 绿色-柜台",name]]];
        [str addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x58c7fc) range:NSMakeRange(name.length,3)];
        [str addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xc7ffc4) range:NSMakeRange(name.length+6,3)];
        label.attributedText = str;
    }else{
        label.text = name;
    }
    [label sizeToFit];
    [label setBackgroundColor:UIColorFromRGB(0xd5d5d5)];
    return label;
}

//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    NSString *name =[[dataSource objectAtIndex:section] valueForKey:@"name"];
//    if (section == 1) {
//        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@ 蓝色-货架 绿色-柜台",name]]];
//        [str addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x58c7fc) range:NSMakeRange(name.length,2)];
//        [str addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xc7ffc4) range:NSMakeRange(name.length+6,2)];
//        return str;
//    }
//    return name;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [[[dataSource objectAtIndex:section] valueForKey:@"options"] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSString *questionName = [[dataSource objectAtIndex:indexPath.section] valueForKey:@"name"];
//    if ([questionName isEqualToString:@"拍照"]) {
//        return 72;
//        
//    }else{
        return 43;
//    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    NSString *questionName = [[dataSource objectAtIndex:indexPath.section] valueForKey:@"name"];
//    if ([questionName isEqualToString:@"拍照"]) {
//        cell = [tableView dequeueReusableCellWithIdentifier:@"TakePhotoCell"];
//        if (indexPath.section == 2) {
//             myCollectionView1 = (UICollectionView*)[cell viewWithTag:1];
//            [myCollectionView1 setDelegate:pDCV1];
//            [myCollectionView1 setDataSource:pDCV1];
//        }else{
//            myCollectionView2 = (UICollectionView*)[cell viewWithTag:1];
//            [myCollectionView2 setDelegate:pDCV2];
//            [myCollectionView2 setDataSource:pDCV2];
//        }
//    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        UILabel *label = (UILabel*)[cell.contentView viewWithTag:1];
    NSString *option = [[[dataSource objectAtIndex:indexPath.section] valueForKey:@"options"] objectAtIndex:indexPath.row];
    
    if(indexPath.section == 1){
//        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",option]];
//        if (indexPath.row>3) {
//            [str addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(0,1)];
//        }else{
//            [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0,1)];
//        }
//        label.attributedText = str;
        if (indexPath.row>3) {
            [cell setBackgroundColor:UIColorFromRGB(0x58c7fc)];
        }else{
            [cell setBackgroundColor:UIColorFromRGB(0xc7ffc4)];
        }
        NSUInteger whiteColorBg = [[[dataSource objectAtIndex:indexPath.section] valueForKey:@"options"] count];
        if (whiteColorBg == indexPath.row+1 ||whiteColorBg == indexPath.row +2) {
            [cell setBackgroundColor:[UIColor whiteColor]];
        }

    }else{
//        label.text = option;
         [cell setBackgroundColor:[UIColor whiteColor]];
    }
    label.text = option;
    //        label.text = [[[dataSource objectAtIndex:indexPath.section] valueForKey:@"options"] objectAtIndex:indexPath.row];
    
        
        NSArray *result = [[dataSource objectAtIndex:indexPath.section] valueForKey:@"result"];
        
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        for (NSString *res in result) {
            if ([res isEqualToString:label.text]) {
                [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            }
        }
        
//    }

    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *options = [[[dataSource objectAtIndex:indexPath.section] valueForKey:@"options"] objectAtIndex:indexPath.row];
    
    NSMutableArray *result = [[dataSource objectAtIndex:indexPath.section] valueForKey:@"result"];
    
    //单选和多选
    if (indexPath.section == 0 || indexPath.section == 2 || indexPath.section == 3) {
        [result removeAllObjects];
        [result addObject:options];
    }else{
        if ([[tableView cellForRowAtIndexPath:indexPath] accessoryType] == UITableViewCellAccessoryCheckmark) {
            [result removeObject:options];
        }else{
            [result addObject:options];
        }
    }
    //||[options isEqualToString:@"非标准陈列"]
    if (indexPath.section == 1 ){
        if ([options isEqualToString:@"J-无陈列"] ) {
            [result removeAllObjects];
            [result addObject:options];
        }else{
            [result removeObject:@"J-无陈列"];
//            [result removeObject:@"非标准陈列"];
        }
    }
    
    
    
//    if (indexPath.section == 2 && [[tableView cellForRowAtIndexPath:indexPath] accessoryType] == UITableViewCellAccessoryNone) {
//        if([[[[dataSource objectAtIndex:2] valueForKey:@"result"] objectAtIndex:0] isEqualToString:@"有"]&&dataSource.count==3){
//            [dataSource insertObject:tempPOP atIndex:dataSource.count];
////            [tempP setValue:@"拍照" forKey:@"name"];
////            [tempP setObject:@[@""] forKey:@"options"];
////            [dataSource insertObject:tempP atIndex:dataSource.count];
//            [UIView beginAnimations:nil context:nil];
//            [UIView setAnimationDuration:0.5f];
//            CGPoint offset = self.tableView.contentOffset;
//            offset.y += 200;
//            [self.tableView setContentOffset:offset];
//            
//            [UIView commitAnimations];
//        }else if (dataSource.count==4) {
//            [dataSource removeObjectAtIndex:dataSource.count-1];
////            [dataSource removeObjectAtIndex:dataSource.count-1];
//        }
//    }
    
    
    [tableView reloadData];
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
        switch (selectedCVNum) {
            case 1:
                [photoData1 removeObjectAtIndex:selectedPicNum];
                break;
            case 2:
                [photoData2 removeObjectAtIndex:selectedPicNum];
                break;
            default:
                break;
        }
        
        [myCollectionView1 reloadData];
        [myCollectionView2 reloadData];
    }
}


@end
