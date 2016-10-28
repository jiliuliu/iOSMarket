//
//  SIXButton.m
//  iOSMarket
//
//  Created by liujiliu on 16/10/27.
//  Copyright © 2016年 six. All rights reserved.
//

#import "SIXButton.h"

@implementation SIXButton

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    NSLog(@"image %@", NSStringFromCGRect(contentRect));
    CGFloat imageWidth = contentRect.size.width / 1.7;
    CGFloat imageX = CGRectGetWidth(contentRect) / 2 - imageWidth / 2;
    CGFloat imageHeight = imageWidth;
    CGFloat imageY = CGRectGetHeight(self.bounds) - (imageHeight + 30);
    return CGRectMake(imageX, imageY, imageWidth, imageHeight);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    NSLog(@"title %@", NSStringFromCGRect(contentRect));
    CGFloat titleX = 0;
    CGFloat titleHeight = 20;
    CGFloat titleY = contentRect.size.height - titleHeight;
    CGFloat titleWidth = contentRect.size.width;
    return CGRectMake(titleX, titleY, titleWidth, titleHeight);
}

@end
