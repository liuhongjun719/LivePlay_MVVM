//
//  HJBroadcastHeadView.m
//  LivePlay
//
//  Created by 123456 on 16/12/9.
//  Copyright © 2016年 123456. All rights reserved.
//

#import "HJBroadcastHeadView.h"
#import <Masonry.h>

@interface HJBroadcastHeadView ()
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIButton *close;
@property (nonatomic, strong) UIButton *nick_name;
@property (nonatomic, strong) UIButton *share;

@end
@implementation HJBroadcastHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.5;
        [self addSubview:self.headerView];
        [self addSubview:self.close];
        [self addSubview:self.nick_name];
        [self addSubview:self.share];
        
        [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.right.equalTo(self);
        }];
        [self.close mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.centerY.equalTo(self);
            make.width.height.equalTo(@15);
        }];
        
        [self.share mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-10);
            make.centerY.equalTo(self);
            make.width.height.equalTo(@15);
        }];
        [self.nick_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.close.mas_right).offset(5);
            make.centerY.equalTo(self);
            make.right.equalTo(self.share.mas_left).offset(-5);
            make.height.equalTo(@15);
        }];
    }
    return self;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] init];
    }
    return _headerView;
}
- (UIButton *)close {
    if (!_close) {
        _close = [UIButton buttonWithType:UIButtonTypeCustom];
        [_close setBackgroundImage:[UIImage imageNamed:@"手机直播关闭"] forState:UIControlStateNormal];
        [_close addTarget:self action:@selector(closePage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _close;
}
- (UIButton *)nick_name {
    if (!_nick_name) {
        _nick_name = [[UIButton alloc] init];
    }
    return _nick_name;
}
- (UIButton *)share {
    if (!_share) {
        _share = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _share;
}
#pragma mark - Action
- (void)closePage {
    if (self.closePageBlock) {
        self.closePageBlock();
        self.closePageBlock = nil;
    }
}
@end
