//
//  HeXinTuXing.m
//  iOSMarket
//
//  Created by liujiliu on 16/11/4.
//  Copyright © 2016年 six. All rights reserved.
//

#import "HeXinTuXing.h"

@interface LayerDelegate : NSObject <CALayerDelegate>

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx;

@end

@implementation LayerDelegate

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    CGContextSaveGState(ctx);
    {
        //在上下文剪裁区域挖一个三角形孔
        CGContextMoveToPoint(ctx, 90, 200);
        CGContextAddLineToPoint(ctx, 100, 190);
        CGContextAddLineToPoint(ctx, 110, 200);
        CGContextSetRGBStrokeColor(ctx, 1, 0, 0, 1);
        CGContextClosePath(ctx);
        CGContextAddRect(ctx, CGContextGetClipBoundingBox(ctx));
        CGContextEOClip(ctx);
        
        //绘制一个垂线，让它的轮廓形状成为剪裁区域
        CGContextMoveToPoint(ctx, 100, 200);
        CGContextAddLineToPoint(ctx, 100, 119);
        CGContextSetLineWidth(ctx, 20);
        
        //使用路径的描边版本替换图形上下文的路径
        CGContextReplacePathWithStrokedPath(ctx);
        
        //对路径的描边版本实施剪裁     !!注意
        CGContextClip(ctx);
        
        //绘制渐变
        CGFloat locs[3] = {0.0, 0.5, 1.0};
        CGFloat colors[12] = {
            0.3,0.3,0.3,0.8, // 开始颜色，透明灰
            0.0,0.0,0.0,1.0, // 中间颜色，黑色
            0.3,0.3,0.3,0.8 // 末尾颜色，透明灰
        };
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
        CGGradientRef grad = CGGradientCreateWithColorComponents(colorSpace, colors, locs, 3);
        CGContextDrawLinearGradient(ctx, grad, CGPointMake(89, 100), CGPointMake(111, 100), 0);
        CGColorSpaceRelease(colorSpace);
        CGGradientRelease(grad);
    }
    CGContextRestoreGState(ctx);
    //绘制红色箭头
    CGColorSpaceRef colorSpace1 = CGColorSpaceCreatePattern(NULL);
    CGContextSetFillColorSpace(ctx, colorSpace1);
    CGColorSpaceRelease(colorSpace1);
    CGPatternCallbacks callback = {0, &drawStripes, NULL};
    CGAffineTransform tr = CGAffineTransformIdentity;
    CGPatternRef patt = CGPatternCreate(NULL, CGRectMake(0,0,4,4), tr, 4, 4, kCGPatternTilingConstantSpacingMinimalDistortion, true, &callback);
    CGFloat alpha = 1.0;
    CGContextSetFillPattern(ctx, patt, &alpha);
    CGPatternRelease(patt);
    
    CGContextMoveToPoint(ctx, 80, 125);
    CGContextAddLineToPoint(ctx, 100, 100);
    CGContextAddLineToPoint(ctx, 120, 125);
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
}

//- (void)displayLayer:(CALayer *)layer

void drawStripes (void *info, CGContextRef con) {
    // assume 4 x 4 cell
    CGContextSetFillColorWithColor(con, [[UIColor redColor] CGColor]);
    CGContextFillRect(con, CGRectMake(0,0,4,4));
    CGContextSetFillColorWithColor(con, [[UIColor blueColor] CGColor]);
    CGContextFillRect(con, CGRectMake(0,0,4,2));
}

@end

@interface TestView : UIView

@end

@implementation TestView

- (void)drawRect:(CGRect)rect {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(400, 400), NO, 0);
    CGContextRef con = UIGraphicsGetCurrentContext();
    CGContextSaveGState(con);
    {
        CGContextMoveToPoint(con, 90 - 80, 100);
        CGContextAddLineToPoint(con, 100 - 80, 90);
        CGContextAddLineToPoint(con, 110 - 80, 100);
        CGContextMoveToPoint(con, 110 - 80, 100);
        CGContextAddLineToPoint(con, 100 - 80, 90);
        CGContextAddLineToPoint(con, 90 - 80, 100);
        CGContextClosePath(con);
        CGContextAddRect(con, CGContextGetClipBoundingBox(con));
        CGContextEOClip(con);
        CGContextMoveToPoint(con, 100 - 80, 100);
        CGContextAddLineToPoint(con, 100 - 80, 19);
        CGContextSetLineWidth(con, 20);
        CGContextReplacePathWithStrokedPath(con);
        CGContextClip(con);
        CGFloat locs[3] = { 0.0, 0.5, 1.0 };
        CGFloat colors[12] = {
            0.3,0.3,0.3,0.8,
            0.0,0.0,0.0,1.0,
            0.3,0.3,0.3,0.8
        };
        CGColorSpaceRef sp = CGColorSpaceCreateDeviceGray();
        CGGradientRef grad = CGGradientCreateWithColorComponents (sp, colors, locs, 3);
        CGContextDrawLinearGradient (con, grad, CGPointMake(89 - 80,0), CGPointMake(111 - 80,0), 0);
        CGColorSpaceRelease(sp);
        CGGradientRelease(grad);
        }
    CGContextRestoreGState(con);
    CGColorSpaceRef sp2 = CGColorSpaceCreatePattern(NULL);
    CGContextSetFillColorSpace (con, sp2);
    CGColorSpaceRelease (sp2);
    CGPatternCallbacks callback = {0, &drawStripes, NULL };
    CGAffineTransform tr = CGAffineTransformIdentity;
    CGPatternRef patt = CGPatternCreate(NULL,CGRectMake(0,0,4,4),tr,4,4,kCGPatternTilingConstantSpacingMinimalDistortion,true, &callback);
    CGFloat alph = 1.0;
    CGContextSetFillPattern(con, patt, &alph);
    CGPatternRelease(patt);
    CGContextMoveToPoint(con, 80 - 80, 25);
    CGContextAddLineToPoint(con, 100 - 80, 0);
    CGContextAddLineToPoint(con, 120 - 80, 25);
    CGContextFillPath(con);
    UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    con = UIGraphicsGetCurrentContext();
    [im drawAtPoint:CGPointMake(0,0)];
    //你先是应用了一个平移变换，为的是映射原点到你真正想绕其旋转的点。但是接着，在旋转之后，为了算出你在哪里绘图，你可能需要做一次逆向平移变换。
    for (int i=0; i<3; i++) {
        CGContextTranslateCTM(con, 20, 100);
        CGContextRotateCTM(con, 30 * M_PI/180.0);
        CGContextTranslateCTM(con, -20, -100);
        [im drawAtPoint:CGPointMake(0,0)];
    }
}

@end

@interface HeXinTuXing ()

@property (nonatomic, weak) CALayer *myLayer;
@property (nonatomic, strong) LayerDelegate *layerDelegate;

@end

//extern CGImageRef flip (CGImageRef im);
@implementation HeXinTuXing

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    [self test4];
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

- (void)resize {
    TestView *view = [self.view viewWithTag:10];
    view.frame = CGRectMake(0, 64, 400, 800);
}


/**
 复制image
 */
- (void)test0 {
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
}

/**
 缩放image
 */
- (void)test1 {
    UIImage *image = [UIImage imageNamed:@"icon_iphone_60"];
    CGFloat imageW = image.size.width;
    CGFloat imageH = image.size.height;

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
}

/**
 只画半个image
 */
- (void)test2 {
    UIImage *image = [UIImage imageNamed:@"icon_iphone_60"];
    CGFloat imageW = image.size.width;
    CGFloat imageH = image.size.height;
    
    //只画半个image
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageW*0.5, imageH), NO, 0);
    [image drawAtPoint:CGPointMake(0, 0)];
    UIImage *halfImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *halfImageView = [[UIImageView alloc] initWithImage:halfImage];
    [halfImageView sizeToFit];
    halfImageView.center = CGPointMake(self.view.center.x, 300);
    [self.view addSubview:halfImageView];
}

/**
 两个 半个image  image倒置  scale修复
 */
- (void)test3 {
    UIImage *image = [UIImage imageNamed:@"icon_iphone_60"];
    CGFloat imageW = image.size.width;
    CGFloat imageH = image.size.height;
    
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

/**
    CIFilter
 */
- (void)test4 {
    UIImage *image = [UIImage imageNamed:@"image11"];
    CGFloat imageW = image.size.width;
    CGFloat imageH = image.size.height;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [imageView sizeToFit];
    imageView.center = CGPointMake(self.view.center.x, 70+imageH*0.5);
    [self.view addSubview:imageView];
    
    CIImage *ciimage = [[CIImage alloc] initWithCGImage:image.CGImage];
    CIFilter *gradientFilterd = [CIFilter filterWithName:@"CIRadialGradient"];
    CIVector *center = [CIVector vectorWithX:imageW/2.0 Y:imageH/2.0];
    [gradientFilterd setValue:center forKey:@"inputCenter"];
    CIFilter *darkFilterd = [CIFilter filterWithName:@"CIDarkenBlendMode" keysAndValues:@"inputImage", gradientFilterd.outputImage, @"inputBackgroundImage", ciimage, nil];
    CIContext *ctx = [CIContext contextWithOptions:nil];
    CGImageRef cgimage1 = [ctx createCGImage:darkFilterd.outputImage fromRect:ciimage.extent];
    UIImage *image1 = [UIImage imageWithCGImage:cgimage1 scale:image.scale orientation:image.imageOrientation];
    
    CGImageRef cgimage2 = [ctx createCGImage:gradientFilterd.outputImage fromRect:ciimage.extent];
    UIImage *image2 = [UIImage imageWithCGImage:cgimage2 scale:image.scale orientation:image.imageOrientation];
    CGImageRelease(cgimage2);
    CGImageRelease(cgimage1);
    
    UIImageView *mageView1 = [[UIImageView alloc] initWithImage:image1];
    [mageView1 sizeToFit];
    mageView1.center = CGPointMake(self.view.center.x, self.view.center.y+imageH+10);
    [self.view addSubview:mageView1];
    
    UIImageView *mageView2 = [[UIImageView alloc] initWithImage:image2];
    [mageView2 sizeToFit];
    mageView2.center = CGPointMake(self.view.center.x, self.view.center.y+5);
    [self.view addSubview:mageView2];
}

/**
  一个别致的箭头
 */
- (void)test5 {
    CALayer *layer = [CALayer layer];
    //    layer.backgroundColor = [UIColor cyanColor].CGColor;
    self.layerDelegate = [LayerDelegate new];
    layer.delegate = self.layerDelegate;
    [layer setNeedsDisplay];
    layer.frame = self.view.bounds;
    [self.view.layer addSublayer:layer];
    _myLayer = layer;
}

/**
 几个别致的箭头
 */
- (void)test6 {
    TestView *view = [[TestView alloc] initWithFrame:CGRectMake(0, 64, 400, 400)];
    view.tag = 10;
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    [self performSelector:@selector(resize) withObject:nil afterDelay:0.1];
    [view performSelector:@selector(setNeedsDisplay) withObject:nil afterDelay:2];
    NSLog(@"----%lf  %lf  %lf", [UIScreen mainScreen].scale, self.view.contentScaleFactor, view.contentScaleFactor);
}

/**
 一个别致的箭头
 */
- (void)test7 {

}

/**
 一个别致的箭头
 */
- (void)test8 {

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
