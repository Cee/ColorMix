//
//  CMCardFactory.h
//  
//
//  Created by luck-mac on 15/6/24.
//
//

#import <Foundation/Foundation.h>
#import "CMCard.h"

@interface CMCardFactory : NSObject
+ (instancetype)sharedInstance;
- (CMCard *)createCard;
@end
