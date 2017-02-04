//
//  ColumnContainerView.h
//  LivePlay
//
//  Created by 123456 on 16/12/20.
//  Copyright © 2016年 123456. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelItem.h"


@protocol ColumnContainerViewDelegate <NSObject>

- (void)didSelectItem:(ModelItem *)modelItem;
- (void)pageHeaderDidPull;

@end

@interface ColumnContainerView : UIView
@property (nonatomic, weak) id<ColumnContainerViewDelegate> delegate;
@property (nonatomic, strong) ResponseObject *object;
- (void)endRefreshing;
@end
