//
//  ShopTaskTableViewCell.m
//  IPSOS
//
//  Created by 沈鹏 on 14-8-8.
//  Copyright (c) 2014年 沈鹏. All rights reserved.
//

#import "ShopTaskTableViewCell.h"

@implementation ShopTaskTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

-(void)setIndexOfCell:(NSIndexPath *)indexOfCell
{
    NSLog(@"/index---%ld",(long)indexOfCell.row);
    _indexOfCell = indexOfCell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    if (_isSelected) {
        if (_isHave) {
            [_imgView1 setImage:IMAGENAMED(@"icon-checkboxselected")];
            [_imgView2 setImage:IMAGENAMED(@"icon-checkbox")];
        }else{
            [_imgView1 setImage:IMAGENAMED(@"icon-checkbox")];
            [_imgView2 setImage:IMAGENAMED(@"icon-checkboxselected")];
        }
    }else{
        [_imgView1 setImage:IMAGENAMED(@"icon-checkbox")];
        [_imgView2 setImage:IMAGENAMED(@"icon-checkbox")];
    }
}

- (IBAction)buttonEvents:(id)sender {
    [_imgView1 setImage:IMAGENAMED(@"icon-checkbox")];
    [_imgView2 setImage:IMAGENAMED(@"icon-checkbox")];
    
    switch ([sender tag]) {
        case 1:
            [_imgView1 setImage:IMAGENAMED(@"icon-checkboxselected")];
            [_delegate ShopTaskTableViewCellHaveEvent:_productName andIndex:_indexOfCell];
            NSLog(@"left");
            break;
        
        case 2:
            [_imgView2 setImage:IMAGENAMED(@"icon-checkboxselected")];
            [_delegate ShopTaskTableViewCellNoHaveEvent:_productName];
            NSLog(@"right");
            break;
        default:
            break;
    }
}
@end
