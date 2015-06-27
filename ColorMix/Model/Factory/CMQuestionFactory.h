//
//  CMQuestionFactory.h
//  
//
//  Created by luck-mac on 15/6/24.
//
//

#import <Foundation/Foundation.h>
#import "CMQuestion.h"

@interface CMQuestionFactory : NSObject
+ (instancetype)sharedInstance;
- (CMQuestion *)createQuestionWithCardCount:(NSInteger)cardCount;
@end
