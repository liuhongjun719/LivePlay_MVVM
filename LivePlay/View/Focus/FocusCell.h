//
//  FocusCell.h
//  FocusHeaderDemo
//
//  Created by 123456 on 16/4/5.
//  Copyright © 2016年 123456. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ModelItem;
@interface FocusCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *focusImageView;
- (void)setImageViewWithImageName:(ModelItem *)modelItem;
@end
