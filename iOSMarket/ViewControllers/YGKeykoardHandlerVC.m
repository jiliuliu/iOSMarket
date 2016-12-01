//
//  YGKeykoardHandlerVC.m
//  iOSMarket
//
//  Created by liujiliu on 16/12/1.
//  Copyright © 2016年 six. All rights reserved.
//

#import "YGKeykoardHandlerVC.h"
#import "YGKeykoardHandler.h"

@interface YGKeykoardHandlerVC ()

@end

@implementation YGKeykoardHandlerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [YGKeykoardHandler startKeykoardHandler];
    
    [self setupViews];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setupViews {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.contentSize = CGSizeMake(0, 1500);
    [self.view addSubview:scrollView];
    
    for (NSInteger i=0; i<10; i++) {
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(40, 20+150*i, self.view.bounds.size.width-80, 40)];
        textField.backgroundColor = [UIColor cyanColor];
        textField.placeholder = [NSString stringWithFormat:@"第%ld个", i];
        textField.shouldOpenKeykoardHandler = YES;
        [scrollView addSubview:textField];
    }

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan");
    [super touchesBegan:touches withEvent:event];
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
