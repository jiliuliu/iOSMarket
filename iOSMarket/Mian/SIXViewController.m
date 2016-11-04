//
//  SIXViewController.m
//  iOSMarket
//
//  Created by liujiliu on 16/10/26.
//  Copyright © 2016年 six. All rights reserved.
//

#import "SIXViewController.h"

@interface SIXViewController ()

@end

@implementation SIXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
}

//- (void)viewWillLayoutSubviews {
//    [super viewWillLayoutSubviews];
//    NSLog(@"%s", __func__);
//}
//
//- (void)viewDidLayoutSubviews {
//    [super viewDidLayoutSubviews];
//    NSLog(@"%s", __func__);
//}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    NSLog(@"%s", __func__);
    
    if (!self.navigationController) {
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        backBtn.frame = CGRectMake(kScreenWidth-50, 0, 50, 50);
        [backBtn setTitle:@"done" forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        [[UIApplication sharedApplication].keyWindow addSubview:backBtn];
        [UIApplication sharedApplication].statusBarHidden = YES;
    }
}

//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    NSLog(@"%s", __func__);
//}
//
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    NSLog(@"%s", __func__);
    [self.timer invalidate];
}

//- (void)viewDidDisappear:(BOOL)animated {
//    [super viewDidDisappear:animated];
//    NSLog(@"%s", __func__);
//}

- (void)backAction:(UIButton *)sender {
    [sender removeFromSuperview];
    [self dismissViewControllerAnimated:YES completion:nil];
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
