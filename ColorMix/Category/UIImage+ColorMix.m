//
//  UIImage+ColorMix.m
//  
//
//  Created by luck-mac on 15/6/25.
//
//

#import "UIImage+ColorMix.h"

@implementation UIImage (ColorMix)

+ (UIImage *)cm_captureImageFromView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.frame.size, YES, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
