//
//  ColumnFlowViewController.m
//  LivePlay
//
//  Created by 123456 on 16/12/20.
//  Copyright © 2016年 123456. All rights reserved.
//

#import "ColumnFlowViewController.h"
#import "RequestManager.h"
//#import "BroadcastContainerView.h"
#import "ShowBroadcastViewController.h"

#import "LFLiveSession.h"
#import "LFLiveVideoConfiguration.h"
#import <Accelerate/Accelerate.h>

#import <LFLiveKit.h>
#import "RDVTabBarItem.h"
#import "RDVTabBarController.h"
//#import "BigImageContainerView.h"
#import "ColumnContainerView.h"



@interface ColumnFlowViewController () <ColumnContainerViewDelegate>{
    
}
@property(nonatomic, strong) ColumnContainerView *columnContainerView;


@end

@implementation ColumnFlowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.columnContainerView = [[ColumnContainerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-60-49-40)];
    
    self.columnContainerView.delegate = self;
    [self.view addSubview:self.columnContainerView];
    
    [self requestBroadcastData];
}

- (void)requestBroadcastData {
    //设置不同的url
    NSString *url= @"";
    NSInteger interface = 0;
    if (self.scrollType == 4) {
        url = NewbieUrl;
        interface = NewbieUrl_interface;
    }else if (self.scrollType == 5) {
        url = NearbyUrl;
        interface = NearbyUrl_interface;
    }    
    
    [[RequestManager sharedInstance] requestWithType:GetDataTypeGet urlString:url  parameters:nil interfaceType:interface finished:^(id response, NSError *error) {
        [self.columnContainerView endRefreshing];
        ResponseObject *responseObject = response;
        self.columnContainerView.object = responseObject;
    }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}























#pragma mark - ColumnContainerViewDelegate
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
