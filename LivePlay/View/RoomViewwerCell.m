//
//  RoomViewwerCell.m
//  LivePlay
//
//  Created by 123456 on 16/12/12.
//  Copyright © 2016年 123456. All rights reserved.
//

#import "RoomViewwerCell.h"
#import <Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "ModelItem.h"

@interface RoomViewwerCell ()
@property (nonatomic, strong) UIImageView *picture;


@end

@implementation RoomViewwerCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
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
        _picture.layer.cornerRadius = self.frame.size.width/2;
        _picture.layer.masksToBounds = YES;
    }
    return _picture;
}

- (void)setModelItem:(ModelItem *)modelItem {
    _modelItem = modelItem;
    [self.picture sd_setImageWithURL:[NSURL URLWithString:_modelItem.user.avatar]];
}


@end
