//
//  FocusCell.m
//  FocusHeaderDemo
//
//  Created by 123456 on 16/4/5.
//  Copyright © 2016年 123456. All rights reserved.
//

#import "FocusCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <AFNetworking.h>
#import "ModelItem.h"

@implementation FocusCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}
- (void)setImageViewWithImageName:(ModelItem *)modelItem{
    [self.focusImageView sd_setImageWithURL:[NSURL URLWithString:modelItem.image]
                 placeholderImage:nil];
}
@end
