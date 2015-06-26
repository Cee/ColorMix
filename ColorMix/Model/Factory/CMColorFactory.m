//
//  CMColorFactory.m
//  
//
//  Created by luck-mac on 15/6/24.
//
//

#import "CMColorFactory.h"

@interface CMColorFactory()
@property (nonatomic,strong) NSArray *colorArrays;
@end

@implementation CMColorFactory

+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [self new];
        [sharedInstance initColorArrays];
    });
    return sharedInstance;
}

#pragma mark - Public
- (CMColor *)createColor {
    int randomIndex = arc4random() % self.colorArrays.count;
    return [self.colorArrays objectAtIndex:randomIndex];
}

- (CMColor *)createColorExcept:(NSString *)colorName {
    CMColor *color = [self createColor];
    while ([color.colorName isEqualToString:colorName]) {
        color = [self createColor];
    }
    return color;
}

#pragma mark - Private
- (void) initColorArrays {
    //此处从plist文件中获取
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ColorList" ofType:@"plist"];
    NSArray *colorArrays = [[NSArray alloc] initWithContentsOfFile:path];
    NSMutableArray *cmColorArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in colorArrays) {
        [cmColorArray addObject:[[CMColor alloc] initWithDictionary:dic]];
    }
    self.colorArrays = cmColorArray;
}

@end
