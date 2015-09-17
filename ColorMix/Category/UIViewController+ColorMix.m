//
//  UIViewController+ColorMix.m
//  ColorMix
//
//  Created by Cee on 25/06/2015.
//  Copyright © 2015 Cee. All rights reserved.
//

#import "UIViewController+ColorMix.h"

@implementation UIViewController (ColorMix)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // method swizzling viewWillAppear:
        Class class = [self class];
        
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzledSelector = @selector(cm_viewWillAppear:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)cm_viewWillAppear:(BOOL)animated
{
    [self cm_viewWillAppear:animated];
    // Go tracking here
}

@end
