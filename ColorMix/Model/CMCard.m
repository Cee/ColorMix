//
//  CMCard.m
//  
//
//  Created by luck-mac on 15/6/24.
//
//

#import "CMCard.h"

@interface CMCard()
@property (nonatomic, strong) NSArray *colorArray;
@end

@implementation CMCard
- (instancetype)initWithColorArray:(NSArray *)colorArray {
    self = [super init];
    if (self) {
        self.backgroundColor = colorArray[0];
        self.textColor = colorArray[1];
        self.textContentColor = colorArray[2];
        self.colorArray = colorArray;
    }
    return self;
}

- (NSArray*) generateOptions {
    NSMutableArray *mutableOptions = [[NSMutableArray alloc] initWithArray:self.colorArray];
    NSUInteger count = [mutableOptions count];
    //乱序
    for (NSUInteger i = 0; i < count; ++i) {
        NSInteger nElements = count - i;
        NSInteger n = (arc4random() % nElements) + i;
        [mutableOptions exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    return mutableOptions;
}

- (NSInteger) getAnswerByOptions:(NSArray *)options Element:(Element)element {
    CMColor* targetColor = self.colorArray[element];
    int index = 0;
    for (index = 0; index < options.count; index ++) {
        CMColor* color = options[index];
        if ([targetColor.colorName isEqualToString:color.colorName]) {
            return index;
        }
    }
    return index;
}

@end
