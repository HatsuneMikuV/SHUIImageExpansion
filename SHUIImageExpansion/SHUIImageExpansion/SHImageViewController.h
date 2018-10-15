//
//  SHImageViewController.h
//  SHUIImageExpansion
//
//  Created by angle on 2017/11/24.
//  Copyright © 2017年 angle. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIImage+SHExtensions.h"

typedef enum : NSUInteger {
    SHImageBitmapTypeNone = 0,
    SHImageBitmapTypeRadius,
    SHImageBitmapTypeSize,
    SHImageBitmapTypeColor,
    SHImageBitmapTypeWaterImage,
    SHImageBitmapTypeScreenImage,
    SHImageBitmapTypeStringImage,
    SHImageBitmapTypeAttributedStringImage,
    SHImageBitmapTypeSourceName,
    SHImageBitmapTypeSourceData,
    SHImageBitmapTypeSourceSize,
    SHImageBitmapTypeDrawArc,
} SHImageBitmapType;

@interface SHImageViewController : UIViewController

@property (nonatomic, assign) SHImageBitmapType bitmapType;

@end
