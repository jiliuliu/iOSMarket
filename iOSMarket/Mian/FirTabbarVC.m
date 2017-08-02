//
//  FirTabbarVC.m
//  iOSMarket
//
//  Created by liujiliu on 16/10/25.
//  Copyright © 2016年 six. All rights reserved.
//

#import "FirTabbarVC.h"
#import "SEEK.h"
#import "TestVC.h"
#import "StretchHeaderView.h"
#import "GameMap.h"
#import "GameMap2.h"
#import "ThreeD.h"
#import "HuiGuangWenZi.h"
#import "SnowyDay.h"
#import "WaterWave.h"
#import "SpecialButton.h"
#import "DashLine.h"
#import "LayerPauseresume.h"
#import "PiecesImageLoop.h"
#import "MoveableColor.h"
#import "ProgressBar.h"
#import "HeXinTuXing.h"
#import "TransitionAnimation.h"
#import "TextViewKeyboard.h"
#import "YGKeykoardHandlerVC.h"

@interface FirTabbarVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSArray *datas;

@end

static NSString * const Title = @"title";
static NSString * const VC = @"vc";
static NSString * const OpenType = @"openType";
@implementation FirTabbarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"这个取什么名字呢？";
    [self commonInit];
    [self setupViews];
}

- (void)commonInit {
    self.datas = @[@{Title:@"开篇语",           VC:[SEEK class], OpenType:@0},
                   @{Title:@"测试专用",         VC:[TestVC class], OpenType:@0},
                   @{Title:@"拉伸头部图像",      VC:[StretchHeaderView class], OpenType:@0},
                   @{Title:@"游戏地图",         VC:[GameMap class], OpenType:@1},
                   @{Title:@"游戏地图2",        VC:[GameMap2 class], OpenType:@1},
                   @{Title:@"迈向3d世界",       VC:[ThreeD class], OpenType:@0},
                   @{Title:@"辉光效果",         VC:[HuiGuangWenZi class], OpenType:@0},
                   @{Title:@"雨雪纷飞",         VC:[SnowyDay class], OpenType:@1},
                   @{Title:@"水波荡漾",         VC:[WaterWave class], OpenType:@0},
                   @{Title:@"特色按钮",         VC:[SpecialButton class], OpenType:@0},
                   @{Title:@"虚线绘制",         VC:[DashLine class], OpenType:@0},
                   @{Title:@"图层动画的暂停回复",  VC:[LayerPauseresume class], OpenType:@0},
                   @{Title:@"碎片效果的图片轮播",          VC:[PiecesImageLoop class], OpenType:@0},
                   @{Title:@"颜色在字上跑",          VC:[MoveableColor class], OpenType:@0},
                   @{Title:@"探访下Core Graphics",          VC:[HeXinTuXing class], OpenType:@0},
                   @{Title:@"一个炫酷的进度条",          VC:[ProgressBar class], OpenType:@0},
                   @{Title:@"一点转场动画",          VC:[TransitionAnimation class], OpenType:@0},
                   @{Title:@"UITextView的键盘操作",          VC:[TextViewKeyboard class], OpenType:@0},
                   @{Title:@"测试一个处理键盘的工具",          VC:[YGKeykoardHandlerVC class], OpenType:@0},
                   @{Title:@"开篇语",          VC:[UIViewController class], OpenType:@0},
                   @{Title:@"开篇语",          VC:[UIViewController class], OpenType:@0},
                   @{Title:@"开篇语",          VC:[UIViewController class], OpenType:@0},
                   @{Title:@"开篇语",          VC:[UIViewController class], OpenType:@0},
                   @{Title:@"开篇语",          VC:[UIViewController class], OpenType:@0},
                   @{Title:@"开篇语",          VC:[UIViewController class], OpenType:@0},
                   @{Title:@"开篇语",          VC:[UIViewController class], OpenType:@0},
                   @{Title:@"开篇语",          VC:[UIViewController class], OpenType:@0},
                   @{Title:@"开篇语",          VC:[UIViewController class], OpenType:@0},
                   @{Title:@"开篇语",          VC:[UIViewController class], OpenType:@0},
                   @{Title:@"开篇语",          VC:[UIViewController class], OpenType:@0},
                   @{Title:@"开篇语",          VC:[UIViewController class], OpenType:@0},
                   @{Title:@"开篇语",          VC:[UIViewController class], OpenType:@0},
                   @{Title:@"开篇语",          VC:[UIViewController class], OpenType:@0}];
}

- (void)setupViews {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - UITableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = self.datas[indexPath.row][Title];
    cell.textLabel.numberOfLines = 0;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *viewController = [self.datas[indexPath.row][VC] new];
    viewController.title = self.datas[indexPath.row][Title];
    [self.datas[indexPath.row][OpenType] integerValue] ?
    [self presentViewController:viewController animated:YES completion:nil] :
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
//
//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    NSLog(@"%s", __func__);
//}
//
//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    NSLog(@"%s", __func__);
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    NSLog(@"%s", __func__);
//}
//
//- (void)viewDidDisappear:(BOOL)animated {
//    [super viewDidDisappear:animated];
//    NSLog(@"%s", __func__);
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
