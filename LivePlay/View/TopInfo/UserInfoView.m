//
//  UserInfoView.m
//  LivePlay
//
//  Created by 123456 on 16/12/14.
//  Copyright © 2016年 123456. All rights reserved.
//

#import "UserInfoView.h"
#import "TopInfoView.h"

@interface UserInfoView ()
@property (nonatomic, strong) TopInfoView *topInfoView;
@property (nonatomic, strong) UIButton *transparentBack;

@end
@implementation UserInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.alpha = 0;
        [self addSubview:self.topInfoView];
        [self addSubview:self.transparentBack];
    }
    return self;
}

- (TopInfoView *)topInfoView {
    if (!_topInfoView) {
        _topInfoView = [TopInfoView instanceTopInfoView];
        _topInfoView.frame = CGRectMake(0, -_topInfoView.frame.size.height, self.frame.size.width, _topInfoView.frame.size.height);
    }
    return _topInfoView;
}

- (UIButton *)transparentBack {
    if (!_transparentBack) {
        _transparentBack = [UIButton buttonWithType:UIButtonTypeCustom];
        _transparentBack.frame = CGRectMake(0, self.topInfoView.frame.size.height, self.frame.size.width, self.frame.size.height-self.topInfoView.frame.size.height);
        [_transparentBack addTarget:self action:@selector(controlInfoView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _transparentBack;
}
- (void)controlInfoView {
    [UIView animateWithDuration:0.25 animations:^{
        self.topInfoView.frame = CGRectMake(0, -_topInfoView.frame.size.height, self.frame.size.width, _topInfoView.frame.size.height);
    } completion:^(BOOL finished) {
        self.alpha = 0;
    }];
}

- (void)refreshInfoViewWithItem:(ModelItem *)modelItem {
//    CGRect frame = CGRectZero;

    if (self.topInfoView.frame.origin.y < 0) {//To show
        self.alpha = 1;
        //data
        self.topInfoView.modelItem = modelItem;
        [UIView animateWithDuration:0.25 animations:^{
            self.topInfoView.frame = CGRectMake(0, 0, self.frame.size.width, _topInfoView.frame.size.height);
        }];
    }else {//To hide

        [UIView animateWithDuration:0.25 animations:^{
            self.topInfoView.frame = CGRectMake(0, -_topInfoView.frame.size.height, self.frame.size.width, _topInfoView.frame.size.height);
        } completion:^(BOOL finished) {
            self.alpha = 0;
        }];
    }
}
//self.leftImage.modelItem = [ModelItem mj_objectWithKeyValues:_modelArray[0]];

@end
