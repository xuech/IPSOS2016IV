//
//  StoreRecordViewController.m
//  IPSOS
//
//  Created by xuech on 16/3/1.
//  Copyright (c) 2016年 沈鹏. All rights reserved.
//

#import "StoreRecordViewController.h"
#import "ReadViewController.h"
#import "M4ViewController.h"
#import "ShopTaskTableViewController2.h"


@interface StoreRecordViewController ()<UIScrollViewDelegate,M4Delegate>
{
    BOOL goNext ;
    StoreData *storeData;
    NSMutableDictionary *mData;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation StoreRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"问卷调查";
    
    
    storeData = [[DataManager shareDataManager] storeData];
    mData = [[NSMutableDictionary dictionaryWithContentsOfFile:storeData.plistPath] valueForKey:@"mData"];
    
    
    goNext = NO;
    CGRect frame;
    ReadViewController *view0 = [self.storyboard instantiateViewControllerWithIdentifier:@"ReadViewController"];
    frame = view0.view.frame;
    frame.origin.x = 0;
    [view0.view setFrame:frame];


    M4ViewController *view1 = [self.storyboard instantiateViewControllerWithIdentifier:@"M4"];
    frame = view1.view.frame;
    frame.origin.x = SCREEN_WIDTH;
    [view1.view setFrame:frame];
    view1.delegate = self;
    
//    ShopTaskTableViewController2 *view2 = [self.storyboard instantiateViewControllerWithIdentifier:@"ShopTaskTableViewController2"];
//    frame = view2.view.frame;
//    frame.origin.x = SCREEN_WIDTH*2;
//    [view2.view setFrame:frame];
    
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH *2, _scrollView.contentSize.height);
    [_scrollView addSubview:view0.view];
    [_scrollView addSubview:view1.view];
//    [_scrollView addSubview:view2.view];
    [self addChildViewController:view0];
    [self addChildViewController:view1];
//    [self addChildViewController:view2];
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"下一页" style:UIBarButtonItemStyleDone target:self action:@selector(nextPage)];
    
    self.navigationItem.rightBarButtonItem = button;
}

-(void)nextPage
{
    if ([self.navigationItem.rightBarButtonItem.title isEqualToString:@"完成"])
    {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"completeEvent" object:nil];
//        [mData setValue:[NSNumber numberWithBool:YES] forKey:@"M3"];
        [ZAActivityBar dismiss];
//        [mData setValue:[[NSDate date] description] forKey:@"endTime"];
        NSMutableDictionary *dic = PLISTDATA(storeData.plistPath);
        [dic setValue:mData forKey:@"mData"];
        [dic writeToFile:storeData.plistPath atomically:YES];
        NSLog(@"submit === %@",dic);

        return;
    }else {
        NSString *name = [mData valueForKey:@"M6Contact"];
        NSString *phone = [mData valueForKey:@"M6PhoneNumber"];
        if (isEmptyOrNULL(name)) {
            [ZAActivityBar showErrorWithStatus:@"名字不为空"];
            return;
        }
        if (isEmptyOrNULL(phone)) {
            [ZAActivityBar showErrorWithStatus:@"号码不为空"];
            return;
        }
        [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH+_scrollView.contentOffset.x, 0) animated:YES];
        
        if (self.scrollView.contentOffset.x == SCREEN_WIDTH) {
            self.navigationItem.rightBarButtonItem.title = @"完成";
            [self.navigationItem.rightBarButtonItem setEnabled:YES];
        }else{
//            NSString *name = [mData valueForKey:@"M6Contact"];
//            NSString *phone = [mData valueForKey:@"M6PhoneNumber"];
//            if (name.length>0) {
//                [mData setValue:name forKey:@"M6Contact"];
//            }else{
//                [ZAActivityBar showErrorWithStatus:@"名字不为空"];
//            }
//            if (phone.length>0) {
//                [mData setValue:phone forKey:@"M6PhoneNumber"];
//            }else{
//                [ZAActivityBar showErrorWithStatus:@"号码不为空"];
//            }
            [self.navigationItem.rightBarButtonItem setEnabled:NO];
        }
    }

    
}

-(void)m4Dic:(NSDictionary *)dic
{
    NSString *name = [dic valueForKey:@"Name"];
    NSString *phone = [dic valueForKey:@"Phone"];
    [mData setValue:name forKey:@"M6Contact"];
    [mData setValue:phone forKey:@"M6PhoneNumber"];
//    if (name.length>0) {
//        [mData setValue:name forKey:@"M6Contact"];
//    }else{
//        [ZAActivityBar showErrorWithStatus:@"名字不为空"];
//    }
//    if (phone.length>0) {
//        [mData setValue:phone forKey:@"M6PhoneNumber"];
//    }else{
//        [ZAActivityBar showErrorWithStatus:@"号码不为空"];
//    }
    
    
}

-(void)m4Event:(BOOL)sign
{
    [mData setObject:[NSNumber numberWithBool:sign] forKey:@"M6"];
    [self.navigationItem.rightBarButtonItem setEnabled:YES];
}

@end
