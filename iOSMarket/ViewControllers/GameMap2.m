//
//  GameMap2.m
//  iOSMarket
//
//  Created by liujiliu on 16/10/25.
//  Copyright © 2016年 six. All rights reserved.
//

#import "GameMap2.h"

@interface GameMap2 ()

@property (nonatomic, strong) UIImageView *person;

@end

@implementation GameMap2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImage *image = [UIImage imageNamed:@"GameMap"];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor redColor];
    scrollView.bounces = NO;
//    scrollView.scrollEnabled = NO;
    scrollView.contentSize = image.size;
    scrollView.layer.masksToBounds = YES;
    [scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
    [self.view addSubview:scrollView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    imageView.image = image;
    [scrollView addSubview:imageView];
    
  
    self.person = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    self.person.image = [UIImage animatedImageNamed:@"person" duration:1];
    self.person.center = self.view.center;
    [self.view addSubview:self.person];
}

- (void)tapAction:(UITapGestureRecognizer *)sender {
    UIScrollView *scrollView = (UIScrollView *)(sender.view);
    CGPoint point = [sender locationInView:scrollView];
    CGFloat x = point.x-self.view.center.x;
    CGFloat y = point.y-self.view.center.y;
    CGFloat px = self.view.center.x;
    CGFloat py = self.view.center.y;
    if (point.x<self.view.center.x || point.x>scrollView.contentSize.width-self.view.center.x) {
        x = scrollView.contentOffset.x;
        px = [sender locationInView:self.view].x;
    }
    if (point.y<self.view.center.y || point.y>scrollView.contentSize.height-self.view.center.y) {
        y = scrollView.contentOffset.y;
        py = [sender locationInView:self.view].y;
    }
    [UIView animateWithDuration:1 animations:^{
        self.person.center = CGPointMake(px, py);
        [scrollView setContentOffset:CGPointMake(x, y)];
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
