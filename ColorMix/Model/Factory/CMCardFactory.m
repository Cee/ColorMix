//
//  CMCardFactory.m
//  
//
//  Created by luck-mac on 15/6/24.
//
//

#import "CMCardFactory.h"
#import "CMColorFactory.h"

@implementation CMCardFactory

+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [self new];
    });
    return sharedInstance;
}

- (CMCard *)createCard {
    NSMutableArray *cmColorArray = [[NSMutableArray alloc] initWithCapacity:3];
    while (cmColorArray.count < 3) {
        CMColor* color = [[CMColorFactory sharedInstance] createColor];
        __block BOOL isRepeated = NO;
        [cmColorArray enumerateObjectsUsingBlock:^(CMColor *addedColor, NSUInteger idx, BOOL *stop) {
            if ([color.colorName isEqualToString:addedColor.colorName]) {
                *stop = YES;
                isRepeated = YES;
            }
        }];
        if (!isRepeated) {
            [cmColorArray addObject:color];
        }
    }
    CMCard *card = [[CMCard alloc] initWithColorArray:cmColorArray];
    return card;
}

@end
