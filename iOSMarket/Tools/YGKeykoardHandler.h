//
//  YGKeykoardHandler.h
//  yingu
//
//  Created by liujiliu on 16/11/30.
//  Copyright © 2016年 Yingu-corp. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface YGKeykoardHandler : NSObject

+ (void)startKeykoardHandler;

@end


@interface UIView (YGKeykoardHandlerIdentifier)

@property (nonatomic, assign) BOOL shouldOpenKeykoardHandler;

@end
