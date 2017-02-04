//
//  TopInfoView.m
//  LivePlay
//
//  Created by 123456 on 16/12/14.
//  Copyright © 2016年 123456. All rights reserved.
//

#import "TopInfoView.h"
#import "ModelItem.h"

@implementation TopInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {

    }
    return self;
}

+(TopInfoView *)instanceTopInfoView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"TopInfoView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}
- (void)setupElement {
    //you init
    UIColor *color = [UIColor blackColor];
    color = [color colorWithAlphaComponent:0.6];
    self.backgroundColor = color;
    
    self.avatar.adjustsImageWhenHighlighted = NO;
    self.avatar.layer.cornerRadius = self.avatar.frame.size.width/2;
    self.avatar.layer.masksToBounds = YES;
    
    self.live_uid.textColor = [UIColor whiteColor];
    self.nickname.textColor = [UIColor whiteColor];
    
    self.vip_image.adjustsImageWhenHighlighted = NO;
    self.vip_image.layer.cornerRadius = self.vip_image.frame.size.width/2;
    self.vip_image.layer.masksToBounds = YES;
    

    self.followButton.adjustsImageWhenHighlighted = NO;
    self.followButton.layer.cornerRadius = 4;
    self.followButton.layer.masksToBounds = YES;
    self.followButton.backgroundColor = RGBColor(223, 194, 49);
    [self.followButton setTitleColor:RGBColor(40, 36, 13) forState:UIControlStateNormal];
}

- (void)setModelItem:(ModelItem *)modelItem {
    [self setupElement];
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", modelItem.user.avatar]] forState:UIControlStateNormal];
    self.live_uid.text = [NSString stringWithFormat:@"%ld", (long)modelItem.live_uid];
    self.nickname.text = [NSString stringWithFormat:@"%@", modelItem.user.nickname];
    [self.vip_image sd_setImageWithURL:[NSURL URLWithString:modelItem.user.grade.vip_image] forState:UIControlStateNormal];
    
    self.follow.attributedText = [NSString getAttributeString:self.follow.text range1:NSMakeRange(0, 3)];
    self.fans.attributedText = [NSString getAttributeString:self.fans.text range1:NSMakeRange(0, 3)];
    self.rich.attributedText = [NSString getAttributeString:self.rich.text range1:NSMakeRange(0, 4)];
    self.glamour.attributedText = [NSString getAttributeString:self.glamour.text range1:NSMakeRange(0, 4)];

}

@end
