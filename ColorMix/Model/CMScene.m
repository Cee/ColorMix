//
//  CMScene.m
//  
//
//  Created by luck-mac on 15/6/24.
//
//

#import "CMScene.h"

@interface CMScene()
@property (nonatomic) GameMode currentMode;
@property (nonatomic, strong) CMQuestionFactory *questionFactory;
@end

@implementation CMScene
- (instancetype)initWithGameMode:(GameMode)gameMode {
    self = [super init];
    if (self) {
        self.currentMode = gameMode;
        self.point = 0;
        self.questionFactory = [CMQuestionFactory sharedInstance];
        self.currentQuestion = [self.questionFactory createQuestionWithCardCount:1];
        self.currentQuestion.limitTime = [self limitTime];
        self.nextQuestion = [self.questionFactory createQuestionWithCardCount:1];
    }
    return self;
}

- (void)showNextQuestion {
    self.currentQuestion = self.nextQuestion;
    self.currentQuestion.limitTime = [self limitTime];
    NSInteger cardCount = 1;
    if (self.currentMode == fantasyMode) {
        if (self.point >= 24) {
            cardCount = 3;
        } else if (self.point >= 9) {
            cardCount = 2;
        }
    }
    self.point++;
    self.nextQuestion = [self.questionFactory createQuestionWithCardCount:cardCount];
}

- (CGFloat)limitTime {
    CGFloat limitTime = 6 - self.point * 0.05 ;
    return limitTime > 1.6 ? limitTime : 1.6;
}
@end
