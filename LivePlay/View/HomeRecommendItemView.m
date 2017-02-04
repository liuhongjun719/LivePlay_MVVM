//
//  HomeRecommendItemView.m
//  LivePlay
//
//  Created by 123456 on 16/12/8.
//  Copyright © 2016年 123456. All rights reserved.
//

#import "HomeRecommendItemView.h"
#import <Masonry.h>
#import "ModelItem.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface HomeRecommendItemView ()
@property (nonatomic, strong) UIImageView *picture;
@property (nonatomic, strong) UILabel *follows;
@property (nonatomic, strong) UILabel *nick_name;
@property (nonatomic, strong) UIImageView *follow_back_image;
@property (nonatomic, strong) UIImageView *follow_header_image;

@end

@implementation HomeRecommendItemView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"frame-------:%@",NSStringFromCGRect(frame));

        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.picture];
        [self addSubview:self.nick_name];
        [self addSubview:self.follow_back_image];
        [self.follow_back_image addSubview:self.follow_header_image];
        [self.follow_back_image addSubview:self.follows];
        
        [self.picture mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.right.equalTo(self);
        }];
        
        
        
        [self.follow_back_image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self).multipliedBy(0.5);
            make.height.mas_equalTo(21);
            make.top.right.equalTo(self);
        }];
        


        [self.nick_name mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self);
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
//            make.height.equalTo(@10);
            make.bottom.equalTo(self.mas_bottom).offset(-5);
        }];
        
        
        [self.follows mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.follows.superview).offset(-5);
            make.top.bottom.equalTo(self.follows.superview);
            make.width.mas_equalTo(50);
        }];
        [self.follow_header_image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.follows.mas_left);
            make.width.height.mas_equalTo(10);
            make.centerY.equalTo(self.follows);
        }];
        

        
        
        [self layoutIfNeeded];
    }
    return self;
}

- (UIImageView *)picture {
    if (!_picture) {
        _picture = [[UIImageView alloc] init];
//        _picture.backgroundColor = [UIColor redColor];
    }
    return _picture;
}

- (UILabel *)follows {
    if (!_follows) {
        _follows = [[UILabel alloc] init];
        _follows.text = @"";
        _follows.textColor = [UIColor whiteColor];
        _follows.font = [UIFont systemFontOfSize:9];
        _follows.textAlignment = NSTextAlignmentCenter;
    }
    return  _follows;
}

- (UILabel *)nick_name {
    if (!_nick_name) {
        _nick_name = [[UILabel alloc] init];
        _nick_name.text = @"";
        _nick_name.font = [UIFont systemFontOfSize:9];
        _nick_name.textColor = [UIColor whiteColor];
    }
    return  _nick_name;
}

- (UIImageView *)follow_back_image {
    if (!_follow_back_image) {
        _follow_back_image = [[UIImageView alloc] init];
        _follow_back_image.image = [UIImage imageNamed:@"seeSquareTop"];
    }
    return _follow_back_image;
}

- (UIImageView *)follow_header_image {
    if (!_follow_header_image) {
        _follow_header_image = [[UIImageView alloc] init];
        _follow_header_image.image = [UIImage imageNamed:@"观看人数图标"];
    }
    return _follow_header_image;
}

- (void)setModelItem:(ModelItem *)modelItem {
    self.nick_name.text = modelItem.user.nickname;
    self.follows.text = [NSString stringWithFormat:@"%ld", (long)modelItem.users];
    [self.picture sd_setImageWithURL:[NSURL URLWithString:modelItem.user.avatar]];
}

@end
