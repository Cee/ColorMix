//
//  UIView+ColorMix.m
//  
//
//  Created by luck-mac on 15/6/25.
//
//

#import "UIView+ColorMix.h"

@implementation UIView (ColorMix)

- (void)cm_setBackgroundColor:(CMColor*)backgroundColor {
    [self setBackgroundColor:backgroundColor.color];
}

-(void)setToRounded {
    self.layer.cornerRadius = MIN(self.frame.size.height,self.frame.size.width) / 2.0;
    self.clipsToBounds = YES;
}

@end
