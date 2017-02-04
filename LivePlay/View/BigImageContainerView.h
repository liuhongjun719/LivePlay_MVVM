//
//  BigImageContainerView.h
//  LivePlay
//
//  Created by 123456 on 16/12/19.
//  Copyright © 2016年 123456. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "ModelItem.h"


@protocol BigImageContainerViewDelegate <NSObject>

- (void)didSelectItem:(ModelItem *)modelItem;
- (void)pageHeaderDidPull;

@end

@interface BigImageContainerView : UIView
@property (nonatomic, weak) id<BigImageContainerViewDelegate> delegate;
@property (nonatomic, strong) ResponseObject *object;
- (void)endRefreshing;
@end
