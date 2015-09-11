//
//  UIColor+ColorMix.h
//  
//
//  Created by luck-mac on 15/6/25.
//
//

#import <UIKit/UIKit.h>

@interface UIColor (ColorMix)

/** 从 HEX 色码转为的UIColor
 @param string hex 色码
 @returns 转换成的 UIColor
 */
+ (UIColor *)cm_colorWithHexString:(NSString *)hexString;

@end
