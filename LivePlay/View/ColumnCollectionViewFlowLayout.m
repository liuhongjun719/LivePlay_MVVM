//
//  ColumnCollectionViewFlowLayout.m
//  LivePlay
//
//  Created by 123456 on 16/12/20.
//  Copyright © 2016年 123456. All rights reserved.
//

#import "ColumnCollectionViewFlowLayout.h"

@interface ColumnCollectionViewFlowLayout ()

@end


@interface ColumnCollectionViewFlowLayout () {
    CGFloat _topHeight;
}
@end

@implementation ColumnCollectionViewFlowLayout

- (instancetype)initWithTopHeight:(CGFloat)topHeight {
    self = [super init];
    if (self) {
        _topHeight = topHeight;
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    
    _cellHeightArray   = [NSMutableArray array];
    _cellAttributeDict = [NSMutableDictionary dictionary];
    _delegate = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
    // 获取cell的个数
    _cellCount = [self.collectionView numberOfItemsInSection:0];
    if (_cellCount == 0) {
        return;
    }
    
    float top = _topHeight;
    for (NSInteger i = 0; i < 2; i++) {
        [_cellHeightArray addObject:@(top)];
    }
    // 调用layoutForItemAtIndexPath方法，为每个cell布局，
    for (NSInteger i = 0; i < _cellCount; i ++) {
        [self layoutItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:1]];
    }
}

- (void)layoutItemAtIndexPath:(NSIndexPath *)indexPath {
    // 通过协议获得cell的间隙
//    UIEdgeInsets edgeInsets = [self.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:indexPath.row];
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);

    // 通过协议获得cell的大小
    CGSize itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
    NSInteger column = 0;
    float shortHeight = [[_cellHeightArray objectAtIndex:column] floatValue];
    //找出高度最小的列，将cell加到最小列中
    for (int i = 0; i < _cellHeightArray.count; i++) {
        float height = [[_cellHeightArray objectAtIndex:i] floatValue];
        if (height < shortHeight) {
            shortHeight = height;
            column = i;
        }
    }
    float top = [[_cellHeightArray objectAtIndex:column] floatValue];
    //确定cell的frame
    CGRect frame = CGRectMake(edgeInsets.left + column * (edgeInsets.left + itemSize.width), top + edgeInsets.top, itemSize.width, itemSize.height);
    //更新列高
    [_cellHeightArray replaceObjectAtIndex:column withObject:[NSNumber numberWithFloat:top + edgeInsets.top + itemSize.height]];
    //每个cell的frame对应一个indexPath，放入字典中
    [_cellAttributeDict setObject:NSStringFromCGRect(frame) forKey:indexPath];
}

//返回cell的布局信息，如果忽略传入的rect一次性将所有的cell布局信息返回，图片过多时性能会很差
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *muArr = [NSMutableArray array];
    for (NSIndexPath *indexPath in _cellAttributeDict) {
        CGRect cellRect = CGRectFromString(_cellAttributeDict[indexPath]);
        if (CGRectIntersectsRect(cellRect, rect)) {
            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
            [muArr addObject:attributes];
        }
    }
    return muArr;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.frame = CGRectFromString(_cellAttributeDict[indexPath]);
    return attributes;
}

//最后还要实现这个方法，返回collectionView内容的大小
//只需要遍历前面创建的存放列高的数组得到列最高的一个作为高度返回就可以了
- (CGSize)collectionViewContentSize {
    CGSize size = self.collectionView.frame.size;
    float maxHeight = 0;
    // 查找最高的列的高度
    for (int i = 0; i < _cellHeightArray.count; i++) {
        float colHeight = [[_cellHeightArray objectAtIndex:i] floatValue];
        if (colHeight > maxHeight) {
            maxHeight = colHeight;
        }
    }
    size.height = maxHeight;
    return size;
}

@end

