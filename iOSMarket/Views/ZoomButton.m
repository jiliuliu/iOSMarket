//
//  ZoomButton.m
//  iOSMarket
//
//  Created by liujiliu on 16/11/1.
//  Copyright © 2016年 six. All rights reserved.
//

#import "ZoomButton.h"
#import "POP.h"
#import "SIXButton.h"

@interface ZoomButton ()<POPAnimationDelegate>

@end


@implementation ZoomButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _button  = [[UIButton alloc] initWithFrame:self.bounds];
        [self addSubview:_button];
        
        self.userInteractionEnabled = YES;
        //按住按钮后没有松手的动画
        [_button addTarget:self action:@selector(scaleToSmall) forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragEnter];
        
        //按住按钮松手后和拖拽出去的动画
        [_button addTarget:self action:@selector(scaleToDefault) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchDragExit];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    _button.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
}

- (void)scaleToSmall {
    NSLog(@"small");
    CGFloat tmpScale = (_scaleValue > 0)? _scaleValue : 0.7;
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(tmpScale, tmpScale)];
    scaleAnimation.delegate = self;
    [self.layer pop_addAnimation:scaleAnimation forKey:nil];
    [self performSelector:@selector(performSelectorEvent) withObject:nil afterDelay:(_completeDurationAfterLongPress > 1.5 ? _completeDurationAfterLongPress : 1.5)];
}

- (void)scaleToDefault {
    NSLog(@"Default");
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.0f, 1.0f)];
    scaleAnimation.delegate = self;
    [self.layer pop_addAnimation:scaleAnimation forKey:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (void)performSelectorEvent
{
    if (_delegate) {
        [_delegate longPressCompleteWithView:self];
    }
}

/**
 *  POP动画代理
 *
 *  @param anim 执行动画的那个对象
 */
- (void)pop_animationDidApply:(POPAnimation *)anim
{
    NSValue *toValue = (NSValue *)[anim valueForKeyPath:@"currentValue"];
    CGSize size      = [toValue CGSizeValue];
    CGFloat tmpScale = (_scaleValue > 0)? _scaleValue : 0.7f;
    _percent         = (size.height - calculateConstant(0, 1, 1, tmpScale))/calculateSlope(0, 1, 1, tmpScale);
    if (_delegate) {
        [_delegate longPressPercentage:_percent view:self];
    }
}

CGFloat calculateSlope(CGFloat x1, CGFloat y1, CGFloat x2, CGFloat y2)
{
    return (y2 - y1) / (x2 - x1);
}

CGFloat calculateConstant(CGFloat x1, CGFloat y1, CGFloat x2, CGFloat y2)
{
    return (y1*(x2 - x1) - x1*(y2 - y1)) / (x2 - x1);
}

- (void)addSubview:(UIView *)view
{
    [super addSubview:view];
    
    /**
     *  如果继承了这个类，则子类不会执行以下方法
     */
    if ([self class] == [SIXButton class]) {
        [self bringSubviewToFront:_button];
    }
}

- (void)activateButtonEffect
{
    [self bringSubviewToFront:_button];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
