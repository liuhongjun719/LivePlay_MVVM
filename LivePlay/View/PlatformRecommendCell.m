//
//  PlatformRecommendCell.m
//  LivePlay
//
//  Created by 123456 on 16/12/9.
//  Copyright © 2016年 123456. All rights reserved.
//

#import "PlatformRecommendCell.h"
#import "HomeRecommendItemView.h"
#import <Masonry.h>
#import "ModelItem.h"
#import <MJExtension.h>

@interface PlatformRecommendCell ()
@property (nonatomic, strong) HomeRecommendItemView *leftImage;
@property (nonatomic, strong) HomeRecommendItemView *rightTopImage;
@property (nonatomic, strong) HomeRecommendItemView *rightBottomImage;

@end


@implementation PlatformRecommendCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.leftImage];
        [self addSubview:self.rightTopImage];
        [self addSubview:self.rightBottomImage];

        [self.leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(self);
            make.width.equalTo(self).multipliedBy(0.6);
        }];
        
        [self.rightTopImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.leftImage);
            make.right.equalTo(self);
            make.left.equalTo(self.leftImage.mas_right).offset(5);
            make.height.mas_equalTo((self.frame.size.height-5)/2);
        }];
        
        [self.rightBottomImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.rightTopImage.mas_bottom).offset(5);
            make.right.equalTo(self.rightTopImage);
            make.left.equalTo(self.rightTopImage);
            make.bottom.equalTo(self.leftImage);
        }];

        
        [self layoutIfNeeded];
        
    }
    return self;
}
//
- (HomeRecommendItemView *)leftImage {
    if (!_leftImage) {
        _leftImage = [[HomeRecommendItemView alloc] init];
    }
    return _leftImage;
}

- (HomeRecommendItemView *)rightTopImage {
    if (!_rightTopImage) {
        _rightTopImage = [[HomeRecommendItemView alloc] init];
    }
    return _rightTopImage;
}

- (HomeRecommendItemView *)rightBottomImage {
    if (!_rightBottomImage) {
        _rightBottomImage = [[HomeRecommendItemView alloc] init];
    }
    return _rightBottomImage;
}
- (void)setModelArray:(NSMutableArray *)modelArray {
    _modelArray = modelArray;

    self.leftImage.modelItem = [ModelItem mj_objectWithKeyValues:_modelArray[0]];
    self.rightTopImage.modelItem = [ModelItem mj_objectWithKeyValues:_modelArray[1]];
    self.rightBottomImage.modelItem = [ModelItem mj_objectWithKeyValues:_modelArray[2]];
}
@end
