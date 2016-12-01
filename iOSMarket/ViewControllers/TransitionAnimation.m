//
//  TransitionAnimation.m
//  iOSMarket
//
//  Created by liujiliu on 16/11/8.
//  Copyright © 2016年 six. All rights reserved.
//

#import "TransitionAnimation.h"

@interface TransitionAnimation ()

@end

@implementation TransitionAnimation

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"image2"];
    imageView.tag = 10;
    imageView.hidden = YES;
    [self.view addSubview:imageView];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView1.image = [UIImage imageNamed:@"image3"];
    imageView1.tag = 11;
    [self.view addSubview:imageView1];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIImageView *imageView = [self.view viewWithTag:10];
    UIImageView *imageView1 = [self.view viewWithTag:11];
    
    CATransition* transition = [CATransition animation];
    transition.startProgress = 0;
    transition.endProgress = 1.0;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    transition.duration = 0.5;
    // 两个图层加入过渡动画
    [imageView.layer addAnimation:transition forKey:@"transition"];
    [imageView1.layer addAnimation:transition forKey:@"transition"];
    // 最后，改变图层的可视性
    imageView.hidden = !imageView.hidden;
    imageView1.hidden = !imageView1.hidden;
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
