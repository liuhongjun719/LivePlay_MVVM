//
//  BroadcastPageViewController.m
//  LivePlay
//
//  Created by 123456 on 16/12/7.
//  Copyright © 2016年 123456. All rights reserved.
//

#import "BroadcastPageViewController.h"
#import "RequestManager.h"
//#import "HomeContainerView.h"
//#import "BroadcastViewController.h"
//#import <SDWebImage/UIImageView+WebCache.h>
//#import <IJKMediaFramework/IJKMediaFramework.h>
#import "BroadcastContainerView.h"
#import "ShowBroadcastViewController.h"

#import "LFLiveSession.h"
#import "LFLiveVideoConfiguration.h"
#import <Accelerate/Accelerate.h>

#import <LFLiveKit.h>
#import "RDVTabBarItem.h"
#import "RDVTabBarController.h"



@interface BroadcastPageViewController () <BroadcastContainerViewDelegate, LFLiveSessionDelegate>{
    
}
@property(nonatomic, strong) BroadcastContainerView *broadcastContainerView;
@property (nonatomic, strong) LFLiveSession *session;


@end

@implementation BroadcastPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.scrollType = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    self.broadcastContainerView = [[BroadcastContainerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-60-49-40)];

    self.broadcastContainerView.delegate = self;
    [self.view addSubview:self.broadcastContainerView];
    
    [self requestAccessForVideo];
    [self requestAccessForAudio];
    
    [self requestBroadcastData];
}

- (void)requestBroadcastData {
    [[RequestManager sharedInstance] requestWithType:GetDataTypeGet urlString:BroadcastUrl  parameters:nil interfaceType:Broadcast_interface finished:^(id response, NSError *error) {
        [self.broadcastContainerView endRefreshing];
        ResponseObject *responseObject = response;
        self.broadcastContainerView.object = responseObject;
        
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}









#pragma mark - Public Method
- (void)requestAccessForVideo {
    __weak typeof(self) _self = self;
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (status) {
        case AVAuthorizationStatusNotDetermined: {
            // 许可对话没有出现，发起授权许可
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [_self.session setRunning:YES];
//                    });
                }
            }];
            break;
        }
        case AVAuthorizationStatusAuthorized: {
            // 已经开启授权，可继续
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [_self.session setRunning:YES];
//            });
            break;
        }
        case AVAuthorizationStatusDenied:
        case AVAuthorizationStatusRestricted:
            // 用户明确地拒绝授权，或者相机设备无法访问
            
            break;
        default:
            break;
    }
}

- (void)requestAccessForAudio {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    switch (status) {
        case AVAuthorizationStatusNotDetermined: {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
            }];
            break;
        }
        case AVAuthorizationStatusAuthorized: {
            break;
        }
        case AVAuthorizationStatusDenied:
        case AVAuthorizationStatusRestricted:
            break;
        default:
            break;
    }
}



#pragma mark - Getter Setter
- (LFLiveSession *)session {
    if (!_session) {
        _session = [[LFLiveSession alloc] initWithAudioConfiguration:[LFLiveAudioConfiguration defaultConfiguration] videoConfiguration:[LFLiveVideoConfiguration defaultConfigurationForQuality:LFLiveVideoQuality_Medium3]];
        
        _session.delegate = self;
        _session.showDebugInfo = NO;
//        _session.preView = self;
    }
    return _session;
}
















#pragma mark - BroadcastContainerViewDelegate
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

- (void)refreshPageAgain  {
    [self requestBroadcastData];
}

@end
