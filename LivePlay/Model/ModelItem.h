//
//  ModelItem.h
//  LivePlay
//
//  Created by 123456 on 16/12/7.
//  Copyright © 2016年 123456. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelItem : NSObject
////banner
//@property (nonatomic) NSInteger _id;
//@property (nonatomic, strong) NSString *click_url;
//@property (nonatomic) NSInteger goto_type;
//@property (nonatomic, strong) NSString *goto_val;
//@property (nonatomic) NSInteger order;
@property (nonatomic, strong) NSString *pic_url;
//@property (nonatomic) BOOL status;
//@property (nonatomic) NSInteger timestamp;
//@property (nonatomic, strong) NSString *title;
//@property (nonatomic) NSInteger type;
//
////hot broadcast
//@property (nonatomic, strong)NSMutableArray *activity_list;
//@property (nonatomic, strong)NSMutableArray *app_room_list;//2人气手机直播
//@property (nonatomic, strong)NSMutableArray *family_room_list;
//@property (nonatomic, strong)NSMutableArray *nest_list;
//
////@property (nonatomic, strong)NSMutableArray *new_recomm_list;
//@property (nonatomic, strong)NSMutableArray *wen_recomm_list;//4优秀新人(取前4个)
//@property (nonatomic, strong)NSMutableArray *outdoor_room_list;
//@property (nonatomic, strong)NSMutableArray *room_found_latest;//1么么推荐
//@property (nonatomic, strong)NSMutableArray *tag_list;
//@property (nonatomic, strong)NSMutableArray *tag_stars;
//
//@property (nonatomic, strong)NSMutableArray *tags;
//@property (nonatomic, strong)NSMutableArray *user_recomm_list;//3贵宾推荐
//@property (nonatomic, strong)NSDictionary *yesterday_special_gift;
//
//
//@property (nonatomic, strong) NSString *nick_name;
//@property (nonatomic) NSInteger followers;//**人在看
//


//broadcast
@property (nonatomic) NSInteger id;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *parameters;


@property (nonatomic, strong) NSMutableArray *livelist;

@property (nonatomic, strong) ModelItem *user;

@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *vip_image;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic) NSInteger users;//访问量
@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *cover;
@property (nonatomic, strong) NSString *rtmp;
@property (nonatomic) NSInteger from_gold;

@property (nonatomic) NSInteger live_uid;
@property (nonatomic, strong) ModelItem *grade;

@property (nonatomic, strong) NSString *province;


@end
