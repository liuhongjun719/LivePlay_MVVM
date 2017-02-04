//
//  FavouriteCell.m
//  LivePlay
//
//  Created by 123456 on 16/12/9.
//  Copyright © 2016年 123456. All rights reserved.
//

#import "FavouriteCell.h"
#import "HomeRecommendItemView.h"
#import <Masonry.h>

@interface FavouriteCell ()
@property (nonatomic, strong) HomeRecommendItemView *picture;


@end

@implementation FavouriteCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.picture];
        
        [self.picture mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(self);
        }];

    }
    return self;
}

- (HomeRecommendItemView *)picture {
    if (!_picture) {
        _picture = [[HomeRecommendItemView alloc] init];
    }
    return _picture;
}


- (void)setModelItem:(ModelItem *)modelItem {
    self.picture.modelItem = modelItem;
}
@end
