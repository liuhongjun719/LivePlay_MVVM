//
//  NewbieRecommendCell.m
//  LivePlay
//
//  Created by 123456 on 16/12/9.
//  Copyright © 2016年 123456. All rights reserved.
//

#import "NewbieRecommendCell.h"
#import <Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "ModelItem.h"

@interface NewbieRecommendCell ()
@property (nonatomic, strong) UIImageView *picture;


@end

@implementation NewbieRecommendCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.picture];
        
        [self.picture mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(self);
        }];
        
    }
    return self;
}

- (UIImageView *)picture {
    if (!_picture) {
        _picture = [[UIImageView alloc] init];
    }
    return _picture;
}

- (void)setModelItem:(ModelItem *)modelItem {
    _modelItem = modelItem;
    [self.picture sd_setImageWithURL:[NSURL URLWithString:_modelItem.user.avatar]];
}


@end
