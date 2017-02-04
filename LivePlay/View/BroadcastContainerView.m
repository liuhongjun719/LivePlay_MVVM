//
//  BroadcastContainerView.m
//  LivePlay
//
//  Created by 123456 on 16/12/9.
//  Copyright © 2016年 123456. All rights reserved.
//

#import "BroadcastContainerView.h"
#import "BroadcastBannerCell.h"
#import "PlatformRecommendCell.h"
#import "FavouriteCell.h"
#import "NewbieRecommendCell.h"
#import <MJExtension.h>
#import "DirectSectionCollectionReusableView.h"
#import <MJRefresh.h>
#import "HJRefreshPageHeader.h"
#import "BigImageCell.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface BroadcastContainerView ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;


@end

@implementation BroadcastContainerView

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
        self.collectionView.emptyDataSetSource = self;
        self.collectionView.emptyDataSetDelegate = self;


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
    return 4;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.object) {
        if (section == 0) {
            NSArray *arr = self.object.bar;
            if (arr.count == 0) {
                return 0;
            }
            return 1;
        }else if (section == 1){
            return 1;
        }else if (section == 2) {
            ModelItem *item = self.object.list[1];
            return item.livelist.count;
        }else {
            ModelItem *item = self.object.list[2];
            return item.livelist.count;
        }
    }else {
        return 0;
    }

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *identifier = @"BroadcastBannerCell";
        BroadcastBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        cell.modelArray = self.object.bar;
        return cell;
    }else if (indexPath.section == 1) {
        static NSString *identifier = @"PlatformRecommendCell";
        PlatformRecommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        ModelItem *item = self.object.list[0];
        cell.modelArray = item.livelist;
        return cell;
    }else if (indexPath.section == 2) {
        static NSString *identifier = @"FavouriteCell";
        FavouriteCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        ModelItem *item = self.object.list[1];
        ModelItem *subItem = [ModelItem mj_objectWithKeyValues:item.livelist[indexPath.row]];
        cell.modelItem = subItem;
        return cell;
    }else {
        static NSString *identifier = @"NewbieRecommendCell";
        NewbieRecommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        ModelItem *item = self.object.list[2];
        ModelItem *subItem = [ModelItem mj_objectWithKeyValues:item.livelist[indexPath.row]];
        cell.modelItem = subItem;
        return cell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(collectionView.bounds.size.width, 150);
    }else if (indexPath.section == 1) {
        return CGSizeMake(collectionView.bounds.size.width, 250);
    }else if (indexPath.section == 2) {
        return CGSizeMake((collectionView.bounds.size.width-5)/2, (collectionView.bounds.size.width-5)/2);
    }
    else {
        return CGSizeMake((collectionView.bounds.size.width-10)/3, (collectionView.bounds.size.width-10)/3);
    }
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
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section > 0) {
        return CGSizeMake(self.frame.size.width, 40);
    }
    return CGSizeZero;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
    if (indexPath.section > 0) {
        if (kind == UICollectionElementKindSectionHeader){
            DirectSectionCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"DirectSectionCollectionReusableView" forIndexPath:indexPath];
            if (indexPath.section == 1) {
                headerView.title.text = @"平台推荐";
            }else if (indexPath.section == 2) {
                headerView.title.text = @"热门红人";
            }
            else {
                headerView.title.text = @"新人推荐";
            }
            //点击指示箭头跳转界面
            headerView.directionImageDidClicked = ^() {
                if (indexPath.section == 1) {//Swith to 热门
                    [[NSNotificationCenter defaultCenter] postNotificationName:kSwitchToHotPage object:nil];
                }else if (indexPath.section == 3) {//Swithc to 关注
                    [[NSNotificationCenter defaultCenter] postNotificationName:kSwitchToAttentionPage object:nil];
                }
            };
            
            reusableview = headerView;
            
        }
    }
    return reusableview;
}

#pragma mark - data
- (void)setObject:(ResponseObject *)object {
    _object = object;
    [self.collectionView reloadData];
}

#pragma mark- DZNEmptyDataSetSource
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0f]};
    
    return [[NSAttributedString alloc] initWithString:@"刷新" attributes:attributes];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"~数据加载失败~";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor whiteColor];
}
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView
{
    return 20.0f;
}


//- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView
//{
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.userInteractionEnabled = YES;
//    button.frame = CGRectMake(0, 0, 80, 40);
//    [button setTitle:@"点击刷新" forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    button.titleLabel.font = [UIFont systemFontOfSize:14];
//    button.backgroundColor = [UIColor yellowColor];
//    [button addTarget:self action:@selector(reloadPage) forControlEvents:UIControlEventTouchUpInside];
//    return button;
//}

#pragma mark- DZNEmptyDataSetDelegate
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return YES;
}
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(refreshPageAgain)]) {
        [self.delegate refreshPageAgain];
    }

}


//- (void)reloadPage {
//    if ([self.delegate respondsToSelector:@selector(refreshPageAgain)]) {
//        [self.delegate refreshPageAgain];
//    }
//    [self.collectionView reloadData];
//}

@end
