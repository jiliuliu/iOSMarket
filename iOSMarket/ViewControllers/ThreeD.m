//
//  ThreeD.m
//  iOSMarket
//
//  Created by liujiliu on 16/10/28.
//  Copyright © 2016年 six. All rights reserved.
//

#import "ThreeD.h"

@interface ThreeD ()

@end

@implementation ThreeD

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    
    // 普通的一个layer
    CALayer *plane1        = [CALayer layer];
    plane1.anchorPoint = CGPointMake(0.5, 0.5);                         // 锚点
    plane1.frame       = (CGRect){CGPointZero, CGSizeMake(100, 100)};   // 尺寸
    plane1.position    = CGPointMake(self.view.center.x, self.view.center.y);                  // 位置
    plane1.opacity         = 0.6;                                       // 背景透明度
    plane1.backgroundColor = RGB_COLOR(1, 0, 0, 1).CGColor;                      // 背景色
    plane1.borderWidth     = 3;                                         // 边框宽度
    plane1.borderColor     = RGB_COLOR(1, 1, 1, 0.5).CGColor;                    // 边框颜色(设置了透明度)
    plane1.cornerRadius    = 10;                                        // 圆角值
    
    // Z轴平移
    CATransform3D plane1_3D = CATransform3DIdentity;
    plane1_3D               = CATransform3DTranslate(plane1_3D, 0, 0, -10);
    plane1.transform        = plane1_3D;
    
    // 普通的一个layer
    CALayer *plane2        = [CALayer layer];
    plane2.anchorPoint = CGPointMake(0.5, 0.5);                         // 锚点
    plane2.frame       = (CGRect){CGPointZero, CGSizeMake(100, 100)};   // 尺寸
    plane2.position    = CGPointMake(self.view.center.x, self.view.center.y);                  // 位置
    plane2.opacity         = 0.6;                                       // 背景透明度
    plane2.backgroundColor = RGB_COLOR(0, 1, 0, 1).CGColor;                      // 背景色
    plane2.borderWidth     = 3;                                         // 边框宽度
    plane2.borderColor     = RGB_COLOR(1, 1, 1, 0.5).CGColor;                    // 边框颜色(设置了透明度)
    plane2.cornerRadius    = 10;                                        // 圆角值
    
    // Z轴平移
    CATransform3D plane2_3D = CATransform3DIdentity;
    plane2_3D               = CATransform3DTranslate(plane2_3D, 0, 0, -30);
    plane2.transform        = plane2_3D;
    
    // 创建容器layer
    CATransformLayer *container = [CATransformLayer layer];
    container.frame    = self.view.bounds;
    [self.view.layer addSublayer:container];
    [container addSublayer:plane1];
    [container addSublayer:plane2];
    
    
    [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        static float degree = 0.f;
        [container removeAnimationForKey:@"transform"];
        
        CATransform3D fromValue = CATransform3DIdentity;
        fromValue.m34 = 1.0/ -500;
        fromValue = CATransform3DRotate(fromValue, degree, 0, 1, 0);
        CATransform3D toValue = CATransform3DIdentity;
        toValue.m34 = 1.0/ -500;
        toValue = CATransform3DRotate(toValue, degree += 45.f, 0, 1, 0);
        
        CABasicAnimation *transform3D = [CABasicAnimation animationWithKeyPath:@"transform"];
        transform3D.duration = 1.f;
        transform3D.fromValue = [NSValue valueWithCATransform3D:fromValue];
        transform3D.toValue = [NSValue valueWithCATransform3D:toValue];
        [container addAnimation:transform3D forKey:@"transform"];
    }];
    
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
