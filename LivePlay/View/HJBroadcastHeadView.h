//
//  HJBroadcastHeadView.h
//  LivePlay
//
//  Created by 123456 on 16/12/9.
//  Copyright © 2016年 123456. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ClosePageBlock)();
@interface HJBroadcastHeadView : UIView

@property (nonatomic, strong) ClosePageBlock closePageBlock;


@end
