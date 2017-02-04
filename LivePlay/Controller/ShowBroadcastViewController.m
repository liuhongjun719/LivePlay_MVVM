//  ShowBroadcastViewController.m
//  LivePlay
//
//  Created by 123456 on 16/12/9.
//  Copyright © 2016年 123456. All rights reserved.

#import "ShowBroadcastViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "UIImageView+WebCache.h"
//#import "DMHeartFlyView.h"
#import <Accelerate/Accelerate.h>
#import "ModelItem.h"
#import "LFLiveSession.h"
#import <Accelerate/Accelerate.h>
#import <Masonry.h>
#import <LFLiveKit.h>
#import "RequestManager.h"
#import "RoomViewwerContainerView.h"
#import "ResponseObject.h"
#import "HJLiveGiftView.h"
//#import "TopInfoView.h"
#import "UserInfoView.h"
#import "NSSafeObject.h"
#import <BarrageRenderer/BarrageRenderer.h>
#import "RDVTabBarItem.h"
#import "RDVTabBarController.h"


#define XJScreenH [UIScreen mainScreen].bounds.size.height
#define XJScreenW [UIScreen mainScreen].bounds.size.width
@interface ShowBroadcastViewController ()<RoomViewwerContainerViewDelegate>
{
    BarrageRenderer *_renderer;
//    NSTimer * _timer;
    NSInteger _index;
}

@property (atomic, retain) id <IJKMediaPlayback> player;

@property (weak, nonatomic) UIView *PlayerView;

@property (atomic, strong) NSURL *url;

@property (nonatomic, assign)int number;

@property (nonatomic, assign)CGFloat heartSize;

@property (nonatomic, strong)UIImageView *dimIamge;

@property (nonatomic, strong) NSArray *fireworksArray;

@property (nonatomic, weak) CALayer *fireworksL;

@property (nonatomic, strong) UIButton *closeBtn;

//room_viewwer
@property (nonatomic, strong) NSMutableArray *modelArray;
@property (nonatomic, strong) RoomViewwerContainerView *roomViewwerContainerView;
@property (nonatomic, strong) UIButton * heartBtn;
@property (nonatomic, strong) HJLiveGiftView *liveGiftView;
@property (nonatomic) BOOL isShowGiftList;

@property (nonatomic, strong) UIView *bottomToolBar;
@property (nonatomic, strong) NSTimer *timer;
//@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) UserInfoView *userInfoView;//顶部个人信息弹框
@property (nonatomic, strong) ModelItem *liveItem;
@end

@implementation ShowBroadcastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.modelArray = [NSMutableArray array];
    _isShowGiftList = YES;
    // 播放视频
    [self goPlaying];
    
    // 开启通知
    [self installMovieNotificationObservers];
    
    // 设置加载视图
    [self setupLoadingView];
    
    //弹屏
    [self initBarrageRenderer];
    
    // 创建按钮
    [self setupToolBar];
    
    //礼物列表
    [self addGiftList];
    
    //设置room_viewwer
    [self setRoomViewwer];
    
    //个人信息
    [self setupTopInfoView];
    


    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self requestBroadcastData];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(praiseAnimation) userInfo:nil repeats:YES];

}


- (void)setupTopInfoView {
    self.userInfoView = [[UserInfoView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.userInfoView];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
    [self.timer fire];
    self.timer = nil;
}
- (void)addGiftList {
    self.liveGiftView = [[HJLiveGiftView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_liveGiftView];
    self.liveGiftView.hideGiftDidClicked = ^(BOOL isHidden) {
        _bottomToolBar.hidden = isHidden;
    };
}

- (void)setRoomViewwer {
    self.roomViewwerContainerView = [[RoomViewwerContainerView alloc] initWithFrame:CGRectMake(80, 20, (self.view.frame.size.width-self.closeBtn.frame.size.width-80-40), 30)];
    self.roomViewwerContainerView.delegate = self;
    [self.view addSubview:self.roomViewwerContainerView];
    
    // 告诉self约束需要更新
//    [self.roomViewwerContainerView setNeedsUpdateConstraints];
    // 调用此方法告诉self检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
//    [self.roomViewwerContainerView updateConstraintsIfNeeded];
//    [self.roomViewwerContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.closeBtn.mas_left).offset(5);
////        make.left.equalTo(self.view).offset(100);
//        make.height.mas_equalTo(30);
//        make.centerY.equalTo(self.closeBtn);
//    }];
//    [self.roomViewwerContainerView layoutIfNeeded];
}
- (void)requestBroadcastData {
    [[RequestManager sharedInstance] requestWithType:GetDataTypeGet urlString:AddUserUrl  parameters:nil interfaceType:AddUserUrl_interface finished:^(id response, NSError *error) {
        ResponseObject *responseObject = response;
        self.modelArray = responseObject.user;
        self.roomViewwerContainerView.modelArray = self.modelArray;
        NSArray *arr = responseObject.gift;
        NSLog(@"ddddddd-----:%lu", arr.count);

        self.liveGiftView.giftArray = responseObject.gift;
        self.liveItem = responseObject.live;
        NSLog(@"ddddddd8888-----:%@", self.liveItem.user.nickname);
    }];
    
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];

    if (![self.player isPlaying]) {
        //准备播放
        [self.player prepareToPlay];
    }
}




#pragma mark ---- <设置加载视图>
- (void)setupLoadingView
{
    self.dimIamge = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [_dimIamge sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.modelItem.cover]] placeholderImage:nil];
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    visualEffectView.frame = _dimIamge.bounds;
    [_dimIamge addSubview:visualEffectView];
    [self.view addSubview:_dimIamge];
}

#pragma mark ---- <创建按钮>
- (void)setupToolBar {
    //返回
    UIButton *close = [UIButton buttonWithType:UIButtonTypeCustom];
    [close setBackgroundImage:[UIImage imageNamed:@"叉叉"] forState:UIControlStateNormal];
    [close addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:close];
    self.closeBtn = close;
    
    
    [close mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(30);
        make.right.equalTo(close.superview).offset(-5);
        make.top.equalTo(close.superview).offset(20);
    }];
    
    //bottom bar
    UIView *bottomToolBar = [[UIView alloc] init];
    [self.view addSubview:bottomToolBar];
    bottomToolBar.backgroundColor = [UIColor clearColor];
    self.bottomToolBar = bottomToolBar;
    
    [bottomToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(30);
        make.bottom.equalTo(bottomToolBar.superview).offset(-10);
    }];
    
    //礼物
    UIButton *giftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [giftBtn setImage:[UIImage imageNamed:@"视频_礼物"] forState:UIControlStateNormal];
    [giftBtn addTarget:self action:@selector(showGiftList) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomToolBar addSubview:giftBtn];
    [giftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(30);
        make.centerX.equalTo(self.bottomToolBar);
        make.top.bottom.equalTo(self.bottomToolBar);
    }];
    
    
 
    //截屏
    UIButton *screenShotsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [screenShotsBtn setImage:[UIImage imageNamed:@"截取屏幕按钮"] forState:UIControlStateNormal];
    [screenShotsBtn addTarget:self action:@selector(clipScreen) forControlEvents:UIControlEventTouchUpInside];
    screenShotsBtn.adjustsImageWhenHighlighted = YES;
    [self.bottomToolBar addSubview:screenShotsBtn];
    [screenShotsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(30);
        make.left.equalTo(screenShotsBtn.superview).offset(10);
        make.bottom.equalTo(giftBtn);
    }];
    
    //分享
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn setImage:[UIImage imageNamed:@"视频_分享"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareToOhters) forControlEvents:UIControlEventTouchUpInside];
    shareBtn.adjustsImageWhenHighlighted = YES;
    [self.bottomToolBar addSubview:shareBtn];
    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(30);
        make.left.equalTo(screenShotsBtn.mas_right).offset(8);
        make.bottom.equalTo(giftBtn);
    }];
    
    
    //心
    UIButton * heartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [heartBtn setImage:[UIImage imageNamed:@"点赞动画"] forState:UIControlStateNormal];
    [heartBtn addTarget:self action:@selector(showEmitter) forControlEvents:UIControlEventTouchUpInside];
    heartBtn.adjustsImageWhenHighlighted = YES;
    [self.bottomToolBar addSubview:heartBtn];
    self.heartBtn = heartBtn;
    [heartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(30);
        make.right.equalTo(heartBtn.superview).offset(-10);
        make.bottom.equalTo(giftBtn);
    }];
    
    //视频聊天
    UIButton *videoChatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [videoChatBtn setImage:[UIImage imageNamed:@"视频_聊天"] forState:UIControlStateNormal];
    [videoChatBtn addTarget:self action:@selector(videoChat) forControlEvents:UIControlEventTouchUpInside];
    videoChatBtn.adjustsImageWhenHighlighted = YES;
    [self.bottomToolBar addSubview:videoChatBtn];
    [videoChatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(30);
        make.right.equalTo(heartBtn.mas_left).offset(-8);
        make.bottom.equalTo(giftBtn);
    }];
    
    
    
    
}
- (void)clipScreen {
    
}

- (void)videoChat {
    
}

- (void)shareToOhters {
    
}

- (void)goPlaying {
    
    //获取url
    self.url = [NSURL URLWithString:self.modelItem.rtmp];
    
    //设置ijkPlayer控制器
    _player = [[IJKFFMoviePlayerController alloc] initWithContentURL:self.url withOptions:nil];
    
    //用ijkPlayer控制器创建一个播放器视图
    UIView *playerview = [self.player view];
    
    //实例化一个屏幕大小的view
    UIView *displayView = [[UIView alloc] initWithFrame:self.view.bounds];
    
    //让这个全局的PlayerView是一个覆盖全屏的view
    self.PlayerView = displayView;
    
    //把这个全局的PlayerView添加到控制器的view
    [self.view addSubview:self.PlayerView];
    
    // 自动调整自己的宽度和高度
    playerview.frame = self.PlayerView.bounds;
    playerview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    //把播放器视图添加到全局的PlayerView上
    [self.PlayerView insertSubview:playerview atIndex:1];
    
    //设置播放器的填充模式
    [_player setScalingMode:IJKMPMovieScalingModeAspectFill];
    
}
#pragma mark - Action
- (void)popViewController {
    [self.player shutdown];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 送礼物
- (void)showGiftList {
//    self.bottomToolBar.hidden = YES;
    [self.liveGiftView controlGiftList];
//    CGRect frame = CGRectZero;
//    if (self.isShowGiftList) {
//        frame = CGRectMake(0, self.view.frame.size.height-((self.view.frame.size.width)/2), self.view.frame.size.width, (self.view.frame.size.width)/2);
//        self.isShowGiftList = NO;
//    }else {
//        frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, (self.view.frame.size.width)/2);
//        self.isShowGiftList = YES;
//    }
    
//    [UIView animateWithDuration:0.25 animations:^{
//        _liveGiftView.frame = frame;
//    }];
}
#pragma mark  点赞
//-(void)showTheLove:(UIButton *)sender{
//    
//    _heartSize = 36;
//    
//    DMHeartFlyView* heart = [[DMHeartFlyView alloc]initWithFrame:CGRectMake(0, 0, _heartSize, _heartSize)];
//    [self.view addSubview:heart];
//    CGPoint fountainSource = CGPointMake(_heartSize + _heartSize/2.0, self.view.bounds.size.height - _heartSize/2.0 - 10);
//    heart.center = fountainSource;
//    [heart animateInView:self.view];
//    
//    // button点击动画
//    CAKeyframeAnimation *btnAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
//    btnAnimation.values = @[@(1.0),@(0.7),@(0.5),@(0.3),@(0.5),@(0.7),@(1.0), @(1.2), @(1.4), @(1.2), @(1.0)];
//    btnAnimation.keyTimes = @[@(0.0),@(0.1),@(0.2),@(0.3),@(0.4),@(0.5),@(0.6),@(0.7),@(0.8),@(0.9),@(1.0)];
//    btnAnimation.calculationMode = kCAAnimationLinear;
//    btnAnimation.duration = 0.3;
//    [sender.layer addAnimation:btnAnimation forKey:@"SHOW"];
//    
//}


- (void)showEmitter {
    [self praiseAnimation];
}


#pragma Install Notifiacation
- (void)installMovieNotificationObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadStateDidChange:)
                                                 name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                               object:_player];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackFinish:)
                                                 name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mediaIsPreparedToPlayDidChange:)
                                                 name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackStateDidChange:)
                                                 name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                               object:_player];
    
}

- (void)removeMovieNotificationObservers {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                                  object:_player];
    
}

#pragma Selector func

- (void)loadStateDidChange:(NSNotification*)notification {
    IJKMPMovieLoadState loadState = _player.loadState;
    
    if ((loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        NSLog(@"LoadStateDidChange: IJKMovieLoadStatePlayThroughOK: %d\n",(int)loadState);
    }else if ((loadState & IJKMPMovieLoadStateStalled) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStateStalled: %d\n", (int)loadState);
    } else {
        NSLog(@"loadStateDidChange: ???: %d\n", (int)loadState);
    }
}

- (void)moviePlayBackFinish:(NSNotification*)notification {
    int reason =[[[notification userInfo] valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
    switch (reason) {
        case IJKMPMovieFinishReasonPlaybackEnded:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackEnded: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonUserExited:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonUserExited: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonPlaybackError:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackError: %d\n", reason);
            break;
            
        default:
            NSLog(@"playbackPlayBackDidFinish: ???: %d\n", reason);
            break;
    }
}

- (void)mediaIsPreparedToPlayDidChange:(NSNotification*)notification {
    NSLog(@"mediaIsPrepareToPlayDidChange\n");
}

- (void)moviePlayBackStateDidChange:(NSNotification*)notification {
    
    _dimIamge.hidden = YES;
    
    switch (_player.playbackState) {
            
        case IJKMPMoviePlaybackStateStopped:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: stoped", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStatePlaying:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: playing", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStatePaused:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: paused", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStateInterrupted:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: interrupted", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStateSeekingForward:
        case IJKMPMoviePlaybackStateSeekingBackward: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: seeking", (int)_player.playbackState);
            break;
        }
            
        default: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: unknown", (int)_player.playbackState);
            break;
        }
    }
}


- (void)praiseAnimation {
    UIImageView *imageView = [[UIImageView alloc] init];
    CGRect frame = self.view.frame;
    //  初始frame，即设置了动画的起点
    imageView.frame = CGRectMake(frame.size.width - 40, frame.size.height - 65, 30, 30);
    //  初始化imageView透明度为0
    imageView.alpha = 0;
    imageView.backgroundColor = [UIColor clearColor];
    imageView.clipsToBounds = YES;
    [self.view addSubview:imageView];


    //  用0.2秒的时间将imageView的透明度变成1.0，同时将其放大1.3倍，再缩放至1.1倍，这里参数根据需求设置
    [UIView animateWithDuration:0.2 animations:^{
        imageView.alpha = 1.0;
        imageView.frame = CGRectMake(frame.size.width - 40, frame.size.height - 90, 30, 30);
        CGAffineTransform transfrom = CGAffineTransformMakeScale(1.3, 1.3);
        imageView.transform = CGAffineTransformScale(transfrom, 1, 1);
    }];
    

    //  随机产生一个动画结束点的X值
    CGFloat finishX = frame.size.width - round(random() % 200);
    //  动画结束点的Y值
    CGFloat finishY = 200;
    //  imageView在运动过程中的缩放比例
    CGFloat scale = round(random() % 2) + 0.7;
    // 生成一个作为速度参数的随机数
    CGFloat speed = 1 / round(random() % 900) + 0.6;
    //  动画执行时间
    NSTimeInterval duration = 4 * speed;
    //  如果得到的时间是无穷大，就重新附一个值（这里要特别注意，请看下面的特别提醒）
    if (duration == INFINITY) duration = 2.412346;
    // 随机生成一个0~6的数，以便下面拼接图片名
    int imageName = round(random() % 7);
    
    //  开始动画
    [UIView beginAnimations:nil context:(__bridge void *_Nullable)(imageView)];
    //  设置动画时间
    [UIView setAnimationDuration:duration];
    
    //  拼接图片名字
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"pop_pic_%d.png",imageName]];
    
    //  设置imageView的结束frame
    imageView.frame = CGRectMake( finishX, finishY, 30 * scale, 30 * scale);
    
    //  设置渐渐消失的效果，这里的时间最好和动画时间一致
    [UIView animateWithDuration:duration animations:^{
        imageView.alpha = 0;
    }];
    
    //  结束动画，调用onAnimationComplete:finished:context:函数
    [UIView setAnimationDidStopSelector:@selector(onAnimationComplete:finished:context:)];
    //  设置动画代理
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
}

/// 动画完后销毁iamgeView
- (void)onAnimationComplete:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context{
    UIImageView *imageView = (__bridge UIImageView *)(context);
    [imageView removeFromSuperview];
    imageView = nil;
}

#pragma mark- RoomViewwerContainerViewDelegate
- (void)didSelectItemWithItem:(ModelItem *)modelItem {
    [self.userInfoView refreshInfoViewWithItem:modelItem];
}
#pragma mark- 弹屏
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSSafeObject * safeObj = [[NSSafeObject alloc]initWithObject:self withSelector:@selector(showBarrageRenderer)];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:safeObj selector:@selector(excute) userInfo:nil repeats:NO];
    [_renderer start];
}
- (void)initBarrageRenderer
{
    _renderer = [[BarrageRenderer alloc]init];
    _renderer.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_renderer.view];
    _renderer.canvasMargin = UIEdgeInsetsMake(10, 10, 10, 10);
    // 若想为弹幕增加点击功能, 请添加此句话, 并在Descriptor中注入行为
    _renderer.view.userInteractionEnabled = YES;
    
//    [self.view bringSubviewToFront:_renderer.view];
//    [self.roomViewwerContainerView sendSubviewToBack:_renderer.view];
}

//弹屏
- (void)showBarrageRenderer {
    
//    NSInteger spriteNumber = [_renderer spritesNumberWithName:NSStringFromClass([BarrageWalkTextSprite class])];
//    if (spriteNumber <= 10) {
        [_renderer receive:[self walkTextSpriteDescriptorWithDirection:BarrageWalkDirectionR2L side:BarrageWalkSideDefault]];
        [_renderer receive:[self walkImageSpriteDescriptorWithDirection:BarrageWalkDirectionL2R]];

//    }

    
}

- (void)dealloc
{
    [_renderer stop];
}
/// 生成精灵描述 - 过场文字弹幕
- (BarrageDescriptor *)walkTextSpriteDescriptorWithDirection:(BarrageWalkDirection)direction
{
    return [self walkTextSpriteDescriptorWithDirection:direction side:BarrageWalkSideDefault];
}
/// 生成精灵描述 - 过场文字弹幕
- (BarrageDescriptor *)walkTextSpriteDescriptorWithDirection:(BarrageWalkDirection)direction side:(BarrageWalkSide)side
{
    BarrageDescriptor * descriptor = [[BarrageDescriptor alloc]init];
    descriptor.spriteName = NSStringFromClass([BarrageWalkTextSprite class]);
    descriptor.params[@"text"] = [NSString stringWithFormat:@"过场文字弹幕:%ld",(long)_index++];
    descriptor.params[@"textColor"] = [UIColor blueColor];
    descriptor.params[@"speed"] = @(100 * (double)random()/RAND_MAX+50);
    descriptor.params[@"direction"] = @(direction);
    descriptor.params[@"side"] = @(side);
    descriptor.params[@"clickAction"] = ^{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"弹幕被点击" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [alertView show];
    };
    return descriptor;
}
/// 生成精灵描述 - 过场图片弹幕
- (BarrageDescriptor *)walkImageSpriteDescriptorWithDirection:(NSInteger)direction
{
    BarrageDescriptor * descriptor = [[BarrageDescriptor alloc]init];
    descriptor.spriteName = NSStringFromClass([BarrageWalkImageSprite class]);
    descriptor.params[@"image"] = [[UIImage imageNamed:@"pop_pic_1.png"]barrageImageScaleToSize:CGSizeMake(20.0f, 20.0f)];
    descriptor.params[@"text"] = [NSString stringWithFormat:@"过场uuuuuuu:%ld",(long)_index++];

    descriptor.params[@"speed"] = @(100 * (double)random()/RAND_MAX+50);
    descriptor.params[@"direction"] = @(direction);
    descriptor.params[@"trackNumber"] = @5; // 轨道数量
    return descriptor;
}



@end

