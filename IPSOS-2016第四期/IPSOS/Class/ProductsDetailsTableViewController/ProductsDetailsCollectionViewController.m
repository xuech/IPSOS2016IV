//
//  ProductsDetailsCollectionViewController.m
//  IPSOS
//
//  Created by 沈鹏 on 14-8-9.
//  Copyright (c) 2014年 沈鹏. All rights reserved.
//

#import "ProductsDetailsCollectionViewController.h"

@interface ProductsDetailsCollectionViewController ()

@end

@implementation ProductsDetailsCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return [_photoData count]+1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];

    UIImageView *image =(UIImageView*)[cell.contentView viewWithTag:11];
    if ([_photoData count] == indexPath.row) {
        [image setImage:IMAGENAMED(@"btn-camera")];
    }else{
        [image setImage:[UIImage imageWithData:[_photoData objectAtIndex:indexPath.row]]];

        [image setContentMode:UIViewContentModeScaleAspectFill];
    }

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    if ([_photoData count] == indexPath.row) {
//        [self openCamera];
        [_delegate openCamera:self.num];
    }else{
//        selectedPicNum = indexPath.row;
        [_delegate deleteImage:indexPath.row withNum:self.num];
    }
}

-(void)refreshCollectionView
{
    [self.cv reloadData];
}
@end
