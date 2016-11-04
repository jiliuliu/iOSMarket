//
//  SIXProgressBar.m
//  iOSMarket
//
//  Created by liujiliu on 16/11/4.
//  Copyright © 2016年 six. All rights reserved.
//

#import "SIXProgressBar.h"

@interface SIXProgressBar ()

/**  底部轨道颜色  */
@property (nonatomic, strong) UIColor *trackColor;

/**  进度条颜色 */
@property (nonatomic, strong) NSArray *progressBarColors;

/**  文字颜色  */
@property (nonatomic, strong) UIColor *textColor;

/**  进度条的高  */
@property (nonatomic, assign) CGFloat progressBarHeight;

/**  label的宽  */
@property (nonatomic, assign) CGFloat progressBarWidth;

/**  轨道图层  */
@property (nonatomic, weak) CALayer *trackLayer;

/**  进度条图层  */
@property (nonatomic, weak) CALayer *progressLayer;

/**  颜色渐变图层  */
@property (nonatomic, weak) CAGradientLayer *gradientLayer;

@property (nonatomic, weak) CALayer *maskLayer;

@property (nonatomic, weak) CALayer *circleLayer;

@property (nonatomic, weak) CALayer *whiteCircleLayer;

/**  进度文字显示  */
@property (nonatomic, weak) UILabel *progressLabel;


@end

@implementation SIXProgressBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
        [self setupViews];
    }
    return self;
}

- (void)commonInit {
    _trackColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    _textColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    _progressBarHeight = 8.f;
    _progress = 0.f;
    _progressBarColors = @[(__bridge id)[UIColor colorWithRed:1.0 green:165/255.0 blue:71/255.0 alpha:1].CGColor,
                           (__bridge id)[UIColor colorWithRed:1.0 green:69/255.0 blue:0 alpha:1].CGColor,
                           (__bridge id)[UIColor colorWithRed:1.0 green:0 blue:0 alpha:1].CGColor];
}

- (void)setupViews {
    CALayer *trackLayer = [CALayer layer];
    trackLayer.cornerRadius = _progressBarHeight*0.5;
    trackLayer.masksToBounds = YES;
    trackLayer.backgroundColor = _trackColor.CGColor;
    [self.layer addSublayer:trackLayer];
    
    CALayer *maskLayer = [CALayer layer];
 
    CALayer *progressLayer = [CALayer layer];
    progressLayer.backgroundColor = [UIColor blackColor].CGColor;
    progressLayer.cornerRadius = _progressBarHeight*0.5;
    progressLayer.masksToBounds = YES;
    [maskLayer addSublayer:progressLayer];
    
    CALayer *circleLayer = [CALayer layer];
    circleLayer.backgroundColor = [UIColor blackColor].CGColor;
    circleLayer.cornerRadius = _progressBarHeight;
    circleLayer.masksToBounds = YES;
    [maskLayer addSublayer:circleLayer];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = self.progressBarColors;
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.mask = maskLayer;
    [self.layer addSublayer:gradientLayer];
    
    CALayer *whiteCircleLayer = [CALayer layer];
    whiteCircleLayer.backgroundColor = [UIColor whiteColor].CGColor;
    whiteCircleLayer.cornerRadius = _progressBarHeight*0.5;
    whiteCircleLayer.masksToBounds = YES;
    [self.layer addSublayer:whiteCircleLayer];
    
    UILabel *progressLabel = [[UILabel alloc] init];
    progressLabel.text = @"进度：0%";
    progressLabel.font = [UIFont systemFontOfSize:12];
    progressLabel.textAlignment = NSTextAlignmentCenter;
    progressLabel.textColor = self.textColor;
    [self addSubview:progressLabel];

    _trackLayer = trackLayer;
    _progressLayer = progressLayer;
    _gradientLayer = gradientLayer;
    _progressLabel = progressLabel;
    _circleLayer = circleLayer;
    _maskLayer = maskLayer;
    _whiteCircleLayer = whiteCircleLayer;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSLog(@"layoutSubviews");
    
    CGRect frame = self.bounds;
    CGFloat labelWidth = MIN(CGRectGetWidth(frame)*0.2, 70.f);
    CGFloat trackY = (CGRectGetHeight(frame) - _progressBarHeight)*0.5;
    
    _progressBarWidth = CGRectGetWidth(frame) - labelWidth;
    _progressLabel.frame = CGRectMake(_progressBarWidth, 0, labelWidth, CGRectGetHeight(frame));
    _trackLayer.frame = CGRectMake(0, trackY, _progressBarWidth, _progressBarHeight);
    _gradientLayer.frame = CGRectMake(0, 0, _progressBarWidth, CGRectGetHeight(frame));
    _maskLayer.frame = _gradientLayer.bounds;
//    _progressLayer.frame = CGRectMake(-_progressBarWidth, trackY, _progressBarWidth, _progressBarHeight);
    _progressLayer.frame = CGRectMake(0, (CGRectGetHeight(frame) - _progressBarHeight)*0.5, _progressBarHeight*0.5, _progressBarHeight);
    _progressLayer.anchorPoint = CGPointMake(0, 0.5);
    _circleLayer.frame = CGRectMake(0, (CGRectGetHeight(frame)-_progressBarHeight*2)*0.5, _progressBarHeight*2, _progressBarHeight*2);
    _whiteCircleLayer.frame = CGRectMake(_progressBarHeight*0.5, trackY, _progressBarHeight, _progressBarHeight);
}

static NSString * const kPregressBarAnimationKey = @"kPregressBarAnimationKey";
- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    if (progress >=1) {
        progress = 1.0;
    } else if (progress <=0) {
        progress = 0.0;
    }

//    _progressLayer.position = CGPointMake(_progressBarWidth*(progress - 0.5), _progressLayer.position.y);
    CGRect bounds = _progressLayer.bounds;
    bounds.size.width = (_progressBarWidth-_progressBarHeight)*progress + 0.5*_progressBarHeight;
    CGPoint point = _circleLayer.position;
    point.x = (_progressBarWidth-_progressBarHeight*2)*progress + _progressBarHeight;
    
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanFalse forKey:kCATransactionDisableActions];
    [CATransaction setValue:[NSNumber numberWithFloat:1.0f] forKey:kCATransactionAnimationDuration];
    _circleLayer.position = point;
    _whiteCircleLayer.position = point;
    _progressLayer.bounds = bounds;
    [CATransaction commit];

    _progressLabel.text = [NSString stringWithFormat:@"进度：%d%%", (int)roundf(progress*100.0)];
}

- (UIBezierPath *)createBezierPath {
    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(_progressBarHeight*0.5, (CGRectGetHeight(frame) - _progressBarHeight)*0.5)];
    return path;
}



- (void)setFrame:(CGRect)frame {
    NSLog(@"%@", NSStringFromCGRect(frame));
    [super setFrame:frame];
}

@end
