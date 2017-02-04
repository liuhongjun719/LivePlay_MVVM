//
//  HJLiveGiftView.h
//  LivePlay
//
//  Created by 123456 on 16/12/13.
//  Copyright © 2016年 123456. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^HideGiftDidClicked)(BOOL);

@interface HJLiveGiftView : UIView
@property (nonatomic, strong) NSMutableArray *giftArray;
@property (nonatomic, strong) HideGiftDidClicked hideGiftDidClicked;

- (void)controlGiftList;
@end
