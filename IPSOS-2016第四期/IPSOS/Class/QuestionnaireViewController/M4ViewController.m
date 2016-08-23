//
//  M2ViewController.m
//  IPSOS
//
//  Created by 沈鹏 on 14-8-11.
//  Copyright (c) 2014年 沈鹏. All rights reserved.
//

#import "M4ViewController.h"
#import "ShopDetailsViewController.h"

@interface M4ViewController ()<UITextFieldDelegate>
{
    StoreData *storeData;
    NSMutableDictionary *mData;
}
@property (weak, nonatomic) IBOutlet UIView *otherView;
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextFied;

@end

@implementation M4ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    _nameTextField.delegate = self;
    _phoneTextFied.delegate = self;
    [self.otherView setHidden:true];

    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(done)];
    self.navigationItem.rightBarButtonItem = rightItem;
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
    
    storeData = [[DataManager shareDataManager] storeData];
    mData = [[NSMutableDictionary dictionaryWithContentsOfFile:storeData.plistPath] valueForKey:@"mData"];
}

- (void)done
{
    BOOL agree = [[mData valueForKey:@"M6"]boolValue];
    if (isEmptyOrNULL(_nameTextField.text)&&!agree) {
        [ZAActivityBar showErrorWithStatus:@"名字不为空"];
        return;
    }else{
        [mData setValue:_nameTextField.text forKey:@"M6Contact"];
    }
    if (isEmptyOrNULL(_phoneTextFied.text)&&!agree) {
        [ZAActivityBar showErrorWithStatus:@"号码不为空"];
        return;
    }else{
        [mData setValue:_phoneTextFied.text forKey:@"M6PhoneNumber"];
    }
    [self saveAndBack];
}

-(void)saveAndBack {
    
    NSMutableDictionary *dic = PLISTDATA(storeData.plistPath);
    [dic setValue:[NSNumber numberWithBool:YES] forKey:@"IsRead"];
    [dic setValue:mData forKey:@"mData"];
    [dic writeToFile:storeData.plistPath atomically:YES];
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[ShopDetailsViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}

- (IBAction)buttonEvent:(id)sender {
//    BOOL temp = NO;
    [self.navigationItem.rightBarButtonItem setEnabled:YES];
    [_img1 setImage:IMAGENAMED(@"icon-checkbox")];
    [_img2 setImage:IMAGENAMED(@"icon-checkbox")];
    switch ([sender tag]) {
        case 1:
            [_img1 setImage:IMAGENAMED(@"icon-checkboxselected")];
            [self.otherView setHidden:true];
//            temp = true;
            [mData setObject:[NSNumber numberWithBool:true] forKey:@"M6"];
            break;
        case 2:
            [_img2 setImage:IMAGENAMED(@"icon-checkboxselected")];
            [self.otherView setHidden:false];
            
//            temp = false;
            [mData setObject:[NSNumber numberWithBool:false] forKey:@"M6"];
            break;
            
        default:
            break;
    }
    
//    [self.delegate m4Event:temp];
    
}


//-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
//{
//    NSDictionary *dic = @{@"Name":_nameTextField.text,@"Phone":_phoneTextFied.text};
//    [self.delegate m4Dic:dic];
//    return true;
//}

@end
