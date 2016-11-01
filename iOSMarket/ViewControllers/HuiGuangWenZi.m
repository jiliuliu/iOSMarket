//
//  HuiGuangWenZi.m
//  iOSMarket
//
//  Created by liujiliu on 16/10/31.
//  Copyright © 2016年 six. All rights reserved.
//

#import "HuiGuangWenZi.h"

@interface HuiGuangWenZi ()
@property (nonatomic, strong) NSMutableArray *colors;
@end

@implementation HuiGuangWenZi

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 70)];
    label.text = @"我亮吗,我亮不亮";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:40.f];
    label.textColor = [UIColor redColor];
    label.center = self.view.center;
    [self.view addSubview:label];
    
    UIGraphicsBeginImageContextWithOptions(label.bounds.size, NO, [UIScreen mainScreen].scale);
    [label.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:label.bounds];
    [[UIColor cyanColor] setFill];
    [path fillWithBlendMode:kCGBlendModeSourceAtop alpha:1.0];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = label.bounds;
    imageLayer.contents = (__bridge id)image.CGImage;
    imageLayer.shadowOpacity = 1.0f;
    imageLayer.shadowOffset = CGSizeZero;
    imageLayer.shadowColor = [UIColor purpleColor].CGColor;
    imageLayer.shadowRadius = 5.;
    [label.layer addSublayer:imageLayer];
    [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        static int i = 0;
        [imageLayer removeAnimationForKey:@"ani"];
        CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"opacity"];
        ani.fromValue = [NSNumber numberWithFloat:i%2 ? 0.f : 1.f];
        ani.toValue = [NSNumber numberWithFloat:i%2 ? 1.f : 0.f];
        ani.removedOnCompletion = NO;
        ani.fillMode = kCAFillModeForwards;
        ani.duration = 0.8;
        [imageLayer addAnimation:ani forKey:@"ani"];
        i++;
    }];
}

- (void)test0 {

}

- (void)test1 {
    
}

- (NSMutableArray *)colors {
    if (!_colors) {
        _colors = [NSMutableArray array];
        for (NSInteger i=0; i<=360; i+=5) {
            id color = (id)([UIColor colorWithHue:i/360.0 saturation:1 brightness:1 alpha:1].CGColor);
            [_colors addObject:color];
        }
    }
    return _colors;
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
