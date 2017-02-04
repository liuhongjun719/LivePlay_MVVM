//
//  HJGiftCollectionViewHorizontalLayout.h
//  LivePlay
//
//  Created by 123456 on 16/12/13.
//  Copyright © 2016年 123456. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJGiftCollectionViewHorizontalLayout : UICollectionViewFlowLayout
// 一行中 cell的个数
@property (nonatomic) NSUInteger itemCountPerRow;
// 一页显示多少行
@property (nonatomic) NSUInteger rowCount;
@end
