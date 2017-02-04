//
//  ResultAnalyzer.h
//  斯迪尔
//
//  Created by Gloria on 14-7-4.
//  Copyright (c) 2014年 Steel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseObject.h"

//结果解析器
@interface ResultAnalyzer : NSObject
+(ResponseObject *)analyseResult:(NSDictionary *)dictionary interfaceType:(NSInteger)interfaceType;

@end
