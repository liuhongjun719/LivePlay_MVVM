//
//  RoomViewwerContainerView.h
//  LivePlay
//
//  Created by 123456 on 16/12/12.
//  Copyright © 2016年 123456. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ModelItem;

@protocol RoomViewwerContainerViewDelegate <NSObject>

- (void)didSelectItemWithItem:(ModelItem *)modelItem;

@end

@interface RoomViewwerContainerView : UIView

@property (nonatomic, strong) NSMutableArray *modelArray;
@property (nonatomic, weak) id<RoomViewwerContainerViewDelegate> delegate;
@end
