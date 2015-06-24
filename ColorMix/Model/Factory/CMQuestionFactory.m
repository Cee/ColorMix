//
//  CMQuestionFactory.m
//  
//
//  Created by luck-mac on 15/6/24.
//
//

#import "CMQuestionFactory.h"
#import "CMCardFactory.h"
@implementation CMQuestionFactory
+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [self new];
    });
    return sharedInstance;
}

- (CMQuestion *)createQuestionOfMode:(GameMode)mode {
    NSInteger cardCount = mode == easy ? 1 : 3;
    NSMutableArray *cardList = [[NSMutableArray alloc] initWithCapacity:3];
    for (int i = 0 ; i < cardCount ; i ++) {
        CMCard* randomCard = [[CMCardFactory sharedInstance] createCard];
        [cardList addObject:randomCard];
    }
    CMQuestion* question = [[CMQuestion alloc] initWithCardList:cardList];
    return question;
}
@end
