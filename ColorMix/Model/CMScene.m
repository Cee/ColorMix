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
        self.nextQuestion = [self.questionFactory createQuestionOfMode:gameMode];
    }
    return self;
}

- (void) showNextQuestion {
    self.currentQuestion = self.nextQuestion;
    self.nextQuestion = [self.questionFactory createQuestionOfMode:self.currentMode];
}

@end
