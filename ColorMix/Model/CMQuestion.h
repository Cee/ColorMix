//
//  CMQuestion.h
//  
//
//  Created by luck-mac on 15/6/24.
//
//

#import <Foundation/Foundation.h>


@interface CMQuestion : NSObject
- (BOOL) checkAnswer:(NSInteger)answerIndex;
- (instancetype) initWithCardList:(NSArray*)cardList;
@end
