//
//  NSString+ClipString.m
//  LivePlay
//
//  Created by 123456 on 16/12/14.
//  Copyright © 2016年 123456. All rights reserved.
//

#import "NSString+ClipString.h"


@implementation NSString (ClipString)
+ (NSMutableAttributedString *)getAttributeString:(NSString *)string range1:(NSRange)range1 {
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:string];
    [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:range1];
    [attributeString addAttribute:NSForegroundColorAttributeName value:RGBColor(255, 232, 20) range:NSMakeRange(range1.length, string.length-range1.length)];
    return attributeString;
}

- (CGSize)getStringSize:(CGFloat)fontSize height:(CGFloat)height {
    CGSize size = CGSizeMake(1000, height);
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    
    
    NSAttributedString *attributedText =
    [[NSAttributedString alloc]
     initWithString:self
     attributes:attributes];
    CGRect rect = [attributedText boundingRectWithSize:size
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];

    return rect.size;
}



@end
