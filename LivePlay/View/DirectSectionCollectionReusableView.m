//
//  DirectSectionCollectionReusableView.m
//  LivePlay
//
//  Created by 123456 on 16/12/16.
//  Copyright © 2016年 123456. All rights reserved.
//

#import "DirectSectionCollectionReusableView.h"
#import <Masonry.h>

@implementation DirectSectionCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.title];
        [self addSubview:self.directImageView];
        [self addSubview:self.sectionButton];
        
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(80);
            make.height.equalTo(self);
            make.center.equalTo(self);
        }];
        
        [self.directImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.title.mas_right);
            make.width.height.mas_equalTo(15);
            make.centerY.equalTo(self);
        }];
        
        [self.sectionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.right.equalTo(self);
        }];
    }
    return self;
}


- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.font = [UIFont systemFontOfSize:14];
        _title.textColor = [UIColor blackColor];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.text = @"4093284903849";
    }
    return _title;
}

- (UIImageView *)directImageView {
    if (!_directImageView) {
        _directImageView = [[UIImageView alloc] init];
        _directImageView.image = [UIImage imageNamed:@"MeiArrow"];
    }
    return _directImageView;
}

- (UIButton *)sectionButton {
    if (!_sectionButton) {
        _sectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sectionButton addTarget:self action:@selector(clickSection:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sectionButton;
}

- (void)clickSection:(UIButton *)sender {
    if (self.directionImageDidClicked) {
        self.directionImageDidClicked();
    }
}
@end
