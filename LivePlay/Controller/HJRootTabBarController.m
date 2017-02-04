//
//  HJRootTabBarController.m
//  LivePlay
//
//  Created by 123456 on 16/12/7.
//  Copyright © 2016年 123456. All rights reserved.
//

#import "HJRootTabBarController.h"

@interface HJRootTabBarController ()

@end



#import "BroadcastContainerViewController.h"
#import "FriendsPageViewController.h"
#import "StartBroadcastPageViewController.h"
#import "MessagePageViewController.h"
#import "MyPageViewController.h"


@implementation HJRootTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    BroadcastContainerViewController *broadcastContainerVC = [[BroadcastContainerViewController alloc] init];
    UINavigationController *broadcastContainerNav = [[UINavigationController alloc]initWithRootViewController:broadcastContainerVC];
    broadcastContainerNav.navigationBarHidden = YES;
//    UITabBarItem *broadcastContainerItem = [self creatTabBarItemWithTitle:@"直播"];
    UITabBarItem *broadcastContainerItem = [self creatTabBarItemWithImage:@"直播_normal" selectedImage:@"直播_selected"];

    broadcastContainerNav.tabBarItem = broadcastContainerItem;
    
    FriendsPageViewController *friendsVC = [[FriendsPageViewController alloc] init];
    UINavigationController *friendsNav = [[UINavigationController alloc]initWithRootViewController:friendsVC];
    friendsNav.navigationBarHidden = YES;
    UITabBarItem *friendsItem = [self creatTabBarItemWithTitle:@"朋友"];
    friendsNav.tabBarItem = friendsItem;
    
    StartBroadcastPageViewController *startBroadcastVC = [[StartBroadcastPageViewController alloc] init];
    UINavigationController *startBroadcastNav = [[UINavigationController alloc]initWithRootViewController:startBroadcastVC];
    startBroadcastNav.navigationBarHidden = YES;
    UITabBarItem *startBroadcastItem = [self creatTabBarItemWithTitle:@""];
    startBroadcastNav.tabBarItem = startBroadcastItem;
    
    MessagePageViewController *messageVC = [[MessagePageViewController alloc] init];
    UINavigationController *messageNav = [[UINavigationController alloc]initWithRootViewController:messageVC];
    messageNav.navigationBarHidden = YES;
    UITabBarItem *messageItem = [self creatTabBarItemWithTitle:@"消息"];
    messageNav.tabBarItem = messageItem;
    
    
    MyPageViewController *myVC = [[MyPageViewController alloc] init];
    UINavigationController *myNav = [[UINavigationController alloc]initWithRootViewController:myVC];
    myNav.navigationBarHidden = YES;
    UITabBarItem *myItem = [self creatTabBarItemWithTitle:@"我的"];
    myNav.tabBarItem = myItem;
    

    self.viewControllers = @[broadcastContainerNav, friendsNav, startBroadcastNav, messageNav, myNav];
    
    self.tabBar.barTintColor = [UIColor whiteColor];
    self.tabBar.alpha = 1.0;
}

- (UITabBarItem *)creatTabBarItemWithImage:(NSString *)image selectedImage:(NSString *)selectedImage
{
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:image] selectedImage:[UIImage imageNamed:selectedImage]];
//    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:RGBCOLOR(21, 186, 65)} forState:UIControlStateSelected];
//    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    //    item.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);

    return item;
}

- (UITabBarItem *)creatTabBarItemWithTitle:(NSString*)title
{
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:title image:nil selectedImage:nil];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:RGBCOLOR(21, 186, 65)} forState:UIControlStateSelected];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    //    item.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    return item;
}

@end
