//
//  BroadcastContainerViewController.m
//  LivePlay
//
//  Created by 123456 on 16/12/7.
//  Copyright © 2016年 123456. All rights reserved.
//

#import "BroadcastContainerViewController.h"
#import "BroadcastPageViewController.h"
#import <Masonry.h>
#import "BigImageViewController.h"
#import "ColumnFlowViewController.h"

@interface BroadcastContainerViewController () {
    NSArray *topMenuList;
}

@end

@implementation BroadcastContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"辣椒直播";
    self.view.backgroundColor = [UIColor whiteColor];
    topMenuList = @[@"推荐", @"热门", @"才艺", @"关注", @"新人", @"附近"];
    [self addMagicView];
    [self setHeaderView];
//    [self addLeftItem];
//    [self addRightItem];
    [self.magicView reloadData];
    [self.magicView switchToPage:0 animated:YES];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(switchToHotPage) name:kSwitchToHotPage object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(switchToAttentionPage) name:kSwitchToAttentionPage object:nil];



    
}
- (void)switchToHotPage {
    [self.magicView switchToPage:1 animated:YES];
}
- (void)switchToAttentionPage {
    [self.magicView switchToPage:3 animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)setHeaderView {
    UILabel *title = [[UILabel alloc] init];
    title.text = @"辣椒直播";
    title.textColor = RGBCOLOR(41, 41, 41);
    title.font = [UIFont systemFontOfSize:16];
    title.textAlignment = NSTextAlignmentCenter;
    [self.magicView.headerView addSubview:title];
    
    UIButton *search = [UIButton buttonWithType:UIButtonTypeCustom];
    [search setBackgroundImage:[UIImage imageNamed:@"搜索按钮"] forState:UIControlStateNormal];
    [search addTarget:self action:@selector(searchUser) forControlEvents:UIControlEventTouchUpInside];
    [self.magicView.headerView addSubview:search];
    
    
    UIView *sepratorLine = [[UIView alloc] init];
    sepratorLine.backgroundColor = RGBCOLOR(186, 192, 198);
    [self.magicView.headerView addSubview:sepratorLine];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
        make.center.equalTo(title.superview);
    }];
    
    [search mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(30);
        make.right.equalTo(search.superview).offset(-5);
        make.centerY.equalTo(search.superview);
    }];
    
    [sepratorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.left.right.equalTo(sepratorLine.superview);
        make.bottom.equalTo(sepratorLine.superview);
    }];

}
- (void)searchUser {

}
- (void)addMagicView {
    self.magicView.itemScale = 1.0;
    self.magicView.headerHeight = 40;
    self.magicView.navigationHeight = 40;
    self.magicView.againstStatusBar = YES;

//    self.magicView.headerView.backgroundColor = RGBCOLOR(243, 40, 47);
    self.magicView.navigationColor = [UIColor whiteColor];
    self.magicView.switchStyle = VTSwitchStyleDefault;
    self.magicView.layoutStyle = VTLayoutStyleDivide;
    self.magicView.sliderColor = RGBCOLOR(41, 41, 41);
    self.magicView.sliderWidth = 50;
    [self.magicView setHeaderHidden:NO duration:0];
}

- (void)addLeftItem {
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [leftButton addTarget:self action:@selector(showHistoryPage) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setTitleColor:RGBACOLOR(169, 37, 37, 0.6) forState:UIControlStateSelected];
    [leftButton setTitleColor:RGBCOLOR(169, 37, 37) forState:UIControlStateNormal];
    [leftButton setTitle:@"+" forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont boldSystemFontOfSize:28];
    leftButton.center = self.view.center;
    self.magicView.leftNavigatoinItem = leftButton;
}
- (void)addRightItem {
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [rightButton addTarget:self action:@selector(showSearchPage) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitleColor:RGBACOLOR(169, 37, 37, 0.6) forState:UIControlStateSelected];
    [rightButton setTitleColor:RGBCOLOR(169, 37, 37) forState:UIControlStateNormal];
    [rightButton setTitle:@"+" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:28];
    rightButton.center = self.view.center;
    self.magicView.rightNavigatoinItem = rightButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- Action
- (void)showHistoryPage {
    
}
- (void)showSearchPage {
    
}

#pragma mark - VTMagicViewDataSource
- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView
{
    return topMenuList;
}

- (UIButton *)magicView:(VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex
{
//    NSString *itemIdentifier = [NSString stringWithFormat:@"itemIdentifier%lu", (unsigned long)itemIndex];
    NSString *itemIdentifier = @"itemIdentifier";

    UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    if (!menuItem) {
        menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [menuItem setTitleColor:RGBCOLOR(41, 41, 41) forState:UIControlStateSelected];
        [menuItem setTitleColor:RGBCOLOR(118, 118, 118) forState:UIControlStateNormal];
        menuItem.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13.f];
    }
    return menuItem;
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex
{
//    NSString *recomId = [NSString stringWithFormat:@"recom.identifier%lu", (unsigned long)pageIndex];

    
    if (pageIndex == 0) {
        NSString *recomId = @"recom.identifier";
        BroadcastPageViewController *broadcastPageViewController = [magicView dequeueReusablePageWithIdentifier:recomId];
        if (!broadcastPageViewController) {
            broadcastPageViewController = [[BroadcastPageViewController alloc] init];
        }
        broadcastPageViewController.scrollType = pageIndex;
        return broadcastPageViewController;
    }else if (pageIndex>0 && pageIndex<4) {
        NSString *recomId = @"bigImage.identifier";
        BigImageViewController *bigImageViewController = [magicView dequeueReusablePageWithIdentifier:recomId];
        if (!bigImageViewController) {
            bigImageViewController = [[BigImageViewController alloc] init];
            bigImageViewController.scrollType = pageIndex;
        }
        
        //    NSLog(@"pageIndex-------:%lu", (unsigned long)pageIndex);
        return bigImageViewController;
    }else if(pageIndex >= 4){
        NSString *recomId = @"column.identifier";
        ColumnFlowViewController *columnFlowViewController = [magicView dequeueReusablePageWithIdentifier:recomId];
        if (!columnFlowViewController) {
            columnFlowViewController = [[ColumnFlowViewController alloc] init];
            columnFlowViewController.scrollType = pageIndex;
        }
        
        return columnFlowViewController;
    }

    return nil;
    
}

#pragma mark - VTMagicViewDelegate
- (void)magicView:(VTMagicView *)magicView viewDidAppeare:(UIViewController *)viewController atPage:(NSUInteger)pageIndex
{
    //    NSLog(@"index:%ld viewDidAppeare:%@", (long)pageIndex, viewController.view);
}

- (void)magicView:(VTMagicView *)magicView viewDidDisappeare:(UIViewController *)viewController atPage:(NSUInteger)pageIndex
{
    //    NSLog(@"index:%ld viewDidDisappeare:%@", (long)pageIndex, viewController.view);
}

- (void)magicView:(VTMagicView *)magicView didSelectItemAtIndex:(NSUInteger)itemIndex
{
    //    NSLog(@"didSelectItemAtIndex:%ld", (long)itemIndex);
}



@end
