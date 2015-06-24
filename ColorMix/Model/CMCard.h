//
//  CMCard.h
//  
//
//  Created by luck-mac on 15/6/24.
//
//

#import <Foundation/Foundation.h>
#import "CMColor.h"

typedef enum {
    background = 0,
    textColor = 1,
    textContent = 2
} Element;

@interface CMCard : NSObject
@property (nonatomic, strong) CMColor *backgroundColor;
@property (nonatomic, strong) CMColor *textColor;
@property (nonatomic, strong) CMColor *textContentColor;

- (instancetype)initWithColorArray:(NSArray *)colorArray;
- (NSArray *)generateOptions;
- (NSInteger)getAnswerByOptions:(NSArray*)options Element:(Element)element;
@end
