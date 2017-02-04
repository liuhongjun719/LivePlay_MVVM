//
//  AppDelegate.m
//  LivePlay
//
//  Created by 123456 on 16/12/5.
//  Copyright © 2016年 123456. All rights reserved.
//

#import "AppDelegate.h"
#import "HJRootTabBarController.h"
#import "YunBaService.h"
#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"

#import "BroadcastContainerViewController.h"
#import "FriendsPageViewController.h"
#import "StartBroadcastPageViewController.h"
#import "MessagePageViewController.h"
#import "MyPageViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self setupViewControllers];
    [self.window setRootViewController:self.viewController];
    [self.window makeKeyAndVisible];
    
    // Override point for customization after application launch.
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    self.window.rootViewController = [[HJRootTabBarController alloc] init];
//    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark - Methods

- (void)setupViewControllers {
    BroadcastContainerViewController *broadcastContainerVC = [[BroadcastContainerViewController alloc] init];
    UINavigationController *broadcastContainerNav = [[UINavigationController alloc]initWithRootViewController:broadcastContainerVC];
    broadcastContainerNav.navigationBarHidden = YES;
    
    
    FriendsPageViewController *friendsVC = [[FriendsPageViewController alloc] init];
    UINavigationController *friendsNav = [[UINavigationController alloc]initWithRootViewController:friendsVC];
    friendsNav.navigationBarHidden = YES;
    
    
    StartBroadcastPageViewController *startBroadcastVC = [[StartBroadcastPageViewController alloc] init];
    UINavigationController *startBroadcastNav = [[UINavigationController alloc]initWithRootViewController:startBroadcastVC];
    startBroadcastNav.navigationBarHidden = YES;
    
    MessagePageViewController *messageVC = [[MessagePageViewController alloc] init];
    UINavigationController *messageNav = [[UINavigationController alloc]initWithRootViewController:messageVC];
    messageNav.navigationBarHidden = YES;
    
    
    MyPageViewController *myVC = [[MyPageViewController alloc] init];
    UINavigationController *myNav = [[UINavigationController alloc]initWithRootViewController:myVC];
    myNav.navigationBarHidden = YES;
    
    
    
    
    RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
    [tabBarController setViewControllers:@[broadcastContainerNav, friendsNav, startBroadcastNav, messageNav, myNav]];
    self.viewController = tabBarController;
    [self customizeTabBarForController:tabBarController];
}

- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    UIImage *finishedImage = [UIImage imageNamed:@"tabBar_background_image"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabBar_background_image"];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%ld_selected",(long)index]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%ld_normal",(long)index]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        index++;
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
