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
        self.currentQuestion = [self.questionFactory createQuestionOfMode:gameMode];
        self.currentQuestion.limitTime = [self limitTime];
        self.nextQuestion = [self.questionFactory createQuestionOfMode:gameMode];
    }
    return self;
}

- (void)showNextQuestion {
    self.point++;
    self.currentQuestion = self.nextQuestion;
    self.currentQuestion.limitTime = [self limitTime];
    self.nextQuestion = [self.questionFactory createQuestionOfMode:self.currentMode];
}

- (NSInteger)limitTime {
    NSInteger limitTime = 10 - self.point / 5;
    return limitTime > 5 ? limitTime : 5;
}
@end
