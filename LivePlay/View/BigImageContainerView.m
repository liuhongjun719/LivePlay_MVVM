//
//  BigImageContainerView.m
//  LivePlay
//
//  Created by 123456 on 16/12/19.
//  Copyright © 2016年 123456. All rights reserved.
//

#import "BigImageContainerView.h"
#import "BroadcastBannerCell.h"
#import "PlatformRecommendCell.h"
#import "FavouriteCell.h"
#import "NewbieRecommendCell.h"
#import <MJExtension.h>
#import "DirectSectionCollectionReusableView.h"
#import <MJRefresh.h>
#import "HJRefreshPageHeader.h"
#import "BigImageCell.h"


@interface BigImageContainerView ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;


@end

@implementation BigImageContainerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //        self.scrollItemType = ScrollItemTypeHot;
        [self addSubview:self.collectionView];
        [self.collectionView registerClass:[BroadcastBannerCell class] forCellWithReuseIdentifier:NSStringFromClass([BroadcastBannerCell class])];
        [self.collectionView registerClass:[PlatformRecommendCell class] forCellWithReuseIdentifier:NSStringFromClass([PlatformRecommendCell class])];
        
        [self.collectionView registerClass:[FavouriteCell class] forCellWithReuseIdentifier:NSStringFromClass([FavouriteCell class])];
        [self.collectionView registerClass:[NewbieRecommendCell class] forCellWithReuseIdentifier:NSStringFromClass([NewbieRecommendCell class])];
        
        [self.collectionView registerClass:[DirectSectionCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"DirectSectionCollectionReusableView"];
        
        [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([BigImageCell class]) bundle:nil] forCellWithReuseIdentifier:@"BigImageCell"];
        
        [self addRefreshHeader];
    }
    return self;
}

- (void)addRefreshHeader {
    HJRefreshPageHeader *header = [HJRefreshPageHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    // 隐藏状态
    header.stateLabel.hidden = YES;
    self.collectionView.mj_header = header;
    
}

- (void)refreshData {
    if ([self.delegate respondsToSelector:@selector(pageHeaderDidPull)]) {
        [self.delegate pageHeaderDidPull];
    }
}

- (void)endRefreshing {
    if (self.collectionView.mj_header) {
        [self.collectionView.mj_header endRefreshing];
    }
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:[self getFlowLayout]];
        _collectionView.backgroundColor = [UIColor whiteColor];
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
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumLineSpacing = 5;
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.sectionInset = UIEdgeInsetsZero;
    return flowLayout;
}

#pragma mark- UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        NSArray *arr = self.object.bar;
        if (arr.count == 0) {
            return 0;
        }
        return 1;
    }else if (section == 1){
        ModelItem *item = self.object.info;
        NSArray *arrList = [ModelItem mj_objectArrayWithKeyValuesArray:item.livelist];
        return arrList.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *identifier = @"BroadcastBannerCell";
        BroadcastBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        cell.modelArray = self.object.bar;
        return cell;
    }else {
        static NSString *identifier = @"BigImageCell";
        BigImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        ModelItem *item = self.object.info;
        
        NSArray *arrList = [ModelItem mj_objectArrayWithKeyValuesArray:item.livelist];
        cell.modelItem = arrList[indexPath.row];
        return cell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(collectionView.bounds.size.width, 150);
    }else if (indexPath.section == 1) {
        return CGSizeMake(collectionView.bounds.size.width, 400);
    }
    return CGSizeZero;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        ModelItem *item = self.object.list[1];
        ModelItem *subItem = [ModelItem mj_objectWithKeyValues:item.livelist[indexPath.row]];
        if ([self.delegate respondsToSelector:@selector(didSelectItem:)]) {
            [self.delegate didSelectItem: subItem];
        }
    }else if (indexPath.section == 3) {
        ModelItem *item = self.object.list[2];
        ModelItem *subItem = [ModelItem mj_objectWithKeyValues:item.livelist[indexPath.row]];
        if ([self.delegate respondsToSelector:@selector(didSelectItem:)]) {
            [self.delegate didSelectItem: subItem];
        }
    }
    
}


#pragma mark - data
- (void)setObject:(ResponseObject *)object {
    _object = object;

    
    [self.collectionView reloadData];
    
}




@end
