//
//  SEEK.m
//  iOSMarket
//
//  Created by liujiliu on 16/10/25.
//  Copyright © 2016年 six. All rights reserved.
//

#import "SEEK.h"
#import "UIBezierPath+TextPaths.h"

@interface SEEK ()

@property (nonatomic, copy) NSMutableArray *colors;

@property (nonatomic, strong) CABasicAnimation *animation;

@property (nonatomic, weak) CAGradientLayer *gradientLayer;

@end

@implementation SEEK

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupViews];
}

- (void)setupViews {
//    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectZero];
//    textView.font = [UIFont systemFontOfSize:20];
//    textView.scrollEnabled = NO;
//    textView.editable = NO;
//    textView.textColor = [UIColor whiteColor];
//    textView.backgroundColor = nil;
//    [self.view addSubview:textView];
//    
//    textView.text = [self text];
//    CGSize size = [textView sizeThatFits:CGSizeMake(kScreenWidth, 1000)];
//    textView.bounds = CGRectMake(0, 0, size.width, size.height);
//    textView.center = self.view.center;
//    
    UIBezierPath *textPath = [UIBezierPath pathForString:[self text] withFont:[UIFont systemFontOfSize:20]];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = textPath.CGPath;
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, kScreenWidth-100, kScreenHeight);
    gradientLayer.position = self.view.center;
    gradientLayer.colors = self.colors;
    gradientLayer.mask = shapeLayer;
    [self.view.layer addSublayer:gradientLayer];
    self.gradientLayer = gradientLayer;
    [gradientLayer addAnimation:self.animation forKey:nil];
}

- (NSMutableArray *)colors {
    if (!_colors) {
        for (NSInteger i=0; i<=360; i+=5) {
            [_colors addObject:(id)[UIColor colorWithHue:i/360.0 saturation:1 brightness:1 alpha:1]];
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
        _animation.duration = 1.f;
        _animation.removedOnCompletion = NO;
        _animation.fillMode = kCAFillModeForwards;
        _animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        _animation.delegate = self;
    }
    return _animation;
}



- (NSString *)text {
    return @"   不喜欢无事可做，所以应有所追求。。。";
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    self.gradientLayer.colors = self.animation.toValue;
    [self.gradientLayer removeAllAnimations];
    [self.gradientLayer addAnimation:self.animation forKey:nil];
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
