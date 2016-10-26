//
//  StretchHeaderView.m
//  iOSMarket
//
//  Created by liujiliu on 16/10/25.
//  Copyright © 2016年 six. All rights reserved.
//

#import "StretchHeaderView.h"

@interface StretchHeaderView () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIImageView * person;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) CALayer *maskLayer;

@property (nonatomic, assign) CGAffineTransform transform;

@end

static CGFloat const HeaderHeight = 200;
@implementation StretchHeaderView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImage *image = [UIImage imageNamed:@"image5"];
    self.imageView = [[UIImageView alloc] initWithImage:image];
    self.imageView.frame = CGRectMake(0, kNavigationBarMaxY, kScreenWidth, HeaderHeight);
    [self.view addSubview:self.imageView];

    self.person = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image0"]];
    self.person.layer.cornerRadius = 35/2.0;
    self.person.layer.masksToBounds = YES;
    self.person.frame = CGRectMake(0, 0, 35, 35);

    CGSize size = [@"一只小船儿" boundingRectWithSize:CGSizeMake(300, 35) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:14]} context:nil].size;
    self.nameLab = [[UILabel alloc] initWithFrame:CGRectMake(35+10, 0, size.width, 35)];
    self.nameLab.font = [UIFont boldSystemFontOfSize:14];
    self.nameLab.text = @"一只小船儿";
    
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 35+size.width+10, 35)];
    self.containerView.center = CGPointMake(self.view.center.x, 35/2.0 + kNavigationBarMaxY + 5);
    [self.containerView addSubview:self.person];
    [self.containerView addSubview:self.nameLab];
    [self.view addSubview:self.containerView];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.contentInset = UIEdgeInsetsMake(CGRectGetMaxY(self.imageView.frame), 0, 0, 0);
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    self.maskLayer = [CALayer layer];
    self.maskLayer.frame = CGRectMake(0, 0, 500, 500);
    [self.imageView.layer addSublayer:self.maskLayer];
    
    self.transform = self.containerView.transform;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@", indexPath];
    cell.textLabel.numberOfLines = 0;
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"%lf, %lf, %lf", scrollView.contentOffset.x, scrollView.contentOffset.y, scrollView.contentInset.top);
    CGFloat contentOffY = scrollView.contentOffset.y;
    CGRect rect = self.imageView.frame;
    if (contentOffY*(-1) >= scrollView.contentInset.top) {
        rect.size.height = HeaderHeight - contentOffY - scrollView.contentInset.top;
        rect.size.width = rect.size.width * rect.size.height/self.imageView.h;
        rect.origin.x = rect.origin.x - (rect.size.width-self.imageView.w)/2.0;
        self.imageView.frame = rect;
        
        if (self.maskLayer.backgroundColor) {
            self.maskLayer.backgroundColor = nil;
            self.containerView.transform = CGAffineTransformIdentity;
        }
    } else if (contentOffY*(-1) > kNavigationBarMaxY) {
        CGFloat k = (contentOffY*(-1)-kNavigationBarMaxY)/HeaderHeight ;
        self.containerView.alpha = k;
        self.containerView.transform = CGAffineTransformScale(self.transform, k * 0.4 + 0.6, k * 0.4 + 0.6);
        self.maskLayer.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1-k].CGColor;
        NSLog(@"%lf", k);
    }
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
