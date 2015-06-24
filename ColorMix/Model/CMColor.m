//
//  CMColor.m
//  
//
//  Created by luck-mac on 15/6/24.
//
//

#import "CMColor.h"

@implementation CMColor
- (instancetype)initWithDictionary:(NSDictionary *)colorDic {
    self = [super init];
    if (self) {
        self.color = [UIColor colorWithHexString:colorDic[@"color"]];
        self.colorName = colorDic[@"colorName"];
    }
    return self;
}
@end
