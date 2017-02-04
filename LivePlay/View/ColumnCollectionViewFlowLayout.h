//
//  ColumnCollectionViewFlowLayout.h
//  LivePlay
//
//  Created by 123456 on 16/12/20.
//  Copyright © 2016年 123456. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColumnCollectionViewFlowLayout : UICollectionViewFlowLayout
@property (nonatomic, assign) id<UICollectionViewDelegateFlowLayout> delegate;
@property (nonatomic, assign) NSUInteger            cellCount;  // cell 的个数
@property (nonatomic, strong) NSMutableArray        *cellHeightArray;
@property (nonatomic, strong) NSMutableDictionary   *cellAttributeDict; // cell 的位置信息
/**
 *  @author Paul Wang, 16-03-10 20:03:19
 *
 *  @brief 构造方法，用于特殊高度的 headerView
 *
 *  @param topHeight 顶高度
 *
 *  @return
 */
- (instancetype)initWithTopHeight:(CGFloat)topHeight;

@end
