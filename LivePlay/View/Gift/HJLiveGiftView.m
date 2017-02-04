//
//  HJLiveGiftView.m
//  LivePlay
//
//  Created by 123456 on 16/12/13.
//  Copyright © 2016年 123456. All rights reserved.
//

#import "HJLiveGiftView.h"
#import "HJGiftContainerView.h"

@interface HJLiveGiftView ()
@property (nonatomic, strong) UILabel *balance;
@property (nonatomic, strong) UIButton *recharge;
@property (nonatomic, strong) HJGiftContainerView *giftContainerView;
@property (nonatomic, strong) UIButton *transparentBack;
@property (nonatomic, strong) UIView *bottomBackView;
@property (nonatomic, strong) UIView *sepratorLine;

@end

@implementation HJLiveGiftView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.alpha = 0;
        [self addSubview:self.bottomBackView];
        [self.bottomBackView addSubview:self.giftContainerView];
        [self addSubview:self.transparentBack];
        
        [self.bottomBackView addSubview:self.balance];
        [self.bottomBackView addSubview:self.recharge];
        [self.bottomBackView addSubview:self.sepratorLine];
    }
    return self;
}
//- (HJGiftContainerView *)giftContainerView {
//    if (!_giftContainerView) {
//        _giftContainerView = [[HJGiftContainerView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width,  (self.frame.size.width)/2)];
//
//    }
//    return _giftContainerView;
//}
- (HJGiftContainerView *)giftContainerView {
    if (!_giftContainerView) {
        _giftContainerView = [[HJGiftContainerView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width,  (self.frame.size.width)/2)];
        
    }
    return _giftContainerView;
}

- (UIButton *)transparentBack {
    if (!_transparentBack) {
        _transparentBack = [UIButton buttonWithType:UIButtonTypeCustom];
        _transparentBack.backgroundColor = [UIColor clearColor];
        _transparentBack.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height-self.bottomBackView.frame.size.height);
        [_transparentBack addTarget:self action:@selector(controlGiftList) forControlEvents:UIControlEventTouchUpInside];
    }
    return _transparentBack;
}

//- (UIButton *)transparentBack {
//    if (!_transparentBack) {
//        _transparentBack = [UIButton buttonWithType:UIButtonTypeCustom];
//        _transparentBack.backgroundColor = [UIColor clearColor];
//        _transparentBack.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height-self.giftContainerView.frame.size.height);
//        [_transparentBack addTarget:self action:@selector(controlGiftList) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _transparentBack;
//}


//包含giftContainerView balance recharge
- (UIView *)bottomBackView {
    if (!_bottomBackView) {
        _bottomBackView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width,  (self.frame.size.width)/2+40)];
        UIColor *color = [UIColor blackColor];
        color = [color colorWithAlphaComponent:0.6];
        _bottomBackView.backgroundColor = color;
    }
    return _bottomBackView;
}

#pragma mark- Show or hide
- (void)controlGiftList {
    CGRect frame = CGRectZero;
    if (self.bottomBackView.frame.origin.y == self.frame.size.height) {//To show
        frame = CGRectMake(0, self.frame.size.height-((self.frame.size.width)/2+40), self.frame.size.width,  (self.frame.size.width)/2+40);
        self.transparentBack.hidden = NO;
        self.alpha = 1;
        [UIView animateWithDuration:0.25 animations:^{
            self.bottomBackView.frame = frame;
        } completion:^(BOOL finished) {
            if (_hideGiftDidClicked) {
                _hideGiftDidClicked(YES);
            }
        }];
    }else {//To hide
        frame = CGRectMake(0, self.frame.size.height, self.frame.size.width,  (self.frame.size.width)/2+40);
        self.transparentBack.hidden = YES;
        [UIView animateWithDuration:0.25 animations:^{
            self.bottomBackView.frame = frame;
        } completion:^(BOOL finished) {
            self.alpha = 0;
            if (_hideGiftDidClicked) {
                _hideGiftDidClicked(NO);
            }
        }];
    }
}

//- (void)controlGiftList {
//    CGRect frame = CGRectZero;
//    if (self.giftContainerView.frame.origin.y == self.frame.size.height) {//To show
//        frame = CGRectMake(0, self.frame.size.height-(self.frame.size.width)/2, self.frame.size.width,  (self.frame.size.width)/2);
//        self.transparentBack.hidden = NO;
//        self.alpha = 1;
//        [UIView animateWithDuration:0.25 animations:^{
//            self.giftContainerView.frame = frame;
//        } completion:^(BOOL finished) {
//            if (_hideGiftDidClicked) {
//                _hideGiftDidClicked(YES);
//            }
//        }];
//    }else {//To hide
//        frame = CGRectMake(0, self.frame.size.height, self.frame.size.width,  (self.frame.size.width)/2);
//        self.transparentBack.hidden = YES;
//        [UIView animateWithDuration:0.25 animations:^{
//            self.giftContainerView.frame = frame;
//        } completion:^(BOOL finished) {
//            self.alpha = 0;
//            if (_hideGiftDidClicked) {
//                _hideGiftDidClicked(NO);
//            }
//        }];
//    }
//
//}



- (UILabel *)balance {
    if (!_balance) {
        _balance = [[UILabel alloc] initWithFrame:CGRectMake(5, self.giftContainerView.frame.size.height, 150, 40)];
        _balance.font = [UIFont systemFontOfSize:14];
        _balance.attributedText = [NSString getAttributeString:@"充值：1000" range1:NSMakeRange(0, 3)];
    }
    return _balance;
}

- (UIButton *)recharge {
    if (!_recharge) {
        _recharge = [UIButton buttonWithType:UIButtonTypeCustom];
        _recharge.frame = CGRectMake(self.frame.size.width-80, self.giftContainerView.frame.size.height, 80, 40);
        _recharge.titleLabel.font = [UIFont systemFontOfSize:14];
        [_recharge setTitle:@"充值" forState:UIControlStateNormal];
        [_recharge setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _recharge.backgroundColor = [UIColor yellowColor];
    }
    return _recharge;
}
- (UIView *)sepratorLine {
    if (!_sepratorLine) {
        _sepratorLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.giftContainerView.frame.size.height-1, self.frame.size.width, 1)];
        _sepratorLine.backgroundColor = [UIColor lightGrayColor];
    }
    return _sepratorLine;
}

- (void)setGiftArray:(NSMutableArray *)giftArray {
    _giftArray = giftArray;
    self.giftContainerView.giftArray = _giftArray;
}

@end
