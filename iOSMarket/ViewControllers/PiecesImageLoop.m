//
//  PiecesImageLoop.m
//  iOSMarket
//
//  Created by liujiliu on 16/11/2.
//  Copyright © 2016年 six. All rights reserved.
//

#import "PiecesImageLoop.h"

@interface PiecesImageLoop ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIImageView *imageView1;
@property (nonatomic, strong) UIImageView *imageView2;
@property (nonatomic, strong) UIView *maskView;

@property (nonatomic, strong) NSArray *images;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, assign) NSInteger currentImage;
@end

@implementation PiecesImageLoop

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupMaskView];
    
    NSMutableArray *tmp = [NSMutableArray arrayWithCapacity:5];
    for (NSInteger i=1; i<6; i++) {
        [tmp addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%ld", i]]];
    }
    self.images = tmp.copy;
    
    self.containerView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.containerView];
    self.imageView1 = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.imageView2 = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.currentImage = 1;
    self.imageView2.image = self.images[self.currentImage];
    self.imageView2.maskView = self.maskView;
    [self.containerView addSubview:self.imageView1];
    [self.containerView addSubview:self.imageView2];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self startAnimation];
    }];
}


// piece.alpha为0的时候隐藏  为1的时候显示
- (UIView *)setupMaskView {
    if (self.maskView) {
        return self.maskView;
    }
    UIView *maskView = [[UIView alloc] initWithFrame:self.view.bounds];
    maskView.tag = 100;
    UIView *piece = nil;
    
    CGFloat x = 0, y = 0, w = 0, h = 0, hc = 0, vc = 0;
    hc = 12.f; //水平方向碎片个数
    vc = 1.f;  //竖直方向碎片个数
    w = kScreenWidth/hc;
    h = kScreenHeight/vc;
    for (NSInteger i=0; i<hc; i++) {  //水平方向
        for (NSInteger j=0; j<vc; j++) {
            x = i*w;
            y = j*h;
            piece = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
            piece.alpha = 1.0f;
            piece.backgroundColor = [UIColor whiteColor];  //这很重要
            [maskView addSubview:piece];
        }
    }
    self.maskView = maskView;
    return maskView;
}

- (void)startAnimation {
    UIImageView *currentImageView = self.containerView.subviews.lastObject;
    UIImageView *nextImageView = self.containerView.subviews.firstObject;
    self.currentImage++;
    if (self.currentImage >= 5) {
        self.currentImage = 0;
    }
    nextImageView.image = self.images[self.currentImage];
    
    NSInteger count = self.maskView.subviews.count;
    UIView *piece = nil;
    for (NSInteger i=0; i<count; i++) {
        piece = self.maskView.subviews[i];
        [UIView animateWithDuration:1.f delay:0.2*i options:UIViewAnimationOptionCurveLinear animations:^{
            piece.alpha = 0.0f;
        } completion:^(BOOL finished) {
            if (i == count-1 && finished) {
                [self.containerView sendSubviewToBack:currentImageView];
                currentImageView.maskView = nil;
                [self.maskView.subviews setValue:@1.f forKey:@"alpha"];
                nextImageView.maskView = self.maskView;
            }
        }];
    }
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"asdsa");
//    [self startAnimation];
//    self.currentImage ++;
//}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.timer invalidate];
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
