//
//  CMScene.h
//  
//
//  Created by luck-mac on 15/6/24.
//
//

#import <Foundation/Foundation.h>
#import "CMQuestionFactory.h"

@interface CMScene : NSObject
@property (nonatomic) NSInteger point;
@property (nonatomic, strong) CMQuestion *currentQuestion;
@property (nonatomic, strong) CMQuestion *nextQuestion;
- (instancetype)initWithGameMode:(GameMode)gameMode;
- (void)showNextQuestion;
@end
