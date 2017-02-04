//
//  WaterflowLayout.h
//  自定义瀑布流框架
//
//  Created by    🐯 on 16/2/13.
//  Copyright © 2016年 张炫赫. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WaterflowLayout;
@protocol XMGWaterflowLayoutDelegate <NSObject>
@required
- (CGFloat)waterflowLayout:(WaterflowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth;

@optional
- (CGFloat)columnCountInWaterflowLayout:(WaterflowLayout *)waterflowLayout;
- (CGFloat)columnMarginInWaterflowLayout:(WaterflowLayout *)waterflowLayout;
- (CGFloat)rowMarginInWaterflowLayout:(WaterflowLayout *)waterflowLayout;
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(WaterflowLayout *)waterflowLayout;
@end
@interface WaterflowLayout : UICollectionViewLayout
/** 代理 */
@property (nonatomic, weak) id<XMGWaterflowLayoutDelegate> delegate;

@end
