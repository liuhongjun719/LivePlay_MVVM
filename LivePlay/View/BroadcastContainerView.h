//
//  BroadcastContainerView.h
//  LivePlay
//
//  Created by 123456 on 16/12/9.
//  Copyright © 2016年 123456. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelItem.h"


@protocol BroadcastContainerViewDelegate <NSObject>

- (void)didSelectItem:(ModelItem *)modelItem;
- (void)pageHeaderDidPull;
- (void)refreshPageAgain;

@end

@interface BroadcastContainerView : UIView
@property (nonatomic, weak) id<BroadcastContainerViewDelegate> delegate;
@property (nonatomic, strong) ResponseObject *object;
- (void)endRefreshing;
@end
