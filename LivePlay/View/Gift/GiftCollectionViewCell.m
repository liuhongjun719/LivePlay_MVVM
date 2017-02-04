//
//  GiftCollectionViewCell.m
//  LivePlay
//
//  Created by 123456 on 16/12/13.
//  Copyright © 2016年 123456. All rights reserved.
//

#import "GiftCollectionViewCell.h"
#import <Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "ModelItem.h"

@interface GiftCollectionViewCell ()
@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *gold;

@end

@implementation GiftCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.image];
        [self addSubview:self.name];
        [self addSubview:self.gold];
        [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(5);
            make.width.height.mas_equalTo(self.frame.size.width/3);
            make.centerX.equalTo(self);
        }];
        
        [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.image.mas_bottom).offset(3);
            make.left.equalTo(self).offset(5);
            make.right.equalTo(self).offset(-5);
            make.height.mas_equalTo(10);
        }];
        
        [self.gold mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.name.mas_bottom).offset(3);
            make.left.right.equalTo(self.name);
            make.height.mas_equalTo(10);
        }];
    }
    return self;
}

- (UIImageView *)image {
    if (!_image) {
        _image = [[UIImageView alloc] init];
    }
    return _image;
}

- (UILabel *)name {
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.font = [UIFont systemFontOfSize:10];
        _name.textAlignment = NSTextAlignmentCenter;
        _name.textColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:222/255.0 alpha:1.0];
    }
    return _name;
}

- (UILabel *)gold {
    if (!_gold) {
        _gold = [[UILabel alloc] init];
        _gold.font = [UIFont systemFontOfSize:10];
        _gold.textAlignment = NSTextAlignmentCenter;
        _gold.textColor = [UIColor colorWithRed:255/255.0 green:232/255.0 blue:19/255.0 alpha:1.0];
    }
    return _gold;
}

- (void)setModelItem:(ModelItem *)modelItem {
    _modelItem = modelItem;
    [self.image sd_setImageWithURL:[NSURL URLWithString:modelItem.image]];
    self.name.text = modelItem.name;
    self.gold.text = [NSString stringWithFormat:@"%ld金币", (long)modelItem.from_gold];
}

@end
