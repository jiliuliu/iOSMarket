//
//  TextViewKeyboard.m
//  iOSMarket
//
//  Created by liujiliu on 16/11/9.
//  Copyright © 2016年 six. All rights reserved.
//

#import "TextViewKeyboard.h"

@interface TextViewKeyboard () <UITextViewDelegate>

@property (nonatomic, weak) UITextView *textView;

@property (nonatomic, weak) UILabel *placeholderLabel;

@property (nonatomic, copy) void (^completionHandler)(NSString *records);

@end

@implementation TextViewKeyboard

+ (void)openEditRecordsVCFrom:(UINavigationController *)viewController completionHandler:(void (^)(NSString *))handler {
    TextViewKeyboard *vc = [self new];
    vc.completionHandler = handler;
    [viewController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"编辑记录";
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [self.view endEditing:YES];
}

- (void)commonInit {
    
}

- (void)setupViews {
    NSInteger const scrollView_tag = 100;
    
    UIBarButtonItem *postItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(postRecords)];
    self.navigationItem.rightBarButtonItem = postItem;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.contentSize = CGSizeMake(0, scrollView.bounds.size.height+0.5);
    scrollView.tag = scrollView_tag;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:self.view.bounds];
    textView.delegate = self;
    textView.tintColor = [UIColor blackColor];
    textView.font = [UIFont systemFontOfSize:14];
    textView.backgroundColor = [UIColor whiteColor];
    textView.showsVerticalScrollIndicator = NO;
    [scrollView addSubview:textView];
    self.textView = textView;
    
    UILabel *placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.bounds.size.width, 35)];
    placeholderLabel.text = @"写记录...";
    placeholderLabel.font = [UIFont systemFontOfSize:14];
    placeholderLabel.textColor = [UIColor lightGrayColor];
    [textView addSubview:placeholderLabel];
    self.placeholderLabel = placeholderLabel;
}

- (void)postRecords {
    [self.textView resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(getBackRecords:)]) {
        [self.delegate getBackRecords:self.textView.text];
    }
    if (self.completionHandler) {
        self.completionHandler(self.textView.text);
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    self.placeholderLabel.hidden = textView.text.length;
}

-(void)keyboardWillShow:(NSNotification *)noti {
    NSDictionary *userInfo = [noti userInfo];
    NSValue *KeyboardFrameValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGFloat keyboardHeight = [KeyboardFrameValue CGRectValue].size.height;
    NSTimeInterval duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect rect = self.view.bounds;
    
    rect.size.height = rect.size.height - keyboardHeight;
    [UIView animateWithDuration:duration animations:^{
        self.textView.frame = rect;
    }];
    
    NSInteger const scrollView_tag = 100;
    UIScrollView *scrollView = [self.view viewWithTag:scrollView_tag];
    scrollView.scrollEnabled = YES;
}

- (void)keyboardWillHide:(NSNotification *)aNotification {
    self.textView.frame = self.view.bounds;
    NSInteger const scrollView_tag = 100;
    UIScrollView *scrollView = [self.view viewWithTag:scrollView_tag];
    if (self.textView.contentSize.height <= self.textView.bounds.size.height) {
        scrollView.scrollEnabled = YES;
    } else {
        scrollView.scrollEnabled = NO;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([self.textView isFirstResponder]) {
        [self.textView resignFirstResponder];
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
