//
//  TextViewKeyboard.h
//  iOSMarket
//
//  Created by liujiliu on 16/11/9.
//  Copyright © 2016年 six. All rights reserved.
//

#import "SIXViewController.h"
@protocol TextViewKeyboardDelegate <NSObject>

- (void)getBackRecords:(NSString *)records;

@end
@interface TextViewKeyboard : SIXViewController
+ (void)openEditRecordsVCFrom:(UINavigationController *)viewController completionHandler:(void (^)(NSString *records))handler;

@property (nonatomic, weak) id <TextViewKeyboardDelegate> delegate;
@end
