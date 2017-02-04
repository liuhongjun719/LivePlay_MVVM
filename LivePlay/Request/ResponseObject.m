//
//  ResponseObject.m
//  YouKang
//
//  Created by Bing Zhang on 1/27/15.
//  Copyright (c) 2015 user. All rights reserved.
//

#import "ResponseObject.h"

@implementation ResponseObject

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"ResponseObject 中缺少指定字段:%@",key);
}
@end
