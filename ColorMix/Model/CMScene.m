//
//  CMScene.m
//  
//
//  Created by luck-mac on 15/6/24.
//
//

#import "CMScene.h"
#import "CMQuestionFactory.h"
@interface CMScene()
@property (nonatomic) GameMode currentMode;
@property (nonatomic) NSInteger point;
@property (nonatomic,strong) CMQuestion *currentQuestion;
@property (nonatomic,strong) CMQuestion *nextQuestion;
@end
@implementation CMScene
- (instancetype)initWithGameMode:(GameMode)gameMode {
    self = [super init];
    if (self) {
        self.currentMode = gameMode;
        self.point = 0;
        self.currentQuestion = [[CMQuestionFactory sharedInstance] createQuestionOfMode:gameMode];
        self.nextQuestion = [[CMQuestionFactory sharedInstance] createQuestionOfMode:gameMode];
    }
    return self;
}

- (void) chooseAnswer:(NSInteger) answerIndex {
    if ([_currentQuestion checkAnswer:answerIndex]) {
        self.point ++;
        [self showNextQuestion];
    }
}

- (void) showNextQuestion {
    self.currentQuestion = self.nextQuestion;
    self.nextQuestion = [[CMQuestionFactory sharedInstance] createQuestionOfMode:self.currentMode];
}

@end
