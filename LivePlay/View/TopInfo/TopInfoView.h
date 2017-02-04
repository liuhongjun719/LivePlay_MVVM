//
//  TopInfoView.h
//  LivePlay
//
//  Created by 123456 on 16/12/14.
//  Copyright © 2016年 123456. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ModelItem;

@interface TopInfoView : UIView

@property (weak, nonatomic) IBOutlet UIButton *privateChat;

@property (weak, nonatomic) IBOutlet UIButton *avatar;
@property (weak, nonatomic) IBOutlet UIButton *vip_image;

@property (weak, nonatomic) IBOutlet UILabel *nickname;
@property (weak, nonatomic) IBOutlet UILabel *follow;

@property (weak, nonatomic) IBOutlet UILabel *fans;
@property (weak, nonatomic) IBOutlet UILabel *rich;
@property (weak, nonatomic) IBOutlet UILabel *glamour;
@property (weak, nonatomic) IBOutlet UIButton *followButton;
@property (weak, nonatomic) IBOutlet UILabel *live_uid;

@property (nonatomic, strong) ModelItem *modelItem;



+(TopInfoView *)instanceTopInfoView;

@end
