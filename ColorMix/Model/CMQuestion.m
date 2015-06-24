//
//  CMQuestion.m
//  
//
//  Created by luck-mac on 15/6/24.
//
//

#import "CMQuestion.h"
#import "CMCard.h"
@interface CMQuestion()
@property (nonatomic,strong) NSArray *cardList;
@property (nonatomic,strong) NSArray *options;
@property (nonatomic) NSInteger targetCardIndex;
@property (nonatomic) Element targetElement;
@property (nonatomic) NSInteger answerIndex;
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
        CMCard* targetCard = self.cardList[self.targetCardIndex];
        self.options = [targetCard generateOptions];
        self.targetElement = arc4random() % 3;
        self.answerIndex = [targetCard getAnswerByOptions:self.options andElement:self.targetElement];
    }
    return self;
}

- (BOOL)checkAnswer:(NSInteger)answerIndex {
    return answerIndex == self.answerIndex;
}
@end
