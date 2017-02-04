//
//  RequestManager.m
//  LivePlay
//
//  Created by 123456 on 16/12/7.
//  Copyright © 2016年 123456. All rights reserved.
//

#import "RequestManager.h"
#import "ModelItem.h"
#import "ResponseObject.h"
#import "ResultAnalyzer.h"

@implementation RequestManager
static RequestManager *_manager;
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [RequestManager manager];
        // 设置超时时间
        _manager.requestSerializer.timeoutInterval = 5.f;
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", @"application/x-javascript", nil];
    });
    return _manager;
}

// 判断网络类型
+ (NetworkStates)getNetworkStates
{
    NSArray *subviews = [[[[UIApplication sharedApplication] valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    // 保存网络状态
    NetworkStates states = NetworkStatesNone;
    for (id child in subviews) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            //获取到状态栏码
            int networkType = [[child valueForKeyPath:@"dataNetworkType"] intValue];
            switch (networkType) {
                case 0:
                    states = NetworkStatesNone;
                    //无网模式
                    break;
                case 1:
                    states = NetworkStates2G;
                    break;
                case 2:
                    states = NetworkStates3G;
                    break;
                case 3:
                    states = NetworkStates4G;
                    break;
                case 5:
                {
                    states = NetworkStatesWIFI;
                }
                    break;
                default:
                    break;
            }
        }
    }
    //根据状态选择
    return states;
}




- (void)requestWithType:(GetDataType)type urlString:(NSString *)urlStr parameters:(id)params interfaceType:(NSInteger)interfaceType finished:(void(^)(id response,NSError *error))finishBlock{

    [_manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [_manager.requestSerializer setCachePolicy:NSURLRequestReturnCacheDataElseLoad];
    

    switch (type) {
        case GetDataTypeGet://GET
        {
            [_manager GET:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                //请求的头部信息；（我们执行网络请求的时候给服务器发送的包头信息）
                NSLog(@"request_ur:%@\nheader:%@", task.currentRequest,task.currentRequest.allHTTPHeaderFields);
                /*
                {
                    Accept = "application/json";
                    "Accept-Encoding" = "gzip, deflate";
                    "Accept-Language" = "en;q=1";
                    "User-Agent" = "la jiao zhi bo/1.0 (iPhone; iOS 10.0; Scale/2.00)";
                }
                 */
//                ResponseObject *object = [[ResponseObject alloc] init];
//                [object setValuesForKeysWithDictionary:responseObject];
                ResponseObject *object = [ResultAnalyzer analyseResult:responseObject interfaceType: interfaceType];
                finishBlock(object.data,nil);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"error-------:%@", error);
                finishBlock(nil,error);
            }];

        }
            break;
        case GetDataTypePost://POST
        {
            
        }
            break;
        default:
            break;
    }
    
    
}
@end
