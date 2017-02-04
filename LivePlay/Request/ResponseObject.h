//
//  ResponseObject.h
//  YouKang
//
//  Created by Bing Zhang on 1/27/15.
//  Copyright (c) 2015 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResponseObject : NSObject
//@property (strong, nonatomic) NSInteger data;
//@property (strong, nonatomic) NSMutableArray *data;
@property (strong, nonatomic) id data;
@property (strong, nonatomic) id bar;
@property (strong, nonatomic) id list;

@property (strong, nonatomic) id active;
@property (strong, nonatomic) id ban;
@property (strong, nonatomic) id family;
@property (strong, nonatomic) id follow;
@property (strong, nonatomic) id gift;
@property (strong, nonatomic) id live;
@property (strong, nonatomic) id manage;
@property (strong, nonatomic) id msg;
@property (strong, nonatomic) id notice;
@property (strong, nonatomic) id ret;
@property (strong, nonatomic) id self;
@property (strong, nonatomic) id user;

@property (strong, nonatomic) id info;



@end
