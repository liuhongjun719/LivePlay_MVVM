//
//  BigImageViewController.m
//  LivePlay
//
//  Created by 123456 on 16/12/20.
//  Copyright © 2016年 123456. All rights reserved.
//

#import "BigImageViewController.h"
#import "RequestManager.h"
//#import "BroadcastContainerView.h"
#import "ShowBroadcastViewController.h"

#import "LFLiveSession.h"
#import "LFLiveVideoConfiguration.h"
#import <Accelerate/Accelerate.h>

#import <LFLiveKit.h>
#import "RDVTabBarItem.h"
#import "RDVTabBarController.h"
#import "BigImageContainerView.h"



@interface BigImageViewController () <BigImageContainerViewDelegate>{
    
}
@property(nonatomic, strong) BigImageContainerView *bigImageContainerView;


@end

@implementation BigImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.bigImageContainerView = [[BigImageContainerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-60-49-40)];
    
    self.bigImageContainerView.delegate = self;
    [self.view addSubview:self.bigImageContainerView];
    

    [self requestBroadcastData];
}

- (void)requestBroadcastData {
    //设置不同的url
    NSString *url= @"";
    NSInteger interface = 0;
    if (self.scrollType == 1) {
        url = HotUrl;
        interface = HotUrl_interface;
    }else if (self.scrollType == 2 ) {
        url = SkillUrl;
        interface = SkillUrl_interface;
    }else if(self.scrollType == 3){
        url = AttentionUrl;
        interface = AttentionUrl_interface;
    }

    
    [[RequestManager sharedInstance] requestWithType:GetDataTypeGet urlString:url  parameters:nil interfaceType:interface finished:^(id response, NSError *error) {
        [self.bigImageContainerView endRefreshing];
        ResponseObject *responseObject = response;
        self.bigImageContainerView.object = responseObject;
    }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}























#pragma mark - BigImageContainerViewDelegate
- (void)didSelectItem:(ModelItem *)modelItem {
    ShowBroadcastViewController *showBroadcastViewController = [[ShowBroadcastViewController alloc] init];
    showBroadcastViewController.modelItem = modelItem;
    //    showBroadcastViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController  pushViewController:showBroadcastViewController animated:YES];
    
    //    ShowBroadcastViewController *playVC = [[ShowBroadcastViewController alloc]init];
    //    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:playVC];
    //    [self presentViewController:nav animated:YES completion:^{
    //    }];
}

- (void)pageHeaderDidPull {
    [self requestBroadcastData];
}

@end
