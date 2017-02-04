//
//  HJRefreshPageHeader.m
//  LivePlay
//
//  Created by 123456 on 16/12/16.
//  Copyright © 2016年 123456. All rights reserved.
//

#import "HJRefreshPageHeader.h"

@implementation HJRefreshPageHeader

#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
    
    // 设置普通状态的动画图片
    NSMutableArray *headerImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=2; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"恐龙%lu", (unsigned long)i]];
        [headerImages addObject:image];
    }
    [self setImages:headerImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）

    [self setImages:headerImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:headerImages forState:MJRefreshStateRefreshing];
}

@end
