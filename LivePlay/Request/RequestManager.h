//
//  RequestManager.h
//  LivePlay
//
//  Created by 123456 on 16/12/7.
//  Copyright © 2016年 123456. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "RequestHeader.h"

typedef enum : NSUInteger {
    GetDataTypeGet,
    GetDataTypePost,
} GetDataType;

typedef NS_ENUM(NSUInteger, NetworkStates) {
    NetworkStatesNone, // 没有网络
    NetworkStates2G, // 2G
    NetworkStates3G, // 3G
    NetworkStates4G, // 4G
    NetworkStatesWIFI // WIFI
};
@interface RequestManager : AFHTTPSessionManager
+ (instancetype)sharedInstance;

// 判断网络类型
+ (NetworkStates)getNetworkStates;


- (void)requestWithType:(GetDataType)type urlString:(NSString *)urlStr parameters:(id)params interfaceType:(NSInteger)interfaceType finished:(void(^)(id response,NSError *error))finishBlock;

@end
