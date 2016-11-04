//
//  ProgressBar.m
//  iOSMarket
//
//  Created by liujiliu on 16/11/4.
//  Copyright © 2016年 six. All rights reserved.
//

#import "ProgressBar.h"
#import "SIXProgressBar.h"

@interface ProgressBar () <UITextFieldDelegate>

@property (nonatomic, weak) SIXProgressBar *progressBar;
@property (nonatomic, weak) UITextField *field;

@end

@implementation ProgressBar

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    SIXProgressBar *progressBar = [[SIXProgressBar alloc] initWithFrame:CGRectMake(20, 200, kScreenWidth-40, 50)];
    [self.view addSubview:progressBar];
    _progressBar = progressBar;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    button.frame = CGRectMake(kScreenWidth - 50, 400, 50, 40);
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UITextField *filed = [[UITextField alloc] initWithFrame:CGRectMake(50, 400, kScreenWidth-100, 30)];
    filed.borderStyle = UITextBorderStyleRoundedRect;
    filed.backgroundColor = [UIColor greenColor];
    [self.view addSubview:filed];
    _field = filed;
    
    
    
}


- (void)buttonAction {
    self.progressBar.progress = [self.field.text floatValue];
    NSLog(@"---%lf", self.progressBar.progress);
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
