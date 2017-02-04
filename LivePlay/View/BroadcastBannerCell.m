//
//  BroadcastBannerCell.m
//  LivePlay
//
//  Created by 123456 on 16/12/9.
//  Copyright © 2016年 123456. All rights reserved.
//

#import "BroadcastBannerCell.h"


#import "HJFocusView.h"
#import <Masonry.h>

@interface BroadcastBannerCell ()
@property (nonatomic, strong) HJFocusView *focusView;

@end


@implementation BroadcastBannerCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor yellowColor];
        [self addSubview:self.focusView];
        [self.focusView addTimer];
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
    _modelArray = modelArray;
    self.focusView.imageNames = _modelArray;
    NSLog(@"dddddddyyyyyyyyyy----:%lu", (unsigned long)_modelArray.count);

    
}

@end
