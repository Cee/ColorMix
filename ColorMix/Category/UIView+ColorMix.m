//
//  UIView+ColorMix.m
//  
//
//  Created by luck-mac on 15/6/25.
//
//

#import "UIView+ColorMix.h"

@implementation UIView (ColorMix)

- (void)cm_setBackgroundColor:(CMColor *)color
{
    [self setBackgroundColor:color.color];
}

- (void)cm_setToRounded
{
    self.layer.cornerRadius = MIN(self.frame.size.height, self.frame.size.width) / 2.0;
    self.clipsToBounds = YES;
}

- (void)cm_addShadowAtRight
{
    self.layer.shadowOffset = CGSizeMake(0, 20);
    self.layer.shadowRadius = 10;
    self.layer.shadowOpacity = 0.5;
}

@end
