//
//  UILabel+ColorMix.h
//
//
//  Created by luck-mac on 15/6/25.
//
//

#import <UIKit/UIKit.h>

@interface UILabel (ColorMix)

/** 设置 Label 字样的颜色
 @param color 以 CMColor 类别中的 color 当作字样颜色
 @returns void
 */
- (void)cm_setTextColor:(CMColor *)color;

/** 设置 Label 字样的内容
 @param color 以 CMColor 类别中的 colorName 当作字样内容
 @returns void
 */
- (void)cm_setText:(CMColor *)color;

@end
