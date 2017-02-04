//
//  RoomViewwerContainerView.m
//  LivePlay
//
//  Created by 123456 on 16/12/12.
//  Copyright © 2016年 123456. All rights reserved.
//

#import "RoomViewwerContainerView.h"
#import <MJExtension.h>
#import "RoomViewwerCell.h"


@interface RoomViewwerContainerView ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation RoomViewwerContainerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.collectionView];
        [self.collectionView registerClass:[RoomViewwerCell class] forCellWithReuseIdentifier:NSStringFromClass([RoomViewwerCell class])];
    }
    return self;
}



- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:[self getFlowLayout]];
        _collectionView.backgroundColor = [UIColor clearColor];
        //        _collectionView.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = NO;
    }
    return _collectionView;
}
- (UICollectionViewFlowLayout *)getFlowLayout {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 5;
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.sectionInset = UIEdgeInsetsZero;
    return flowLayout;
}

#pragma mark- UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.modelArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"RoomViewwerCell";
    RoomViewwerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.modelItem = _modelArray[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{

    return CGSizeMake(30, 30);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 2) {
//        ModelItem *item = _modelArray[1][1];
//        ModelItem *subItem = [ModelItem mj_objectWithKeyValues:item.livelist[indexPath.row]];
//        if ([self.delegate respondsToSelector:@selector(didSelectItem:)]) {
//            [self.delegate didSelectItem: subItem];
//        }
//    }else if (indexPath.section == 3) {
//        ModelItem *item = _modelArray[1][2];
//        ModelItem *subItem = [ModelItem mj_objectWithKeyValues:item.livelist[indexPath.row]];
//        if ([self.delegate respondsToSelector:@selector(didSelectItem:)]) {
//            [self.delegate didSelectItem: subItem];
//        }
//    }
    
    
    if ([self.delegate respondsToSelector:@selector(didSelectItemWithItem:)]) {
        [self.delegate didSelectItemWithItem: self.modelArray[indexPath.row]];
    }

}

#pragma mark - data
- (void)setModelArray:(NSMutableArray *)modelArray {
    _modelArray = modelArray;

    [self.collectionView reloadData];
    

}


@end
