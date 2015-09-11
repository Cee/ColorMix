//
//  UIView+ColorMix.h
//  
//
//  Created by luck-mac on 15/6/25.
//
//

#import <UIKit/UIKit.h>
#import "CMColor.h"

@interface UIView (ColorMix)

/** 设定视图背景颜色
 @param color 以 CMColor 类别中的 color 当作背景色
 @returns void
 */
- (void)cm_setBackgroundColor:(CMColor *)color;

/** 设定视图圆角, 圆角大小为长或宽最小值的一半
 @returns void
 */
- (void)cm_setToRounded;

/** 为视图右方添加阴影, 阴影偏移量 20, 半径 10, 透明度 0.5
 @returns void
 */
- (void)cm_addShadowAtRight;

@end
