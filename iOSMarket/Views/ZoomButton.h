//
//  ZoomButton.h
//  iOSMarket
//
//  Created by liujiliu on 16/11/1.
//  Copyright © 2016年 six. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SIXButton.h"
@class ZoomButton;

@protocol ZoomButtonDelegate <NSObject>
/**
 *  长按百分比
 *
 *  @param percent 百分比
 *  @param view    自身
 */
- (void)longPressPercentage:(CGFloat)percent view:(ZoomButton *)view;
- (void)longPressCompleteWithView:(ZoomButton *)view;
@end

@interface ZoomButton : UIView

@property (nonatomic, strong) UIButton  *button;
/**
 *  代理
 */
@property (nonatomic, assign) id<ZoomButtonDelegate> delegate;

/**
 *  百分比
 */
@property (nonatomic, assign, readonly) CGFloat percent;

/**
 *  缩放比例
 */
@property (nonatomic, assign) CGFloat  scaleValue;

/**
 *  长按时间多长时间才能表示已经按下按钮激活事件
 */
@property (nonatomic, assign) NSTimeInterval completeDurationAfterLongPress;

/**
 *  激活按钮事件
 */
- (void)activateButtonEffect;
@end
