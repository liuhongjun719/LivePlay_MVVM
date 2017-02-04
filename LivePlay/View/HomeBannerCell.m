//
//  HomeBannerCell.m
//  LivePlay
//
//  Created by 123456 on 16/12/7.
//  Copyright © 2016年 123456. All rights reserved.
//

#import "HomeBannerCell.h"
#import "HJFocusView.h"
#import <Masonry.h>

@interface HomeBannerCell ()
@property (nonatomic, strong) HJFocusView *focusView;

@end

@implementation HomeBannerCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor yellowColor];
        [self addSubview:self.focusView];
    }
    return self;
}
- (HJFocusView *)focusView {
    if (!_focusView) {
        _focusView = [[HJFocusView alloc] initWithFrame:self.bounds];
    }
    return _focusView;
}

- (void)setModelArray:(NSMutableArray *)modelArray {
    self.focusView.imageNames = _modelArray;

}



@end
