//
//  SIXButton.m
//  iOSMarket
//
//  Created by liujiliu on 16/10/27.
//  Copyright © 2016年 six. All rights reserved.
//

#import "SIXButton.h"

@implementation SIXButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
 
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    NSLog(@"image %@", NSStringFromCGRect(contentRect));
    if (self.alignmentType == SIXButtonAlignmentTypeSystem) {
        return [super imageRectForContentRect:contentRect];
    }
    CGFloat imageWidth = 0;
    CGFloat imageX = 0;
    CGFloat imageHeight = 0;
    CGFloat imageY = 0;
    switch (self.alignmentType) {
        case SIXButtonAlignmentTypeLeft:
            imageWidth = contentRect.size.height;
            imageX = 0;
            imageHeight = contentRect.size.height;
            imageY = 0;
            break;
        case SIXButtonAlignmentTypeRight:
            imageWidth = contentRect.size.height;
            imageX = contentRect.size.width-contentRect.size.height;
            imageHeight = contentRect.size.height;
            imageY = 0;
            break;
        default:
            imageWidth = contentRect.size.width;
            imageX = 0;
            imageHeight = contentRect.size.width;
            imageY = 0;
            break;
    }
    return CGRectMake(imageX, imageY, imageWidth, imageHeight);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    NSLog(@"title %@", NSStringFromCGRect(contentRect));
    if (self.alignmentType == SIXButtonAlignmentTypeSystem) {
        return [super titleRectForContentRect:contentRect];
    }
    CGFloat titleX = 0;
    CGFloat titleHeight = 0;
    CGFloat titleY = 0;
    CGFloat titleWidth = 0;
    switch (self.alignmentType) {
        case SIXButtonAlignmentTypeLeft:
            titleWidth = contentRect.size.width-contentRect.size.height-self.margin;
            titleX = contentRect.size.height+self.margin;
            titleHeight = contentRect.size.height;
            titleY = 0;
            break;
        case SIXButtonAlignmentTypeRight:
            titleWidth = contentRect.size.width-contentRect.size.height-self.margin;
            titleX = 0;
            titleHeight = contentRect.size.height;
            titleY = 0;
            break;
        default:
            titleWidth = contentRect.size.width;
            titleX = 0;
            titleHeight = contentRect.size.height-contentRect.size.width - self.margin;
            titleY = contentRect.size.width + self.margin;
            break;
    }
    return CGRectMake(titleX, titleY, titleWidth, titleHeight);
}

@end
