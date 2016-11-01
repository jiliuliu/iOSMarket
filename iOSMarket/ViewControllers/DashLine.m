//
//  DashLine.m
//  iOSMarket
//
//  Created by liujiliu on 16/11/1.
//  Copyright © 2016年 six. All rights reserved.
//

#import "DashLine.h"

@interface DashLine ()

@end

@implementation DashLine

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    int a = 0 , b = 0;
    NSLog(@"%d, %d", a++, ++b);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 300, 1)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = CGRectMake(0, 0, 300, 1);
    shapeLayer.position = self.view.center;
    shapeLayer.strokeStart = 0.f;
    shapeLayer.strokeEnd = 0.499;  //这个很重要   虽然不知道为什么
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.path = path.CGPath;
    shapeLayer.lineDashPattern = @[@10, @10, @20, @20];
    [self.view.layer addSublayer:shapeLayer];
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
