//
//  ViewController.m
//  LivePlay
//
//  Created by 123456 on 16/12/5.
//  Copyright © 2016年 123456. All rights reserved.
//

#import "ViewController.h"
#import <BarrageRenderer/BarrageRenderer.h>
#import "NSSafeObject.h"
#import "UIImage+Barrage.h"
#import <IJKMediaFramework/IJKMediaFramework.h>

@interface ViewController () {
    BarrageRenderer *_renderer;
    NSTimer * _timer;
    NSInteger _index;
    
}
@property (nonatomic, strong) IJKFFMoviePlayerController *moviePlayer;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _index = 0;
    [self initBarrageRenderer];
}

- (void)initBarrageRenderer
{
    _renderer = [[BarrageRenderer alloc]init];
    [self.view addSubview:_renderer.view];
    _renderer.canvasMargin = UIEdgeInsetsMake(10, 10, 10, 10);
    // 若想为弹幕增加点击功能, 请添加此句话, 并在Descriptor中注入行为
    _renderer.view.userInteractionEnabled = YES;
    [self.view sendSubviewToBack:_renderer.view];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSSafeObject * safeObj = [[NSSafeObject alloc]initWithObject:self withSelector:@selector(autoSendBarrage)];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:safeObj selector:@selector(excute) userInfo:nil repeats:YES];
}

- (void)dealloc
{
    [_renderer stop];
}
#pragma mark - Action
- (IBAction)startAction:(id)sender {
    [_renderer start];
}
- (IBAction)pauseAction:(id)sender {
    [_renderer pause];
}
- (IBAction)resumeAction:(id)sender {
    [_renderer start];
}
- (IBAction)stopAction:(id)sender {
    [_renderer stop];
}

- (IBAction)slowDownAction:(id)sender {
    CGFloat speed = _renderer.speed - 0.5;
    if (speed <= 0.5f) {
        speed = 0.5;
    }
    _renderer.speed = speed;
}
- (IBAction)speedUpAction:(id)sender {
    CGFloat speed = _renderer.speed + 0.5;
    if (speed >= 10) {
        speed = 10.0f;
    }
    _renderer.speed = speed;
}

- (void)autoSendBarrage
{
    NSInteger spriteNumber = [_renderer spritesNumberWithName:nil];
    self.infoLabel.text = [NSString stringWithFormat:@"当前屏幕弹幕数量: %ld",(long)spriteNumber];
    if (spriteNumber <= 500) { // 用来演示如何限制屏幕上的弹幕量
        [_renderer receive:[self walkTextSpriteDescriptorWithDirection:BarrageWalkDirectionR2L side:BarrageWalkSideLeft]];
        [_renderer receive:[self walkTextSpriteDescriptorWithDirection:BarrageWalkDirectionR2L side:BarrageWalkSideDefault]];
        
        [_renderer receive:[self walkTextSpriteDescriptorWithDirection:BarrageWalkDirectionB2T side:BarrageWalkSideLeft]];
        [_renderer receive:[self walkTextSpriteDescriptorWithDirection:BarrageWalkDirectionB2T side:BarrageWalkSideRight]];
        
        [_renderer receive:[self floatTextSpriteDescriptorWithDirection:BarrageFloatDirectionB2T side:BarrageFloatSideCenter]];
        [_renderer receive:[self floatTextSpriteDescriptorWithDirection:BarrageFloatDirectionT2B side:BarrageFloatSideLeft]];
        [_renderer receive:[self floatTextSpriteDescriptorWithDirection:BarrageFloatDirectionT2B side:BarrageFloatSideRight]];
        
        [_renderer receive:[self walkImageSpriteDescriptorWithDirection:BarrageWalkDirectionL2R]];
        [_renderer receive:[self walkImageSpriteDescriptorWithDirection:BarrageWalkDirectionL2R]];
        [_renderer receive:[self floatImageSpriteDescriptorWithDirection:BarrageFloatDirectionT2B]];
    }
}

#pragma mark - 弹幕描述符生产方法
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

/// 生成精灵描述 - 浮动文字弹幕
- (BarrageDescriptor *)floatTextSpriteDescriptorWithDirection:(NSInteger)direction
{
    return [self floatTextSpriteDescriptorWithDirection:direction side:BarrageFloatSideCenter];
}

/// 生成精灵描述 - 浮动文字弹幕
- (BarrageDescriptor *)floatTextSpriteDescriptorWithDirection:(NSInteger)direction side:(BarrageFloatSide)side
{
    BarrageDescriptor * descriptor = [[BarrageDescriptor alloc]init];
    descriptor.spriteName = NSStringFromClass([BarrageFloatTextSprite class]);
    descriptor.params[@"text"] = [NSString stringWithFormat:@"悬浮文字弹幕:%ld",(long)_index++];
    descriptor.params[@"textColor"] = [UIColor purpleColor];
    descriptor.params[@"duration"] = @(3);
    descriptor.params[@"fadeInTime"] = @(1);
    descriptor.params[@"fadeOutTime"] = @(1);
    descriptor.params[@"direction"] = @(direction);
    descriptor.params[@"side"] = @(side);
    return descriptor;
}

/// 生成精灵描述 - 过场图片弹幕
- (BarrageDescriptor *)walkImageSpriteDescriptorWithDirection:(NSInteger)direction
{
    BarrageDescriptor * descriptor = [[BarrageDescriptor alloc]init];
    descriptor.spriteName = NSStringFromClass([BarrageWalkImageSprite class]);
    descriptor.params[@"image"] = [[UIImage imageNamed:@"avatar"]barrageImageScaleToSize:CGSizeMake(20.0f, 20.0f)];
    descriptor.params[@"speed"] = @(100 * (double)random()/RAND_MAX+50);
    descriptor.params[@"direction"] = @(direction);
    descriptor.params[@"trackNumber"] = @5; // 轨道数量
    return descriptor;
}

/// 生成精灵描述 - 浮动图片弹幕
- (BarrageDescriptor *)floatImageSpriteDescriptorWithDirection:(NSInteger)direction
{
    BarrageDescriptor * descriptor = [[BarrageDescriptor alloc]init];
    descriptor.spriteName = NSStringFromClass([BarrageFloatImageSprite class]);
    descriptor.params[@"image"] = [[UIImage imageNamed:@"avatar"]barrageImageScaleToSize:CGSizeMake(40.0f, 15.0f)];
    descriptor.params[@"duration"] = @(3);
    descriptor.params[@"direction"] = @(direction);
    return descriptor;
}

@end
