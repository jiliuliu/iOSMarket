//
//  MoveableColor.m
//  iOSMarket
//
//  Created by liujiliu on 16/11/2.
//  Copyright © 2016年 six. All rights reserved.
//

#import "MoveableColor.h"

@interface MoveableColor ()

@end

@implementation MoveableColor

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont fontWithName:@"AvenirNext-ULtraLight" size:25.f];
    label.text = @"床前明月光，疑是地上霜。";
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    [label sizeToFit];
    label.center = self.view.center;
    label.textColor = [UIColor whiteColor];
    [self.view addSubview:label];
    
    
    UILabel *maskLabel = [[UILabel alloc] init];
    maskLabel.font = [UIFont fontWithName:@"AvenirNext-ULtraLight" size:25.f];
    maskLabel.text = @"床前明月光，疑是地上霜。";
    maskLabel.textColor = [UIColor cyanColor];
    maskLabel.numberOfLines = 0;
    maskLabel.textAlignment = NSTextAlignmentCenter;
    [maskLabel sizeToFit];
    maskLabel.center = self.view.center;
    [self.view addSubview:maskLabel];
    
    // 创建出渐变的layer
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame            = maskLabel.bounds;
    gradientLayer.colors           = @[(__bridge id)[UIColor clearColor].CGColor,
                                       (__bridge id)[UIColor blackColor].CGColor,
                                       (__bridge id)[UIColor blackColor].CGColor,
                                       (__bridge id)[UIColor clearColor].CGColor];
    gradientLayer.locations        = @[@(0.01), @(0.2), @(0.4), @(0.59)];
    gradientLayer.startPoint       = CGPointMake(0, 0);
    gradientLayer.endPoint         = CGPointMake(1, 0);
    
    // 创建并接管mask
    UIView *maskView     = [[UIView alloc] initWithFrame:maskLabel.bounds];
    // mask获取渐变layer
    [maskView.layer addSublayer:gradientLayer];
    
    maskView.frame    = CGRectMake(-maskLabel.w, 0, maskLabel.w, maskLabel.h);
    
    maskLabel.maskView = maskView;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 repeats:YES block:^(NSTimer * _Nonnull timer) {
        
        [UIView animateWithDuration:2.5 animations:^{
            maskView.frame    = CGRectMake(1.5*maskLabel.w, 0, maskLabel.w, maskLabel.h);
        } completion:^(BOOL finished) {
            maskView.frame    = CGRectMake(-0.5*maskLabel.w, 0, maskLabel.w, maskLabel.h);
        }];
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
