//
//  CMColor.m
//  
//
//  Created by luck-mac on 15/6/24.
//
//

#import "CMColor.h"

@implementation CMColor
- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        if (dic) {
            self.color = dic[@"color"];
            self.colorName = dic[@"colorName"];
        }
    }
    return self;
}
@end
