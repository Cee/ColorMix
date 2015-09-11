//
//  UIColor+ColorMix.m
//  
//
//  Created by luck-mac on 15/6/25.
//
//

#import "UIColor+ColorMix.h"

@implementation UIColor (ColorMix)

+ (UIColor *)cm_colorWithHexString:(NSString *)hexString
{
    // 去除空白与换行符后转大写
    NSString *pureHexString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // 长度不符则回传白色
    if ([pureHexString length] != 6) {
        return [UIColor whiteColor];
    }
    
    // 拆成 hex R, G, B字串
    NSRange range = NSMakeRange(0, 2);
    
    NSString *rString = [pureHexString substringWithRange:range];
    
    range.location += range.length;
    NSString *gString = [pureHexString substringWithRange:range];
    
    range.location += range.length;
    NSString *bString = [pureHexString substringWithRange:range];

    // R, G, B字串转数字
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    // 回传颜色
    return [UIColor colorWithRed:((float)r / 255.f)
                           green:((float)g / 255.f)
                            blue:((float)b / 255.f)
                           alpha:1.f];
}

@end
