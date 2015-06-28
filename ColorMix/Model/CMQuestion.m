//
//  CMQuestion.m
//  
//
//  Created by luck-mac on 15/6/24.
//
//

#import "CMQuestion.h"

@interface CMQuestion()
@property (nonatomic) NSInteger answerIndex;
@property (nonatomic) Element targetElement;
@end

@implementation CMQuestion

- (instancetype)initWithCardList:(NSArray *)cardList {
    self = [super init];
    if (self) {
        self.cardList = cardList;
        if (self.cardList.count == 1) {
            self.targetCardIndex = 0;
        } else {
            self.targetCardIndex = arc4random() % self.cardList.count;
        }
        CMCard *targetCard = self.cardList[self.targetCardIndex];
        self.options = [targetCard generateOptions];
        self.targetElement = arc4random() % 3;
        self.answerIndex = [targetCard getAnswerByOptions:self.options Element:self.targetElement];
    }
    return self;
}

- (BOOL)checkAnswer:(NSInteger)answerIndex {
    return answerIndex == self.answerIndex;
}

- (NSString *)getQuestion {
    switch (_targetElement) {
        case background:
            return @"Background";
            break;
        case textColor:
            return @"Color";
            break;
        case textContent:
            return @"Meaning";
        default:
            break;
    }
    return nil;
}
@end
