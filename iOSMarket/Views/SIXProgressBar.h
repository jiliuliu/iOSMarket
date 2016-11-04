//
//  SIXProgressBar.h
//  iOSMarket
//
//  Created by liujiliu on 16/11/4.
//  Copyright © 2016年 six. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SIXProgressBar : UIView

/**
 set 0~1 ,  default 0;
 */
@property (nonatomic, assign) CGFloat progress;

/**  进度条颜色 */
@property (nonatomic, strong) NSArray *progressBarColors;

@end
