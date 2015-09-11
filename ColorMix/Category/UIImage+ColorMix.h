//
//  UIImage+ColorMix.h
//  
//
//  Created by luck-mac on 15/6/25.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (ColorMix)

/** 将目标 view 转化为 UIImage
 @param view 要转换成的 UIImage 的目标
 @returns 由 view 输出而成的的 UIImage
 */
+ (UIImage *)cm_captureImageFromView:(UIView *)view;

@end
