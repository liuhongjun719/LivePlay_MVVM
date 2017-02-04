//
//  ViewModelManager.m
//  LivePlay
//
//  Created by 123456 on 17/2/3.
//  Copyright © 2017年 123456. All rights reserved.
//

#import "ViewModelManager.h"

@implementation ViewModelManager
+ (ViewModelManager *)sharedInstance{
    static ViewModelManager *viewModel=nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        //一次只允许一个请求
        if (viewModel==nil) {
            viewModel=[[ViewModelManager alloc]init];
        }
    });
    return viewModel;
}
- (void)handleDataWithSuccess:(void (^)(NSArray *arr))success failure:(void(^)(NSError *error))failure{

}
@end
