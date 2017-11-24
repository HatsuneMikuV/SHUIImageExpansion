//
//  UIImage+SHExtensions.h
//  SHUIImageExpansion
//
//  Created by angle on 2017/11/24.
//  Copyright © 2017年 angle. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKitDefines.h>


#define SCREENWIDTH  ([UIScreen mainScreen].bounds.size.width)
#define SCREENHEIGHT ([UIScreen mainScreen].bounds.size.height)


/**
 位图上下文 bitmap graphics context
 */
@interface UIImage (SHExtensions)
#pragma mark -
#pragma mark   ==============Size==============
/**
 图片绘制圆角

 @param radius 圆角大小
 @return 新图
 */
- (UIImage *_Nullable)imageWithCornerRadius:(CGFloat)radius;
/**
 改变图片尺寸
 
 @param size 新尺寸
 @return 新图片
 */
- (UIImage *_Nullable)thumbnailWithSize:(CGSize)size;
#pragma mark -
#pragma mark   ==============Color==============
/**
 绘制一个颜色图片

 @param color 颜色
 @param size 尺寸
 @return 图片
 */
+ (UIImage *_Nonnull)imageWithColor:(UIColor *_Nullable)color
                       size:(CGSize)size;
#pragma mark -
#pragma mark   ==============Image==============
/**
 添加水印
 
 @param imageName 水印图
 @param underImageName 原图
 @return 新图
 */
+ (UIImage *_Nullable)waterMakeImage:(NSString *_Nullable)imageName
                          underImage:(NSString *_Nullable)underImageName;

/**
 根据原有图片(不足屏宽)
 绘制一个全屏宽，图等高两侧自定义背景色的图片

 @param color 背景色（默认白色）
 @return 新图
 */
- (UIImage *_Nullable)snapshotScreenBackgroundColor:(UIColor *_Nullable)color;
#pragma mark -
#pragma mark   ==============String==============
/**
 根据一个字符串，绘制一张图片

 @param string 字符串
 @param font 字体大小
 @param color 字体颜色
 @param backgroundColor 背景颜色
 @param size 图片尺寸
 @return 图片
 */
+ (UIImage *_Nullable)getImageWithString:(NSString *_Nullable)string
                           font:(UIFont *_Nullable)font
                      textColor:(UIColor *_Nullable)color
                backgroundColor:(UIColor *_Nullable)backgroundColor
                           size:(CGSize)size;

/**
 根据一个富文本字符串，绘制一张图片

 @param attributedString 富文本
 @param backgroundColor 背景色(默认白色)
 @param size 尺寸
 @return 图片
 */
+ (UIImage *_Nullable)getImageWithAttributedString:(NSMutableAttributedString *_Nullable)attributedString
                          backgroundColor:(UIColor *_Nullable)backgroundColor
                                     size:(CGSize)size;
#pragma mark -
#pragma mark   ==============animatedGIF==============

/**
 本地gif图绘制

 @param name 图片名
 @return 图片
 */
+ (UIImage *_Nullable)animatedGIFNamed:(NSString *_Nullable)name;

/**
 二进制流gif图片绘制

 @param data 二级制数据
 @return 图片
 */
+ (UIImage *_Nullable)animatedGIFWithData:(NSData *_Nullable)data;

/**
 gif图

 @param size 变化尺寸
 @return 新图
 */
- (UIImage *_Nullable)animatedImageByScalingAndCroppingToSize:(CGSize)size;

@end
