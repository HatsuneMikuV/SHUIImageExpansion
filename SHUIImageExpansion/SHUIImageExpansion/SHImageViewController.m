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
            
        default:
            break;
    }
}
- (void)SHImageRadius {
    
}
- (void)SHImageSize {
    
}
- (void)SHImageColor {
    
}
- (void)SHImageScreenImage {
    
}
- (void)SHImageWaterImage {
    
}
- (void)SHImageStringImage {
    
}
- (void)SHImageAttributedStringImage {
    
}
- (void)SHImageSourceName {
    
}
- (void)SHImageSourceData {
    
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
