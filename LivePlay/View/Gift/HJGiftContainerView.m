//
//  HJGiftContainerView.m
//  LivePlay
//
//  Created by 123456 on 16/12/13.
//  Copyright © 2016年 123456. All rights reserved.
//

#import "HJGiftContainerView.h"
#import "HJGiftCollectionViewHorizontalLayout.h"
#import "GiftCollectionViewCell.h"

@interface HJGiftContainerView ()
<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation HJGiftContainerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        UIColor *color = [UIColor blackColor];
//        color = [color colorWithAlphaComponent:0.4];
//        self.backgroundColor = color;
//        
        
        [self addSubview:self.collectionView];
        [self.collectionView registerClass:[GiftCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([GiftCollectionViewCell class])];
    }
    return self;
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:[self getFlowLayout]];
        _collectionView.backgroundColor = [UIColor clearColor];
        //        _collectionView.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
        _collectionView.bounces = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
    }
    return _collectionView;
}
- (HJGiftCollectionViewHorizontalLayout *)getFlowLayout {
    HJGiftCollectionViewHorizontalLayout *flowLayout = [[HJGiftCollectionViewHorizontalLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 1;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsZero;
    flowLayout.rowCount = 2;
    flowLayout.itemCountPerRow = 4;
    return flowLayout;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeZero;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}
#pragma mark- UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.giftArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"GiftCollectionViewCell";
    GiftCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.modelItem = self.giftArray[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return CGSizeMake((self.frame.size.width)/4, (self.frame.size.width)/4);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {    
}

#pragma mark - Data
- (void)setGiftArray:(NSMutableArray *)giftArray {
    _giftArray = giftArray;
    [self.collectionView reloadData];
}
@end
