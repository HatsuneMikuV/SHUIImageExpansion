//
//  SHImageViewController.m
//  SHUIImageExpansion
//
//  Created by angle on 2017/11/24.
//  Copyright © 2017年 angle. All rights reserved.
//

#import "SHImageViewController.h"

@interface SHImageViewController ()

@end

@implementation SHImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    

    [self getSwitchType:self.bitmapType];
}

- (void)getSwitchType:(SHImageBitmapType)type {
    
    switch (type) {
        case SHImageBitmapTypeNone:
            
            break;
        case SHImageBitmapTypeRadius:
            [self SHImageRadius];
            break;
        case SHImageBitmapTypeSize:
            [self SHImageSize];
            break;
        case SHImageBitmapTypeColor:
            [self SHImageColor];
            break;
        case SHImageBitmapTypeScreenImage:
            [self SHImageScreenImage];
            break;
        case SHImageBitmapTypeWaterImage:
            [self SHImageWaterImage];
            break;
        case SHImageBitmapTypeStringImage:
            [self SHImageStringImage];
            break;
        case SHImageBitmapTypeAttributedStringImage:
            [self SHImageAttributedStringImage];
            break;
        case SHImageBitmapTypeSourceName:
            [self SHImageSourceName];
            break;
        case SHImageBitmapTypeSourceData:
            [self SHImageSourceData];
            break;
        case SHImageBitmapTypeSourceSize:
            [self SHImageSourceImageSize];
            break;
        case SHImageBitmapTypeDrawArc:
            [self SHImageSourceImageDrawArc];
            break;
        default:
            break;
    }
}
- (void)SHImageRadius {

    UIImage *image = [UIImage imageNamed:@"1"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 100, SCREENWIDTH - 100, (SCREENWIDTH - 100) * image.size.height / image.size.width)];
    imageView.backgroundColor = [UIColor cyanColor];
    [imageView setContentMode:(UIViewContentModeScaleAspectFill)];
    
    [imageView setImage:[image imageWithCornerRadius:50.f]];
    
    [self.view addSubview:imageView];
}
- (void)SHImageSize {
    UIImage *image = [UIImage imageNamed:@"1"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 100, SCREENWIDTH - 100, (SCREENWIDTH - 100) * image.size.height / image.size.width)];
    imageView.backgroundColor = [UIColor cyanColor];
    [imageView setContentMode:(UIViewContentModeCenter)];
    [imageView setImage:[image thumbnailWithSize:CGSizeMake(150, 150)]];

    [self.view addSubview:imageView];
}
- (void)SHImageColor {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 100, SCREENWIDTH - 100, SCREENWIDTH - 100)];
    imageView.backgroundColor = [UIColor cyanColor];
    [imageView setContentMode:(UIViewContentModeCenter)];
    [imageView setImage:[UIImage imageWithColor:[UIColor purpleColor] size:CGSizeMake(150, 150)]];
    
    [self.view addSubview:imageView];
}
- (void)SHImageScreenImage {
    UIImage *image = [UIImage imageNamed:@"5"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, SCREENWIDTH, SCREENWIDTH + 150)];
    imageView.backgroundColor = [UIColor cyanColor];
    [imageView setContentMode:(UIViewContentModeCenter)];
    [imageView setImage:[image snapshotScreenBackgroundColor:[UIColor redColor]]];
    
    [self.view addSubview:imageView];
}
- (void)SHImageWaterImage {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, SCREENWIDTH, SCREENWIDTH - 100)];
    imageView.backgroundColor = [UIColor cyanColor];
    [imageView setContentMode:(UIViewContentModeScaleToFill)];
    [imageView setImage:[UIImage waterMakeImage:@"4" underImage:@"2"]];
    
    [self.view addSubview:imageView];
}
- (void)SHImageStringImage {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, SCREENWIDTH, SCREENWIDTH - 100)];
    imageView.backgroundColor = [UIColor cyanColor];
    [imageView setContentMode:(UIViewContentModeCenter)];
    [imageView setImage:[UIImage getImageWithString:@"测试图片啊，不信你试试\n测试图片啊，不信你试试\n测试图片啊，不信你试试"
                                               font:[UIFont boldSystemFontOfSize:15]
                                          textColor:[UIColor blackColor]
                                    backgroundColor:[UIColor lightGrayColor] size:CGSizeMake(SCREENWIDTH - 100, 100)]];
    
    [self.view addSubview:imageView];
}
- (void)SHImageAttributedStringImage {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, SCREENWIDTH, SCREENWIDTH - 100)];
    imageView.backgroundColor = [UIColor cyanColor];
    [imageView setContentMode:(UIViewContentModeCenter)];
    
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:@"测试富文本图片，不信你试试啊\n不信你试试啊"];
    [att addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],
                         NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(0, att.length)];
    NSMutableAttributedString *att1 = [[NSMutableAttributedString alloc] initWithString:@"\n测试富文本图片，不信你试\n测试富文本图片，不信你试"];
    [att1 addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11],
                         NSForegroundColorAttributeName:[UIColor yellowColor]} range:NSMakeRange(0, att1.length)];
    [att appendAttributedString:att1];
    
    [imageView setImage:[UIImage getImageWithAttributedString:att backgroundColor:[UIColor lightGrayColor] size:CGSizeMake(SCREENWIDTH - 100, 100)]];
    
    [self.view addSubview:imageView];
}
- (void)SHImageSourceName {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, SCREENWIDTH, SCREENWIDTH + 150)];
    imageView.backgroundColor = [UIColor cyanColor];
    [imageView setContentMode:(UIViewContentModeScaleAspectFit)];
    [imageView setImage:[UIImage animatedGIFNamed:@"3"]];
    
    [self.view addSubview:imageView];
}
- (void)SHImageSourceData {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, SCREENWIDTH, SCREENWIDTH + 150)];
    imageView.backgroundColor = [UIColor cyanColor];
    [imageView setContentMode:(UIViewContentModeScaleAspectFit)];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"3" ofType:@"gif"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    [imageView setImage:[UIImage animatedGIFWithData:data]];
    
    [self.view addSubview:imageView];
}
- (void)SHImageSourceImageSize {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, SCREENWIDTH, SCREENWIDTH + 150)];
    imageView.backgroundColor = [UIColor cyanColor];
    [imageView setContentMode:(UIViewContentModeCenter)];
    [imageView setImage:[[UIImage animatedGIFNamed:@"3"] animatedImageByScalingAndCroppingToSize:CGSizeMake(200, 60)]];
    
    [self.view addSubview:imageView];
}

- (void)SHImageSourceImageDrawArc {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 150, 150)];
    imageView.backgroundColor = [UIColor whiteColor];
    imageView.clipsToBounds = YES;
    imageView.layer.cornerRadius = 75;
    imageView.layer.borderWidth = 1;
    imageView.layer.borderColor = UIColor.redColor.CGColor;
    [imageView setContentMode:(UIViewContentModeCenter)];
    UIImage *image = [UIImage drawArcImageSize:CGSizeMake(150, 150)
                                        colors:@[UIColor.cyanColor,
                                                 UIColor.orangeColor,
                                                 UIColor.greenColor,
                                                 UIColor.orangeColor,
                                                 UIColor.cyanColor,
                                                 UIColor.orangeColor,
                                                 UIColor.cyanColor,
                                                 UIColor.orangeColor,
                                                 UIColor.cyanColor,
                                                 UIColor.orangeColor]
                                        values:@[@(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1)]
                                   strokeColor:UIColor.redColor
                                   strokeWidth:1];
    [imageView setImage:image];
    [self.view addSubview:imageView];
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:(360 * M_PI / 180.0 * 5)];
    rotationAnimation.duration = 3.f;
    rotationAnimation.cumulative = YES;
    //由慢->快->慢
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotationAnimation.fillMode = kCAFillModeForwards;
    rotationAnimation.removedOnCompletion = NO;
    [imageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
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
