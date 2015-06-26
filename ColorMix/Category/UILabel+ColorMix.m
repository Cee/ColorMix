//
//  UILabel+ColorMix.m
//  
//
//  Created by luck-mac on 15/6/25.
//
//

#import "UILabel+ColorMix.h"

@implementation UILabel (ColorMix)

- (void)cm_setText:(CMColor *)color {
    [self setText:color.colorName];
}

- (void)cm_setTextColor:(CMColor *)color {
    [self setTextColor:color.color];
}

@end
