//
//  DirectSectionCollectionReusableView.h
//  LivePlay
//
//  Created by 123456 on 16/12/16.
//  Copyright © 2016年 123456. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DirectionImageDidClicked)();
@interface DirectSectionCollectionReusableView : UICollectionReusableView
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIImageView *directImageView;
@property (nonatomic, strong) UIButton *sectionButton;
@property (nonatomic, strong) DirectionImageDidClicked directionImageDidClicked;
@end
