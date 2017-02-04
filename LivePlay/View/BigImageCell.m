//
//  BigImageCell.m
//  LivePlay
//
//  Created by 123456 on 16/12/19.
//  Copyright © 2016年 123456. All rights reserved.
//

#import "BigImageCell.h"
#import "ModelItem.h"

@interface BigImageCell ()
@property (weak, nonatomic) IBOutlet UIView *topBackView;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *nickname;
@property (weak, nonatomic) IBOutlet UILabel *province;
@property (weak, nonatomic) IBOutlet UILabel *users;
@property (weak, nonatomic) IBOutlet UIImageView *usersImage;
@property (weak, nonatomic) IBOutlet UIImageView *picture;

@end
@implementation BigImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.topBackView.backgroundColor = [UIColor whiteColor];
    self.usersImage.image = [UIImage imageNamed:@"观看人数图标"];
    self.avatar.layer.cornerRadius = self.avatar.frame.size.width/2;
    self.avatar.layer.masksToBounds = YES;
}

- (void)setModelItem:(ModelItem *)modelItem {
    _modelItem = modelItem;
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:_modelItem.user.avatar]];
    [self.picture sd_setImageWithURL:[NSURL URLWithString:_modelItem.cover]];

    self.province.text = modelItem.user.province;
    self.users.text = [NSString stringWithFormat:@"%ld", (long)modelItem.users];

    self.nickname.text = modelItem.user.nickname;
    
}

@end
