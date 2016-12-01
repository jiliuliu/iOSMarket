//
//  YGKeykoardHandler.m
//  yingu
//
//  Created by liujiliu on 16/11/30.
//  Copyright © 2016年 Yingu-corp. All rights reserved.
//

#import "YGKeykoardHandler.h"
#import <objc/runtime.h>

@interface YGHideKeyboardGestureView : UIView

@end

@interface YGKeykoardHandler () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) YGHideKeyboardGestureView *hideKeyboardGestureView;
@property (nonatomic, weak) UIView *firstResponder;
@property (nonatomic, weak) UIViewController *viewController;

@end


#define Screen_Height [UIScreen mainScreen].bounds.size.height

@implementation YGKeykoardHandler

+ (void)startKeykoardHandler {
    [self sharedKeykoardHanhler];
}

+ (instancetype)sharedKeykoardHanhler {
    static YGKeykoardHandler *handler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handler = [self new];
    });
    return handler;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)willShow:(NSNotification *)noti {
    NSLog(@"willShow");
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    NSDictionary *userInfo = [noti userInfo];
    CGRect KeyboardFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval animationDuration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions animationCurve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue] << 16;
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.firstResponder = [self firstResponderOnSuperView:window];
    self.viewController = [self viewControllerForView:self.firstResponder];
    
    CGRect tempFrame = [self.viewController.view convertRect:self.firstResponder.frame fromView:self.firstResponder.superview];
    CGFloat distance = screenBounds.size.height - CGRectGetMaxY(tempFrame) - CGRectGetHeight(KeyboardFrame) - 20;
    if (!self.firstResponder || !self.viewController || !self.firstResponder.shouldOpenKeykoardHandler) {
        return;
    }
    CGRect gestureViewFrame = CGRectMake(0, 0, screenBounds.size.width, screenBounds.size.height-CGRectGetHeight(KeyboardFrame));
    self.hideKeyboardGestureView.frame = gestureViewFrame;
    [self.viewController.view addSubview:self.hideKeyboardGestureView];
    if (distance > 0) {
        return;
    }
    CGRect bounds = self.viewController.view.bounds;
    bounds.origin.y = -distance;
    gestureViewFrame.origin.y = -distance;
    self.hideKeyboardGestureView.frame = gestureViewFrame;
    [UIView animateWithDuration:animationDuration delay:0 options:animationCurve | UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.viewController.view.bounds = bounds;
        NSLog(@"antimation");
    } completion:nil];
}

- (void)willHide:(NSNotification *)noti {
    NSLog(@"willHide");
    [self.hideKeyboardGestureView removeFromSuperview];
    
    NSDictionary *userInfo = [noti userInfo];
    NSTimeInterval animationDuration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions animationCurve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue] << 16;
    CGRect bounds = self.viewController.view.bounds;
    if (!self.firstResponder || !self.viewController || !self.firstResponder.shouldOpenKeykoardHandler || bounds.origin.y == 0) {
        return;
    }
    bounds.origin.y = 0;
    [UIView animateWithDuration:animationDuration delay:0 options:animationCurve animations:^{
        self.viewController.view.bounds = bounds;
        NSLog(@"antimation");
    } completion:nil];
}

- (YGHideKeyboardGestureView *)hideKeyboardGestureView {
    if (!_hideKeyboardGestureView) {
        _hideKeyboardGestureView = [YGHideKeyboardGestureView new];
//        _hideKeyboardGestureView.backgroundColor = [UIColor yellowColor];
//        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
//        tapGesture.cancelsTouchesInView = NO;
//        tapGesture.delegate = self;
//        [_hideKeyboardGestureView addGestureRecognizer:tapGesture];
    }
    return _hideKeyboardGestureView;
}

- (void)hideKeyboard {
    NSLog(@"hideKeyboard-----");
    [self.firstResponder resignFirstResponder];
}

- (UIView *)firstResponderOnSuperView:(UIView *)superView {
    if ([superView isFirstResponder]) {
        return superView;
    }
    if (!superView.subviews.count) {
        return nil;
    }
    for (UIView *view in superView.subviews) {
        UIView *firstResponder = [self firstResponderOnSuperView:view];
        if (firstResponder) return firstResponder;
    }
    return nil;
}

- (UIViewController *)viewControllerForView:(UIView *)view {
    UIResponder * target = view;
    while (target) {
        target = target.nextResponder;
        if ([target isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    return (UIViewController *)target;
}

//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
//    CGPoint point = [gestureRecognizer locationInView:self.viewController.view];
//    NSLog(@"%lf, %lf", point.x, point.y);
//    CGRect frame = [self.viewController.view convertRect:self.firstResponder.frame fromView:self.firstResponder.superview];
//    return !CGRectContainsPoint(frame, point);
//}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
//    return NO;
//}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

@implementation YGHideKeyboardGestureView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    if (event.type == UIEventTypeTouches) {
        [[YGKeykoardHandler sharedKeykoardHanhler] hideKeyboard];
    }
}

@end

@implementation UIView (YGKeykoardHandlerIdentifier)

- (void)setShouldOpenKeykoardHandler:(BOOL)shouldOpenKeykoardHandler {
    objc_setAssociatedObject(self, @selector(shouldOpenKeykoardHandler), @(shouldOpenKeykoardHandler), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)shouldOpenKeykoardHandler {
    return objc_getAssociatedObject(self, @selector(shouldOpenKeykoardHandler));
}

@end
