//
//  ProductsDetailsCollectionViewController.h
//  IPSOS
//
//  Created by 沈鹏 on 14-8-9.
//  Copyright (c) 2014年 沈鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProductsDetailsCollectionViewControllerDelegate <NSObject>

-(void)openCamera:(NSInteger) num;
-(void)deleteImage:(NSInteger)row withNum:(NSInteger)num;

@end

@interface ProductsDetailsCollectionViewController : UICollectionViewController

@property (nonatomic) NSInteger num;
@property (strong,nonatomic) NSMutableArray *photoData;
@property (strong,nonatomic) id<ProductsDetailsCollectionViewControllerDelegate> delegate;
@property (strong,nonatomic) UICollectionView *cv;

-(void)refreshCollectionView;

@end


