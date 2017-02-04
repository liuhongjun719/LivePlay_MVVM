//
//  HomeOutstandingCell.m
//  LivePlay
//
//  Created by 123456 on 16/12/8.
//  Copyright © 2016年 123456. All rights reserved.
//

#import "HomeOutstandingCell.h"
#import "HomeRecommendItemView.h"
#import <Masonry.h>

@interface HomeOutstandingCell ()
@property (nonatomic, strong) HomeRecommendItemView *picture;
@property (nonatomic, strong) UILabel *nick_name;


@end

@implementation HomeOutstandingCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.picture];
        [self addSubview:self.nick_name];
        
        
        [self.picture mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.height.equalTo(@(self.frame.size.height-20));
        }];
        
        [self.nick_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.picture);
            make.top.equalTo(self.picture.mas_bottom);
            make.bottom.equalTo(self);
        }];
    }
    return self;
}

- (HomeRecommendItemView *)picture {
    if (!_picture) {
        _picture = [[HomeRecommendItemView alloc] init];
    }
    return _picture;
}

- (UILabel *)nick_name {
    if (!_nick_name) {
        _nick_name = [[UILabel alloc] init];
        _nick_name.text = @"交罚款了时间人观看";
        _nick_name.font = [UIFont systemFontOfSize:9];
    }
    return  _nick_name;
}
- (void)setModelItem:(ModelItem *)modelItem {
    self.picture.modelItem = modelItem;
}
@end
