//
//  ViewModelManager.h
//  LivePlay
//
//  Created by 123456 on 17/2/3.
//  Copyright © 2017年 123456. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewModelManager : NSObject
+ (ViewModelManager *)sharedInstance;

- (void)handleDataWithSuccess:(void (^)(NSArray *arr))success
                      failure:(void(^)(NSError *error))failure;
@end
