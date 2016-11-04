//
//  HYGradientLayer.m
//  DemoCAGradientLayer
//
//  Created by caohongyang on 16/9/9.
//  Copyright © 2016年 ccoop. All rights reserved.
//

#import "HYGradientLayer.h"


#define degreesToRadians(x) (M_PI*(x)/180.0) //把角度转换成PI的方式
#define PROGREESS_WIDTH 100 //圆直径
#define PROGRESS_LINE_WIDTH 4 //弧线的宽度

@interface HYGradientLayer ()

/** 背景 */
@property (nonatomic, strong) CAShapeLayer *trackLayer;

/** 轨道 */
@property (nonatomic, strong) CAShapeLayer* trackerLayer;

/** 进度 */
@property (nonatomic, strong) CAShapeLayer* progressLayer;

/** 白点 */
@property (nonatomic, strong) CAShapeLayer* littleWhiteLayer;

/** 进度绘制 */
@property (nonatomic, strong) UIBezierPath* progressPath;

//@property (nonatomic, strong) CAGradientLayer* gradientLayer;

@end

@implementation HYGradientLayer

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initAttributes];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initAttributes];
    }
    return self;
}
- (void)initAttributes {
    [self.layer addSublayer:self.trackerLayer];
    self.progressPath = [UIBezierPath bezierPath];
    [self progressLayer];
    self.littleWhiteLayer = [CAShapeLayer layer];
    self.littleWhiteLayer.fillColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:self.littleWhiteLayer];
}
- (CAShapeLayer *)trackerLayer {
    CGFloat heigh = self.bounds.size.height;
    CGFloat width = self.bounds.size.width;
    CGFloat max = heigh * .3;
    if (!_trackerLayer) {
        _trackerLayer = [CAShapeLayer layer];
        _trackerLayer.frame = self.bounds;
        _trackerLayer.fillColor = kColorFromHex(0xE1E1E1).CGColor;
        _trackerLayer.strokeColor = kColorFromHex(0xE1E1E1).CGColor;
        UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, (heigh - max) * .5, width, max) cornerRadius:max * .5];
        _trackerLayer.path = path.CGPath;
    }
    return _trackerLayer;
}
- (CAShapeLayer *)progressLayer {
    if (!_progressLayer) {
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.frame = self.bounds;
        _progressLayer.lineCap = kCALineCapRound;//圆角
        CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
        gradientLayer.frame = _progressLayer.bounds;
        [gradientLayer setColors:[NSArray arrayWithObjects:(id)[kColorFromHex(0xFC3F78) CGColor],(id)[kColorFromHex(0xFC6B4E) CGColor], nil]];
        [gradientLayer setLocations:@[@0,@.5]];
        [gradientLayer setStartPoint:CGPointMake(0, 0.5)];
        [gradientLayer setEndPoint:CGPointMake(1, 0.5)];
        [gradientLayer setMask:_progressLayer]; //用progressLayer来截取渐变层
        [self.layer addSublayer:gradientLayer];
    }
    return _progressLayer;
}

- (void)setPercent:(CGFloat)percent {
    CGFloat heigh = self.bounds.size.height;
    CGFloat width = self.bounds.size.width;
    CGFloat radius = heigh * .8 * .5;
    CGFloat min = heigh * .4;
    
    _percent = percent;
    if (percent >= 1) {
        _percent = 1;
    }
    if (percent <= 0) {
        _percent = 0;
    }
    CGFloat current = _percent * width;
    
    if (_percent < 0.4) {
        current = current + min * .4;
    } else if (_percent > 0.6) {
        current = current - radius * 2 - min * .5;
    }
    [self.progressPath removeAllPoints];
    [self.progressPath moveToPoint:CGPointMake(0, (heigh) * .5)];
    /** 起点圆弧 */
    [self.progressPath addArcWithCenter:CGPointMake(min * .5, heigh * .5) radius:min * .5 startAngle:M_PI endAngle:1.5 * M_PI clockwise:YES];
    /** 画直线 */
    [self.progressPath addLineToPoint:CGPointMake(current, (heigh - min) * .5)];
    
    /** 画相切弧1 */
    [self.progressPath addArcWithCenter:CGPointMake(current+1, (heigh - min) * .5 - radius) radius:radius startAngle:M_PI_2 endAngle:M_PI_4 clockwise:NO];
    
    /** 画圆 */
    [self.progressPath addArcWithCenter:CGPointMake(current + radius + min * .5, heigh * .5) radius:radius startAngle:M_PI_4 + M_PI endAngle:M_PI - M_PI_4 clockwise:YES];
    /** 画相切弧2 */
    [self.progressPath addArcWithCenter:CGPointMake(current+1, (heigh - min) * .5 + radius + min) radius:radius startAngle:-M_PI_4 endAngle:-M_PI_2 clockwise:NO];
    
    /** 画直线 */
    [self.progressPath addLineToPoint:CGPointMake(min * .5, (heigh - min) * .5 + min)];
    /** 终点圆弧 */
    [self.progressPath addArcWithCenter:CGPointMake(min * .5, heigh * .5) radius:min * .5 startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
//    [self.progressPath closePath];
    self.progressLayer.path = self.progressPath.CGPath;
    
    /** 绘制中心白色圆 */
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(current + min * .4 + radius, heigh * .5) radius:min * 0.6 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    self.littleWhiteLayer.path = path.CGPath;

}

@end
