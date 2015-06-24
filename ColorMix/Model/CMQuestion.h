//
//  CMQuestion.h
//  
//
//  Created by luck-mac on 15/6/24.
//
//

#import <Foundation/Foundation.h>
#import "CMCard.h"

@interface CMQuestion : NSObject
@property (nonatomic, strong) NSArray *cardList;
@property (nonatomic, strong) NSArray *options;
@property (nonatomic) NSInteger targetCardIndex;
@property (nonatomic) NSInteger limitTime;
- (BOOL)checkAnswer:(NSInteger)answerIndex;
- (NSString*)getQuestion;
- (instancetype)initWithCardList:(NSArray*)cardList;
@end
