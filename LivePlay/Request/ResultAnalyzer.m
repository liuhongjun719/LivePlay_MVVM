

//
//  ResultAnalyzer.m
//  斯迪尔
//
//  Created by Gloria on 14-7-4.
//  Copyright (c) 2014年 Steel. All rights reserved.
//

#import "ResultAnalyzer.h"
#import "ModelItem.h"
#import "RequestHeader.h"
#import <MJExtension.h>


@implementation ResultAnalyzer

+(ResponseObject *)analyseResult:(NSDictionary *)dictionary interfaceType:(NSInteger)interfaceType
{
    ResponseObject *responseObject = [[ResponseObject alloc] init];
    switch (interfaceType) {
        case Broadcast_interface://直播
        {
            
            responseObject.bar = [ModelItem mj_objectArrayWithKeyValuesArray:dictionary[@"bar"]];
            responseObject.list = [ModelItem mj_objectArrayWithKeyValuesArray:dictionary[@"list"]];
            responseObject.data = responseObject;
        }
            break;
        case AddUserUrl_interface://直播详情
        {
            NSLog(@"qqqqqqq-----:%lu", (unsigned long)[ModelItem mj_objectArrayWithKeyValuesArray:dictionary[@"user"]].count);

            responseObject.user = [ModelItem mj_objectArrayWithKeyValuesArray:dictionary[@"user"]];
            responseObject.gift = [ModelItem mj_objectArrayWithKeyValuesArray:dictionary[@"gift"]];//dic
            responseObject.live = [ModelItem mj_objectWithKeyValues:dictionary[@"live"]];

            responseObject.data = responseObject;
        }
            break;
        case AttentionUrl_interface://关注
        {
            responseObject.bar = [ModelItem mj_objectArrayWithKeyValuesArray:dictionary[@"bar"]];
//            responseObject.info = [ModelItem mj_objectArrayWithKeyValuesArray:dictionary[@"info"]];
            responseObject.info = [ModelItem mj_objectWithKeyValues:dictionary[@"info"]];
            responseObject.data = responseObject;
            
        }
            break;

        default:
        {
            [responseObject setValuesForKeysWithDictionary:dictionary];
            return responseObject;
        }
            break;
    }
    
    return responseObject;
}

@end
