//
//  CMCard.h
//  
//
//  Created by luck-mac on 15/6/24.
//
//

#import <Foundation/Foundation.h>
typedef enum {
    background = 0,
    textColor = 1,
    textContent = 2
} Element;
@interface CMCard : NSObject
- (instancetype) initWithColorArray:(NSArray*)colorArray;
- (NSArray *) generateOptions;
- (NSInteger) getAnswerByOptions:(NSArray*)options andElement:(Element)element;
@end
