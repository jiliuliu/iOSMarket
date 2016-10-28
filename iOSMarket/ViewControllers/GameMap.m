//
//  GameMap.m
//  iOSMarket
//
//  Created by liujiliu on 16/10/25.
//  Copyright © 2016年 six. All rights reserved.
//

#import "GameMap.h"

@interface GameMap ()

@end

@implementation GameMap

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image3"]];
    bgImageView.frame = self.view.bounds;
    [self.view addSubview:bgImageView];
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectView.frame = self.view.bounds;
    [bgImageView addSubview:effectView];
    
    UIView *panView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 150, 150)];
    panView.layer.cornerRadius = 75.f;
    panView.clipsToBounds = YES;
    [panView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)]];
    [self.view addSubview:panView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image3"]];
    [panView addSubview:imageView];
    imageView.frame = [imageView convertRect:self.view.bounds fromView:self.view];
    
}

- (void)panAction:(UIPanGestureRecognizer *)sender {
    UIView *panView = sender.view;
    UIImageView *imageView = panView.subviews.firstObject;
    CGPoint point = [sender translationInView:panView];
    panView.center = CGPointMake(panView.center.x+point.x, panView.center.y+point.y);
    imageView.center = CGPointMake(imageView.center.x-point.x, imageView.center.y-point.y);
    [sender setTranslation:CGPointZero inView:panView];
    
//    NSLog(@"%@", NSStringFromCGPoint(point));
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
