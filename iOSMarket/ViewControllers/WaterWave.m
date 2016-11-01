//
//  WaterWave.m
//  iOSMarket
//
//  Created by liujiliu on 16/10/31.
//  Copyright © 2016年 six. All rights reserved.
//

#import "WaterWave.h"

@interface WaterWave ()

@end

@implementation WaterWave

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor  = [UIColor blackColor];
    
    // shapeLayer
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    circleLayer.frame         = (CGRect){CGPointMake(0, 0), CGSizeMake(200, 200)};
    circleLayer.position      = self.view.center;
    circleLayer.path          = [self path1].CGPath;
    circleLayer.fillColor     = [UIColor redColor].CGColor;
    circleLayer.strokeColor   = [UIColor redColor].CGColor;
    circleLayer.lineWidth     = 2.f;
    [self.view.layer addSublayer:circleLayer];
    
    // 定时器
    [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        static int i = 0;
        if (i++ % 2 == 0)
        {
            CABasicAnimation *circleAnim = [CABasicAnimation animationWithKeyPath:@"path"];
            circleAnim.removedOnCompletion = NO;
            circleAnim.duration  = 1;
            circleAnim.fromValue = (__bridge id)(circleLayer.path);
            circleAnim.toValue   = (__bridge id)[self path2].CGPath;
            circleLayer.path = [self path2].CGPath;
            [circleLayer addAnimation:circleAnim forKey:@"animateCirclePath"];
        }
        else
        {
            CABasicAnimation *circleAnim = [CABasicAnimation animationWithKeyPath:@"path"];
            circleAnim.removedOnCompletion = NO;
            circleAnim.duration  = 1;
            circleAnim.fromValue = (__bridge id)(circleLayer.path);
            circleAnim.toValue   = (__bridge id)[self path1].CGPath;
            circleLayer.path = [self path1].CGPath;
            [circleLayer addAnimation:circleAnim forKey:@"animateCirclePath"];
        }
    }];
}

- (UIBezierPath *)path1
{
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(0.5, 38.5)];
    [bezierPath addCurveToPoint: CGPointMake(124.5, 38.5) controlPoint1: CGPointMake(0.5, 38.5) controlPoint2: CGPointMake(74.82, 114.88)];
    [bezierPath addCurveToPoint: CGPointMake(240.5, 38.5) controlPoint1: CGPointMake(174.18, -37.88) controlPoint2: CGPointMake(240.5, 38.5)];
    [bezierPath addLineToPoint: CGPointMake(240.5, 120.5)];
    [bezierPath addLineToPoint: CGPointMake(0.5, 120.5)];
    [bezierPath addLineToPoint: CGPointMake(0.5, 38.5)];
    [bezierPath closePath];
    
    return bezierPath;
}

- (UIBezierPath *)path2
{
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(0.5, 38.5)];
    [bezierPath addCurveToPoint: CGPointMake(124.5, 38.5) controlPoint1: CGPointMake(0.5, 38.5) controlPoint2: CGPointMake(64.14, -22.65)];
    [bezierPath addCurveToPoint: CGPointMake(240.5, 38.5) controlPoint1: CGPointMake(184.86, 99.65) controlPoint2: CGPointMake(240.5, 38.5)];
    [bezierPath addLineToPoint: CGPointMake(240.5, 120.5)];
    [bezierPath addLineToPoint: CGPointMake(0.5, 120.5)];
    [bezierPath addLineToPoint: CGPointMake(0.5, 38.5)];
    [bezierPath closePath];
    
    return bezierPath;
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
