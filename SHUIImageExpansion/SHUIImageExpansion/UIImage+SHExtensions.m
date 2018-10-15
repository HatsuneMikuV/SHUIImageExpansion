//
//  UIImage+SHExtensions.m
//  SHUIImageExpansion
//
//  Created by angle on 2017/11/24.
//  Copyright © 2017年 angle. All rights reserved.
//

#import "UIImage+SHExtensions.h"
#import <ImageIO/ImageIO.h>

#if __has_feature(objc_arc)
#define toCF (__bridge CFTypeRef)
#define fromCF (__bridge id)
#else
#define toCF (CFTypeRef)
#define fromCF (id)
#endif

@implementation UIImage (SHExtensions)

- (UIImage *)imageWithCornerRadius:(CGFloat)radius {
    CGRect rect = (CGRect){0.f, 0.f, self.size};
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, UIScreen.mainScreen.scale);
    CGContextAddPath(UIGraphicsGetCurrentContext(),
                     [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}
+ (UIImage *)imageWithColor:(UIColor *)color
                       size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
+ (UIImage *)waterMakeImage:(NSString*)imageName
                 underImage:(NSString*)underImageName {
    //根据传进来的数据创建图片-主图
    UIImage* underImage = [UIImage imageNamed:underImageName];
    
    //创建位图上下文，在创建的时候已经是开启了位图上下文了。
    /*
     第一个参数是传入原始图片的的尺寸
     第二个参数是alpha通道，yes是不透明，no是透明，选择no生成的图片会比较清晰
     第三个参数是生成图片与原始图片的比例，这里如果传入0.0的话，表示默认是系统的比例
     */
    UIGraphicsBeginImageContextWithOptions(underImage.size, NO, 1.0);
    
    //绘制主图
    float underImageW = underImage.size.width;
    float underImageH = underImage.size.height;
    [underImage drawInRect:CGRectMake(0, 0, underImageW, underImageH)];
    
    //根据传进来的数据创建图片-水印
    UIImage* waterMakeImage = [UIImage imageNamed:imageName];
    //绘制水印
    float waterMakeImageH = waterMakeImage.size.height>underImage.size.height*0.10?underImage.size.height*0.10:waterMakeImage.size.height;
    float waterMakeImageW = waterMakeImage.size.width*(waterMakeImageH/waterMakeImage.size.height);
    float waterMakeImageX = underImageW-waterMakeImageW;
    float waterMakeImageY = underImageH-waterMakeImageH;
    
    [waterMakeImage drawInRect:CGRectMake(waterMakeImageX, waterMakeImageY, waterMakeImageW, waterMakeImageH)];
    
    //用UIImage创建对象接受位图上下文绘制好的图片
    UIImage* bitmapImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //结束位图编辑
    UIGraphicsEndImageContext();
    
    return bitmapImage;
}
- (UIImage *)snapshotScreenBackgroundColor:(UIColor *)color {
    
    if (self.size.width >= SCREENWIDTH) {
        return self;
    }
    CGSize size = CGSizeMake(SCREENWIDTH, self.size.height);
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, size.height)];
    
    backView.backgroundColor = color ? color:[UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self];
    
    CGFloat imageX = (SCREENWIDTH - self.size.width) * 0.5;
    
    imageView.frame = CGRectMake(imageX, 0, self.size.width, self.size.height);
    
    [backView addSubview:imageView];
    
    UIGraphicsBeginImageContext(backView.bounds.size);
    [backView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image= UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}
+ (UIImage *_Nullable)getImageWithString:(NSString *_Nullable)string
                                    font:(UIFont *_Nullable)font
                               textColor:(UIColor *_Nullable)color
                         backgroundColor:(UIColor *_Nullable)backgroundColor
                                    size:(CGSize)size {

    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    [attributedText addAttributes:@{NSFontAttributeName:font,
                                    NSForegroundColorAttributeName:color,
                                    NSParagraphStyleAttributeName:paragraphStyle,
                                    NSKernAttributeName:@3} range:NSMakeRange(0, string.length)];
    
    return [self getImageWithAttributedString:attributedText backgroundColor:backgroundColor size:size];
}
+ (UIImage *)getImageWithAttributedString:(NSMutableAttributedString *)attributedString
                          backgroundColor:(UIColor *)backgroundColor
                                     size:(CGSize)size {
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = backgroundColor ?backgroundColor:[UIColor whiteColor];
    
    BOOL flag = NO;
    if (size.width == MAXFLOAT) {
        //计算宽度
        label.numberOfLines = 1;
        label.frame = CGRectMake(0, 0, 0, size.height);
    }else if (size.height == MAXFLOAT) {
        //计算高度
        label.numberOfLines = 0;
        label.frame = CGRectMake(0, 0, size.width, 0);
    }else {
        flag = YES;
        label.numberOfLines = 0;
        label.frame = CGRectMake(0, 0, size.width, size.height);
    }
    
    label.attributedText = attributedString;
    
    CGSize realSize;
    if (flag) {
        realSize = size;
    }else {
        [label sizeToFit];
        realSize = label.frame.size;
    }
    
    //绘图关键
    UIGraphicsBeginImageContext(realSize);
    [label.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image= UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)animatedGIFWithData:(NSData *)data {
    if (!data) {
        return nil;
    }
    
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    
    size_t count = CGImageSourceGetCount(source);
    
    UIImage *animatedImage;
    
    if (count <= 1) {
        animatedImage = [[UIImage alloc] initWithData:data];
    }
    else {
        NSMutableArray *images = [NSMutableArray array];
        
        NSTimeInterval duration = 0.0f;
        
        for (size_t i = 0; i < count; i++) {
            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
            if (!image) {
                continue;
            }
            
            duration += [self frameDurationAtIndex:i source:source];
            
            [images addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
            
            CGImageRelease(image);
        }
        
        if (!duration) {
            duration = (1.0f / 10.0f) * count;
        }
        
        animatedImage = [UIImage animatedImageWithImages:images duration:duration];
    }
    
    CFRelease(source);
    
    return animatedImage;
}

+ (float)frameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source {
    float frameDuration = 0.1f;
    CFDictionaryRef cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil);
    NSDictionary *frameProperties = (__bridge NSDictionary *)cfFrameProperties;
    NSDictionary *gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];
    
    NSNumber *delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    if (delayTimeUnclampedProp) {
        frameDuration = [delayTimeUnclampedProp floatValue];
    }
    else {
        
        NSNumber *delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
        if (delayTimeProp) {
            frameDuration = [delayTimeProp floatValue];
        }
    }
    
    // Many annoying ads specify a 0 duration to make an image flash as quickly as possible.
    // We follow Firefox's behavior and use a duration of 100 ms for any frames that specify
    // a duration of <= 10 ms. See <rdar://problem/7689300> and <http://webkit.org/b/36082>
    // for more information.
    
    if (frameDuration < 0.011f) {
        frameDuration = 0.100f;
    }
    
    CFRelease(cfFrameProperties);
    return frameDuration;
}

+ (UIImage *)animatedGIFNamed:(NSString *)name {
    CGFloat scale = [UIScreen mainScreen].scale;
    
    if (scale > 1.0f) {
        NSString *retinaPath = [[NSBundle mainBundle] pathForResource:[name stringByAppendingString:@"@2x"] ofType:@"gif"];
        
        NSData *data = [NSData dataWithContentsOfFile:retinaPath];
        
        if (data) {
            return [UIImage animatedGIFWithData:data];
        }
        
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        
        data = [NSData dataWithContentsOfFile:path];
        
        if (data) {
            return [UIImage animatedGIFWithData:data];
        }
        
        return [UIImage imageNamed:name];
    }
    else {
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        if (data) {
            return [UIImage animatedGIFWithData:data];
        }
        
        return [UIImage imageNamed:name];
    }
}
- (UIImage *)thumbnailWithSize:(CGSize)size {
    
    CGSize originalsize = [self size];
    //原图长宽均小于标准长宽的，不作处理返回原图
    if (originalsize.width<size.width && originalsize.height<size.height) {
        return self;
    }
    //原图长宽均大于标准长宽的，按比例缩小至最大适应值
    else if(originalsize.width>size.width && originalsize.height>size.height) {
        CGFloat rate = 1.0;
        CGFloat widthRate = originalsize.width/size.width;
        CGFloat heightRate = originalsize.height/size.height;
        
        rate = widthRate>heightRate?heightRate:widthRate;
        
        CGImageRef imageRef = nil;
        
        if (heightRate>widthRate) {
            imageRef = CGImageCreateWithImageInRect([self CGImage], CGRectMake(0, originalsize.height/2-size.height*rate/2, originalsize.width, size.height*rate));//获取图片整体部分
        }
        else {
            imageRef = CGImageCreateWithImageInRect([self CGImage], CGRectMake(originalsize.width/2-size.width*rate/2, 0, size.width*rate, originalsize.height));//获取图片整体部分
        }
        
        UIGraphicsBeginImageContext(size);//指定要绘画图片的大小
        CGContextRef con = UIGraphicsGetCurrentContext();
        CGContextTranslateCTM(con, 0.0, size.height);
        CGContextScaleCTM(con, 1.0, -1.0);
        CGContextDrawImage(con, CGRectMake(0, 0, size.width, size.height), imageRef);
        UIImage *standardImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        CGImageRelease(imageRef);
        return standardImage;
    }
    //原图长宽有一项大于标准长宽的，对大于标准的那一项进行裁剪，另一项保持不变
    else if(originalsize.height>size.height || originalsize.width>size.width){
        CGImageRef imageRef = nil;
        if(originalsize.height>size.height) {
            imageRef = CGImageCreateWithImageInRect([self CGImage], CGRectMake(0, originalsize.height/2-size.height/2, originalsize.width, size.height));//获取图片整体部分
        }
        else if (originalsize.width>size.width) {
            imageRef = CGImageCreateWithImageInRect([self CGImage], CGRectMake(originalsize.width/2-size.width/2, 0, size.width, originalsize.height));//获取图片整体部分
        }
        UIGraphicsBeginImageContext(size);//指定要绘画图片的大小
        CGContextRef con = UIGraphicsGetCurrentContext();
        CGContextTranslateCTM(con, 0.0, size.height);
        CGContextScaleCTM(con, 1.0, -1.0);
        CGContextDrawImage(con, CGRectMake(0, 0, size.width, size.height), imageRef);
        UIImage *standardImage = UIGraphicsGetImageFromCurrentImageContext();
        NSLog(@"改变后图片的宽度为%f,图片的高度为%f",[standardImage size].width,[standardImage size].height);
        UIGraphicsEndImageContext();
        CGImageRelease(imageRef);
        return standardImage;
    }
    //原图为标准长宽的，不做处理
    else {
        return self;
    }
}


- (UIImage *)animatedImageByScalingAndCroppingToSize:(CGSize)size {
    if (CGSizeEqualToSize(self.size, size) || CGSizeEqualToSize(size, CGSizeZero)) {
        return self;
    }
    
    CGSize scaledSize = size;
    CGPoint thumbnailPoint = CGPointZero;
    
    CGFloat widthFactor = size.width / self.size.width;
    CGFloat heightFactor = size.height / self.size.height;
    CGFloat scaleFactor = (widthFactor > heightFactor) ? widthFactor : heightFactor;
    scaledSize.width = self.size.width * scaleFactor;
    scaledSize.height = self.size.height * scaleFactor;
    
    if (widthFactor > heightFactor) {
        thumbnailPoint.y = (size.height - scaledSize.height) * 0.5;
    }
    else if (widthFactor < heightFactor) {
        thumbnailPoint.x = (size.width - scaledSize.width) * 0.5;
    }
    
    NSMutableArray *scaledImages = [NSMutableArray array];
    
    for (UIImage *image in self.images) {
        UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
        
        [image drawInRect:CGRectMake(thumbnailPoint.x, thumbnailPoint.y, scaledSize.width, scaledSize.height)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        
        [scaledImages addObject:newImage];
        
        UIGraphicsEndImageContext();
    }
    
    return [UIImage animatedImageWithImages:scaledImages duration:self.duration];
}

+ (UIImage *)drawArcImageSize:(CGSize)size
                       colors:(NSArray<UIColor *> *)colors
                       values:(NSArray<NSNumber *> *)values
                  strokeColor:(UIColor *)strokeColor
                  strokeWidth:(CGFloat)strokeWidth
{
    if (size.width == 0 || size.height == 0) {
        return nil;
    }
    
    if (colors.count <= 1 || values.count <= 1 || colors.count != values.count) {
        return nil;
    }

    
    NSInteger count = colors.count;
    float total = 0;
    for (NSNumber *num in values) {
        total += [num floatValue];
    }
    float angle = M_PI * 2 / total;
    float angle_start = 0;
    float angle_end = 0;
    
    CGPoint center = CGPointMake(size.width * 0.5, size.width * 0.5);
    
    NSMutableArray *colorArr = [NSMutableArray array];
    if (colors.count < 3) {
        [colorArr addObjectsFromArray:colors];
    }else {
        [colorArr addObjectsFromArray:[colors subarrayWithRange:NSMakeRange(3, count - 3)]];
        [colorArr addObjectsFromArray:[colors subarrayWithRange:NSMakeRange(0, 3)]];
    }

    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    CGFloat radius = size.width * 0.5;
    //绘制开始
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextClearRect(ctx, rect);
    for (NSInteger index = 0; index < count; index++) {
        NSNumber *num = values[index];
        
        angle_start = angle_end;
        angle_end = angle_start + [num floatValue] * angle;
        
        UIColor *color = colorArr[index];
        //设置填充颜色
        CGContextSetFillColorWithColor(ctx, color.CGColor);
        //移动画笔
        CGContextMoveToPoint(ctx, center.x, center.y);
        //画扇形
        CGContextAddArc(ctx, center.x, center.y, radius,  angle_start, angle_end, 0);
        //填充
        CGContextFillPath(ctx);
        
        //画中间的分割线
        CGContextSetStrokeColorWithColor(ctx, strokeColor.CGColor);
        //设置线条宽度
        CGContextSetLineWidth(ctx, strokeWidth);
        CGContextMoveToPoint(ctx, center.x, center.y);
        //算出线另一端的坐标
        CGPoint point1 = CGPointMake(center.x + radius*cos(angle_start), center.y + radius*sin(angle_start));
        //画线
        CGContextAddLineToPoint(ctx, point1.x, point1.y);
        CGContextStrokePath(ctx);
        
        //最后一次绘制结束分割线 防止扇形盖住线宽
        if (index == count - 1) {
            //画中间的分割线
            CGContextSetStrokeColorWithColor(ctx, strokeColor.CGColor);
            //设置线条宽度
            CGContextSetLineWidth(ctx, strokeWidth);
            CGContextMoveToPoint(ctx, center.x, center.y);
            //算出线另一端的坐标
            CGPoint point1 = CGPointMake(center.x + radius*cos(angle_end), center.y + radius*sin(angle_end));
            //画线
            CGContextAddLineToPoint(ctx, point1.x, point1.y);
            CGContextStrokePath(ctx);
        }
    }
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}

@end
