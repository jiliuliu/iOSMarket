//
//  SIXButton.h
//  iOSMarket
//
//  Created by liujiliu on 16/10/27.
//  Copyright © 2016年 six. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SIXButtonAlignmentType) {
    SIXButtonAlignmentTypeSystem,
    SIXButtonAlignmentTypeLeft,
    SIXButtonAlignmentTypeRight,
    SIXButtonAlignmentTypeTop
};

@interface SIXButton : UIButton

@property (nonatomic, assign) SIXButtonAlignmentType alignmentType;
@property (nonatomic, assign) CGFloat margin;


@end
