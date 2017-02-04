//
//  NSString+ClipString.h
//  LivePlay
//
//  Created by 123456 on 16/12/14.
//  Copyright © 2016年 123456. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (ClipString)
+ (NSMutableAttributedString *)getAttributeString:(NSString *)string range1:(NSRange)range1;
- (CGSize)getStringSize:(CGFloat)fontSize height:(CGFloat)height;
@end
