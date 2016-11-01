//
//  TestVC.m
//  iOSMarket
//
//  Created by liujiliu on 16/11/1.
//  Copyright © 2016年 six. All rights reserved.
//

#import "TestVC.h"

@interface TestVC ()

@end

@implementation TestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    // 初始化按钮
    UIButton *button       = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    button.backgroundColor = [UIColor redColor];
    button.userInteractionEnabled = NO; // 让self.view获取点击事件（穿透自身）
    button.tag = 100;
    [button addTarget:self
               action:@selector(buttonEvent:)
     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    // 执行动画
    [UIView animateWithDuration:10.f
                          delay:0
                        options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         button.frame = CGRectMake(0, kScreenHeight-100, 100, 100);
                     } completion:^(BOOL finished) {
                         button.userInteractionEnabled = YES;
                     }];
}

/**
 *  按钮事件
 *
 *  @param button 按钮事件
 */
- (void)buttonEvent:(UIButton *)button {
    NSLog(@"YouXianMing");
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // 获取点击点
    CGPoint point = [[touches anyObject] locationInView:self.view];
    UIButton *view = [self.view viewWithTag:100];
    // 获取tmpView的layer当前的位置
    CGPoint presentationPosition = [[view.layer presentationLayer] position];
    
    // 判断位置，让tmpView接受点击事件
    if (point.x > presentationPosition.x - 50 && point.x < presentationPosition.x + 50 &&
        point.y > presentationPosition.y - 50 && point.y < presentationPosition.y + 50) {
        NSLog(@"YouXianMing");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





#pragma mark - 移动中的button点击事件   默认是点击终点坐标才有事件触发
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    self.view.backgroundColor = [UIColor blackColor];
//    
//    // 初始化按钮
//    UIButton *button       = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//    button.backgroundColor = [UIColor redColor];
//    button.userInteractionEnabled = NO; // 让self.view获取点击事件（穿透自身）
//    button.tag = 100;
//    [button addTarget:self
//               action:@selector(buttonEvent:)
//     forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
//    
//    // 执行动画
//    [UIView animateWithDuration:10.f
//                          delay:0
//                        options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
//                     animations:^{
//                         button.frame = CGRectMake(0, kScreenHeight-100, 100, 100);
//                     } completion:^(BOOL finished) {
//                         button.userInteractionEnabled = YES;
//                     }];
//}
//
///**
// *  按钮事件
// *
// *  @param button 按钮事件
// */
//- (void)buttonEvent:(UIButton *)button {
//    NSLog(@"YouXianMing");
//}
//
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    // 获取点击点
//    CGPoint point = [[touches anyObject] locationInView:self.view];
//    UIButton *view = [self.view viewWithTag:100];
//    // 获取tmpView的layer当前的位置
//    CGPoint presentationPosition = [[view.layer presentationLayer] position];
//    
//    // 判断位置，让tmpView接受点击事件
//    if (point.x > presentationPosition.x - 50 && point.x < presentationPosition.x + 50 &&
//        point.y > presentationPosition.y - 50 && point.y < presentationPosition.y + 50) {
//        NSLog(@"YouXianMing");
//    }
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
