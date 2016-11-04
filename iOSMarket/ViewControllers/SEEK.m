//
//  SEEK.m
//  iOSMarket
//
//  Created by liujiliu on 16/10/25.
//  Copyright © 2016年 six. All rights reserved.
//

#import "SEEK.h"
#import "UIBezierPath+TextPaths.h"

@interface SEEK () <CAAnimationDelegate>

@property (nonatomic, copy) NSMutableArray *colors;

@property (nonatomic, strong) CABasicAnimation *animation;

@property (nonatomic, weak) CAGradientLayer *gradientLayer;

@property (nonatomic, weak) CAShapeLayer *shapeLayer;

@property (nonatomic, weak) NSTimer *timer;

@end

@implementation SEEK

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor blackColor];
    [self setupViews];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)setupViews {
    
    UIView *view = [[UIView alloc] initWithFrame:UIEdgeInsetsInsetRect(self.view.bounds, UIEdgeInsetsMake(100, 50, 100, 50))];
    [self.view addSubview:view];
    
    UIBezierPath *textPath = [UIBezierPath pathForString:[self text] withFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:20.f]];
//    UIBezierPath *textPath = [UIBezierPath pathForMultilineString:[self text] withFont:[UIFont systemFontOfSize:80.f] maxWidth:kScreenWidth textAlignment:NSTextAlignmentCenter];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.bounds = CGPathGetBoundingBox(textPath.CGPath);
    shapeLayer.position = self.view.center;
    shapeLayer.strokeEnd = 0.f;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
//    shapeLayer.shadowOffset = CGSizeMake(5, 5);
//    shapeLayer.shadowColor = [UIColor whiteColor].CGColor;
//    shapeLayer.shadowRadius = 5;
//    shapeLayer.shadowOpacity = 1;
    
//    shapeLayer.geometryFlipped = YES;
    shapeLayer.path = textPath.CGPath;
    self.shapeLayer = shapeLayer;
  
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.view.bounds;
    gradientLayer.colors = self.colors;
    gradientLayer.mask = shapeLayer;
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    [self.view.layer addSublayer:gradientLayer];
    self.gradientLayer = gradientLayer;
    [gradientLayer addAnimation:self.animation forKey:nil];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.3 repeats:YES block:^(NSTimer * _Nonnull timer) {
        static BOOL value = YES;
        if (value) {
            shapeLayer.strokeEnd += 0.01;
        } else {
            shapeLayer.strokeEnd -= 0.01;
        }
        if (shapeLayer.strokeEnd >= 1) {
            value = NO;
        } else if (shapeLayer.strokeEnd <= 0) {
            value = YES;
        }
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.timer invalidate];
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

- (void)loopColors {
    id lastObj = self.colors.lastObject;
    [self.colors removeLastObject];
    [self.colors insertObject:lastObj atIndex:0];
}

- (CABasicAnimation *)animation {
    if (!_animation) {
        _animation = [CABasicAnimation animationWithKeyPath:@"colors"];
        _animation.fromValue = self.colors;
        [self loopColors];
        _animation.toValue = self.colors;
        _animation.duration = 0.1f;
        _animation.removedOnCompletion = NO;
        _animation.fillMode = kCAFillModeForwards;
        _animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        _animation.delegate = self;
    }
    return _animation;
}



- (NSString *)text {
    return @"   不喜欢无事可做，所以应有所追求。。。";
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    self.gradientLayer.colors = self.animation.toValue;
    self.animation = nil;
    [self.gradientLayer removeAllAnimations];
    [self.gradientLayer addAnimation:self.animation forKey:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 第二种实现方式
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    UILabel *label = [[UILabel alloc] init];
//    label.text = @"什么单位， 请问的";
//    [label sizeToFit];
//    label.center = self.view.center;
//    [self.view addSubview:label];
//    
//    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//    gradientLayer.frame = label.frame;
//    gradientLayer.mask = label.layer;
//    label.frame = gradientLayer.bounds;
//    gradientLayer.startPoint = CGPointMake(0, 0);
//    gradientLayer.endPoint = CGPointMake(1, 0);
//    gradientLayer.colors = @[[self randomColor], [self randomColor], [self randomColor]];
//    [self.view.layer addSublayer:gradientLayer];
//    self.gradientLayer = gradientLayer;
//    
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.3 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        [self textColorChange];
//    }];
//    NSLog(@"%ld", self.view.subviews.count);
//}
//
//
//-(id)randomColor{
//    CGFloat r = arc4random_uniform(256) / 255.0;
//    CGFloat g = arc4random_uniform(256) / 255.0;
//    CGFloat b = arc4random_uniform(256) / 255.0;
//    return (__bridge id)[UIColor colorWithRed:r green:g blue:b alpha:1].CGColor;
//}
//
//-(void)textColorChange {
//    _gradientLayer.colors = @[[self randomColor],
//                              [self randomColor],
//                              [self randomColor],
//                              [self randomColor],
//                              [self randomColor]];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
