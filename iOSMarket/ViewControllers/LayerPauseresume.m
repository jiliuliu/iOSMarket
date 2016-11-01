//
//  LayerPauseresume.m
//  iOSMarket
//
//  Created by liujiliu on 16/11/1.
//  Copyright © 2016年 six. All rights reserved.
//

#import "LayerPauseresume.h"

@interface LayerPauseresume () <CAAnimationDelegate, CALayerDelegate>
@property (nonatomic, strong) CALayer *myLayer;
@end

@implementation LayerPauseresume

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // layer
    CALayer *layer        = [CALayer layer];
    layer.frame           = CGRectMake(100, 100, 3, 3);
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.anchorPoint = CGPointMake(0, 0);
//    layer.delegate        = self;
    [self.view.layer addSublayer:layer];
    self.myLayer = layer;
    
    // 动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    animation.fromValue         = [NSValue valueWithCGRect:layer.bounds];
    animation.toValue           = [NSValue valueWithCGRect:CGRectMake(0, 0, 200, 3)];
    animation.repeatCount = 100;
    animation.duration          = 3.f;
    animation.delegate          = self;                   // 设置代理
    [layer addAnimation:animation forKey:@"YouXianMing"]; // 添加动画
    
    
    UIButton *pause = [UIButton buttonWithType:UIButtonTypeSystem];
    [pause setTitle:@"pause" forState:UIControlStateNormal];
    pause.frame = CGRectMake(50, kScreenHeight-100, 70, 50);
    [pause addTarget:self action:@selector(pauseLayer:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pause];
    
    UIButton *resume = [UIButton buttonWithType:UIButtonTypeSystem];
    [resume setTitle:@"resume" forState:UIControlStateNormal];
    resume.frame = CGRectMake(170, kScreenHeight-100, 70, 50);
    [resume addTarget:self action:@selector(resumeLayer:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resume];
    
    UIButton *remove = [UIButton buttonWithType:UIButtonTypeSystem];
    [remove setTitle:@"remove" forState:UIControlStateNormal];
    remove.frame = CGRectMake(290, kScreenHeight-100, 70, 50);
    [remove addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:remove];

}

/**
 *  动画确实停止了
 *
 *  @param anim CAAnimation对象
 *  @param flag 是否是正常的移除
 */
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"动画:%@ 是否动画中途被移除了:%d", anim, flag);
}

/**
 *  暂停
 *
 *  @param layer 被停止的layer
 */
-(void)pauseLayer:(CALayer*)layer
{   layer = self.myLayer;
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed               = 0.0;
    layer.timeOffset          = pausedTime;
}

/**
 *  恢复
 *
 *  @param layer 被恢复的layer
 */
-(void)resumeLayer:(CALayer*)layer
{
    layer = self.myLayer;
    CFTimeInterval pausedTime     = [layer timeOffset];
    layer.speed                   = 1.0;
    layer.timeOffset              = 0.0;
    layer.beginTime               = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime               = timeSincePause;
}

- (void)remove {
    [self.myLayer removeAnimationForKey:@"YouXianMing"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
