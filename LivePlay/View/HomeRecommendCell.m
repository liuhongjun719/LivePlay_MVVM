//
//  HomeRecommendCell.m
//  LivePlay
//
//  Created by 123456 on 16/12/8.
//  Copyright © 2016年 123456. All rights reserved.
//

#import "HomeRecommendCell.h"
#import "HomeRecommendItemView.h"
#import <Masonry.h>
#import "ModelItem.h"
//#import <SDWebImage/UIImageView+WebCache.h>

@interface HomeRecommendCell ()
@property (nonatomic, strong) HomeRecommendItemView *topLeftImage;//左上

@property (nonatomic, strong) HomeRecommendItemView *topRightFirstImage;//右上1
@property (nonatomic, strong) HomeRecommendItemView *topRightSecondImage;//右上2

@property (nonatomic, strong) HomeRecommendItemView *bottomFirstRowFirstImage;//row 1 1
@property (nonatomic, strong) HomeRecommendItemView *bottomFirstRowSecondImage;//row 1 2
@property (nonatomic, strong) HomeRecommendItemView *bottomFirstRowThirdImage;//row 1 3

@property (nonatomic, strong) HomeRecommendItemView *bottomSecondRowFirstImage;//row 2 1
@property (nonatomic, strong) HomeRecommendItemView *bottomSecondRowSecondImage;//row 2 2
@property (nonatomic, strong) HomeRecommendItemView *bottomSecondRowThirdImage;//row 2 3



@end

@implementation HomeRecommendCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.topLeftImage];
        [self addSubview:self.topRightFirstImage];
        [self addSubview:self.topRightSecondImage];
        [self addSubview:self.bottomFirstRowFirstImage];
        [self addSubview:self.bottomFirstRowSecondImage];
        [self addSubview:self.bottomFirstRowThirdImage];
        [self addSubview:self.bottomSecondRowFirstImage];
        [self addSubview:self.bottomSecondRowSecondImage];
        [self addSubview:self.bottomSecondRowThirdImage];
        [self.topLeftImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.width.equalTo(@((self.frame.size.width-30)/3*2+5));
            make.height.equalTo(@((self.frame.size.height-20)/2));
            make.left.equalTo(self).offset(10);
        }];
        [self.topRightFirstImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.topLeftImage);
            make.left.equalTo(self.topLeftImage.mas_right).offset(5);
            make.right.equalTo(self).offset(-10);
            make.height.equalTo(@((self.frame.size.height-20)/4));
        }];

        [self.topRightSecondImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.topRightFirstImage.mas_bottom).offset(5);
            make.left.equalTo(self.topRightFirstImage);
            make.right.equalTo(self.topRightFirstImage);
            make.bottom.equalTo(self.topLeftImage.mas_bottom);
        }];
        
        //
        [self.bottomFirstRowFirstImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.topLeftImage.mas_bottom).offset(5);
            make.left.equalTo(self.topLeftImage);
            make.height.equalTo(@((self.frame.size.height-20)/4));
            make.width.equalTo(@((self.frame.size.width-30)/3));
        }];
        
        [self.bottomFirstRowSecondImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bottomFirstRowFirstImage);
            make.left.equalTo(self.bottomFirstRowFirstImage.mas_right).offset(5);
            make.bottom.equalTo(self.bottomFirstRowFirstImage);
            make.width.equalTo(@((self.frame.size.width-30)/3));
        }];
        
        [self.bottomFirstRowThirdImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bottomFirstRowFirstImage);
            make.left.equalTo(self.bottomFirstRowSecondImage.mas_right).offset(5);
            make.bottom.equalTo(self.bottomFirstRowFirstImage);
            make.right.equalTo(self.topRightFirstImage);
        }];
        
        //
        [self.bottomSecondRowFirstImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bottomFirstRowFirstImage.mas_bottom).offset(5);
            make.left.equalTo(self.topLeftImage);
            make.bottom.equalTo(self).offset(-10);
            make.width.equalTo(@((self.frame.size.width-30)/3));
        }];
        
        [self.bottomSecondRowSecondImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bottomSecondRowFirstImage);
            make.left.equalTo(self.bottomSecondRowFirstImage.mas_right).offset(5);
            make.bottom.equalTo(self.bottomSecondRowFirstImage);
            make.width.equalTo(@((self.frame.size.width-30)/3));
        }];
        
        [self.bottomSecondRowThirdImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bottomSecondRowFirstImage);
            make.left.equalTo(self.bottomSecondRowSecondImage.mas_right).offset(5);
            make.bottom.equalTo(self.bottomSecondRowFirstImage);
            make.width.equalTo(@((self.frame.size.width-30)/3));
            make.right.equalTo(self.topRightFirstImage);
        }];
        
        
        
        [self layoutIfNeeded];

    }
    return self;
}
//
- (HomeRecommendItemView *)topLeftImage {
    if (!_topLeftImage) {
        _topLeftImage = [[HomeRecommendItemView alloc] init];
//        _topLeftImage.backgroundColor = [UIColor redColor];
    }
    return _topLeftImage;
}

//
- (HomeRecommendItemView *)topRightFirstImage {
    if (!_topRightFirstImage) {
        _topRightFirstImage = [[HomeRecommendItemView alloc] init];
        _topRightFirstImage.backgroundColor = [UIColor yellowColor];
    }
    return _topRightFirstImage;
}

- (HomeRecommendItemView *)topRightSecondImage {
    if (!_topRightSecondImage) {
        _topRightSecondImage = [[HomeRecommendItemView alloc] init];
        _topRightSecondImage.backgroundColor = [UIColor greenColor];
    }
    return _topRightSecondImage;
}
//
- (HomeRecommendItemView *)bottomFirstRowFirstImage {
    if (!_bottomFirstRowFirstImage) {
        _bottomFirstRowFirstImage = [[HomeRecommendItemView alloc] init];
    }
    return _bottomFirstRowFirstImage;
}

- (HomeRecommendItemView *)bottomFirstRowSecondImage {
    if (!_bottomFirstRowSecondImage) {
        _bottomFirstRowSecondImage = [[HomeRecommendItemView alloc] init];
    }
    return _bottomFirstRowSecondImage;
}

- (HomeRecommendItemView *)bottomFirstRowThirdImage {
    if (!_bottomFirstRowThirdImage) {
        _bottomFirstRowThirdImage = [[HomeRecommendItemView alloc] init];
    }
    return _bottomFirstRowThirdImage;
}

//
- (HomeRecommendItemView *)bottomSecondRowFirstImage {
    if (!_bottomSecondRowFirstImage) {
        _bottomSecondRowFirstImage = [[HomeRecommendItemView alloc] init];
    }
    return _bottomSecondRowFirstImage;
}
- (HomeRecommendItemView *)bottomSecondRowSecondImage {
    if (!_bottomSecondRowSecondImage) {
        _bottomSecondRowSecondImage = [[HomeRecommendItemView alloc] init];
    }
    return _bottomSecondRowSecondImage;
}
- (HomeRecommendItemView *)bottomSecondRowThirdImage {
    if (!_bottomSecondRowThirdImage) {
        _bottomSecondRowThirdImage = [[HomeRecommendItemView alloc] init];
    }
    return _bottomSecondRowThirdImage;
}

- (void)setModelArray:(NSMutableArray *)modelArray {
    _modelArray = modelArray;
    self.topLeftImage.modelItem = _modelArray[0];
    self.topRightFirstImage.modelItem = _modelArray[1];
    self.topRightSecondImage.modelItem = _modelArray[2];
    
    self.bottomFirstRowFirstImage.modelItem = _modelArray[5];
    self.bottomFirstRowSecondImage.modelItem = _modelArray[4];
    self.bottomFirstRowThirdImage.modelItem = _modelArray[3];
    
    self.bottomSecondRowFirstImage.modelItem = _modelArray[8];
    self.bottomSecondRowSecondImage.modelItem = _modelArray[7];
    self.bottomSecondRowThirdImage.modelItem = _modelArray[6];
}


@end
