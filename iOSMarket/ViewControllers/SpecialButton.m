//
//  MaskButton.m
//  iOSMarket
//
//  Created by liujiliu on 16/10/31.
//  Copyright © 2016年 six. All rights reserved.
//

#import "SpecialButton.h"
#import "SIXButton.h"
#import "ZoomButton.h"

@interface SpecialButton ()

@end

@implementation SpecialButton

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self test];
    [self test0];
    [self test1];
}

#pragma mark - 不同对齐方式按钮
- (void)test0 {
    [self addButton:CGRectMake(100, 200, 200, 50) andType:0];
    [self addButton:CGRectMake(100, 300, 120, 50) andType:1];
    [self addButton:CGRectMake(100, 400, 120, 50) andType:2];
    [self addButton:CGRectMake(100, 500, 50, 70) andType:3];
}

- (void)addButton:(CGRect)frame andType:(SIXButtonAlignmentType)type {
    SIXButton *button = [SIXButton buttonWithType:UIButtonTypeSystem];
    button.backgroundColor = [UIColor cyanColor];
    button.alignmentType = type;
    button.frame = frame;
    [button setTitle:@"撒大大说的" forState:UIControlStateNormal];
    [button setImage:[[UIImage imageNamed:@"tabbar_compose_lbs"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:button];
}

#pragma mark - 缩放按钮
- (void)test1 {
    ZoomButton *zoom = [[ZoomButton alloc] initWithFrame:CGRectMake(kScreenWidth-250, kScreenHeight-150, 120, 80)];
    [zoom.button setTitle:@"放大" forState:UIControlStateNormal];
    [zoom.button setImage:[[UIImage imageNamed:@"tabbar_compose_lbs"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    zoom.scaleValue = 0.7;
    [self.view addSubview:zoom];
    
}

#pragma mark - 圆角按钮
- (void)test {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(50, 100, 100, 60);
    button.layer.mask = [self shapeLayer:YES andFrame:button.bounds];
    [button setTitle:@"发的地位" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor greenColor];
    [self.view addSubview:button];
   
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    button1.frame = CGRectMake(50+110, 100, 100, 60);
    button1.layer.mask = [self shapeLayer:NO andFrame:button1.bounds];
    [button1 setTitle:@"安抚按位" forState:UIControlStateNormal];
    button1.backgroundColor = [UIColor redColor];
    [self.view addSubview:button1];
}


- (CAShapeLayer *)shapeLayer:(BOOL)corner andFrame:(CGRect)bounds {
    UIRectCorner corners;
    if (corner) {
        corners = UIRectCornerTopLeft | UIRectCornerBottomLeft;
    } else {
        corners = UIRectCornerTopRight | UIRectCornerBottomRight;
    }
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:corners cornerRadii:CGSizeMake(bounds.size.height/2.0, bounds.size.height/2.0)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.frame = bounds;
    return shapeLayer;
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
