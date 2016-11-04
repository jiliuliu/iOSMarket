//
//  HeXinTuXing.m
//  iOSMarket
//
//  Created by liujiliu on 16/11/4.
//  Copyright © 2016年 six. All rights reserved.
//

#import "HeXinTuXing.h"

@interface HeXinTuXing ()

@end

//extern CGImageRef flip (CGImageRef im);
@implementation HeXinTuXing

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%----lf", [UIScreen mainScreen].scale);
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *image = [UIImage imageNamed:@"icon_iphone_60"];
    CGFloat imageW = image.size.width;
    CGFloat imageH = image.size.height;
    //复制image
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageW*2, imageH), NO, 0);
    [image drawAtPoint:CGPointMake(0, 0)];
    [image drawAtPoint:CGPointMake(imageW, 0)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:newImage];
    [imageView sizeToFit];
    imageView.center = CGPointMake(self.view.center.x, 100);
    [self.view addSubview:imageView];
    //缩放image
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageW*2, imageH*2), NO, 0);
    [image drawInRect:CGRectMake(0, 0, imageW*2, image.size.height*2)];
    [image drawInRect:CGRectMake(imageW/2.0, image.size.height/2.0, imageW, imageH) blendMode:kCGBlendModeMultiply alpha:1.0];
    UIImage *bigImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *bigImageView = [[UIImageView alloc] initWithImage:bigImage];
    [bigImageView sizeToFit];
    bigImageView.center = CGPointMake(self.view.center.x, 200);
    [self.view addSubview:bigImageView];
    //只画半个image
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageW*0.5, imageH), NO, 0);
    [image drawAtPoint:CGPointMake(0, 0)];
    UIImage *halfImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *halfImageView = [[UIImageView alloc] initWithImage:halfImage];
    [halfImageView sizeToFit];
    halfImageView.center = CGPointMake(self.view.center.x, 300);
    [self.view addSubview:halfImageView];
    
    //两个 半个image  image倒置  scale修复
    CGFloat imageCGW = CGImageGetWidth(image.CGImage);
    CGFloat imageCGH = CGImageGetHeight(image.CGImage);
    
    CGImageRef imageLeft = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(0, 0, imageCGW*0.5, imageCGH));
    CGImageRef imageRight = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(imageCGW*0.5, 0, imageCGW*0.5, imageCGH));
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageW*1.5, imageH), NO, 0);
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextDrawImage(ctx, CGRectMake(0, 0, imageW*0.5, image.size.height), flip(imageLeft));
        CGContextDrawImage(ctx, CGRectMake(imageW, 0, imageW*0.5, image.size.height), flip(imageRight));
//    [[UIImage imageWithCGImage:imageLeft scale:image.scale orientation:UIImageOrientationUp] drawAtPoint:CGPointMake(0, 0)];
//    [[UIImage imageWithCGImage:imageRight scale:image.scale orientation:UIImageOrientationUp] drawAtPoint:CGPointMake(imageW, 0)];
    UIImage *doubleHalfImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRelease(imageLeft);
    CGImageRelease(imageRight);
    
    UIImageView *doubleHalfImageView = [[UIImageView alloc] initWithImage:doubleHalfImage];
    [doubleHalfImageView sizeToFit];
    doubleHalfImageView.center = CGPointMake(self.view.center.x, 400);
    [self.view addSubview:doubleHalfImageView];
}

//原始的本地坐标系统（坐标原点在左上角）与目标上下文（坐标原点在左下角）不匹配，
//使用CGContextDrawImage方法先将CGImage绘制到UIImage上，然后获取UIImage对应的CGImage，此时就得到了一个倒转的CGImage。当再调用CGContextDrawImage方法，我们就将倒转的图片还原回来了
CGImageRef flip (CGImageRef im) {
    CGSize sz = CGSizeMake(CGImageGetWidth(im), CGImageGetHeight(im));
    UIGraphicsBeginImageContextWithOptions(sz, NO, 0);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, sz.width, sz.height), im);
    CGImageRef result = [UIGraphicsGetImageFromCurrentImageContext() CGImage];
    UIGraphicsEndImageContext();
    return result;
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
