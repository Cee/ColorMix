//
//  CMColorFactory.h
//  
//
//  Created by luck-mac on 15/6/24.
//
//

#import <Foundation/Foundation.h>
#import "CMColor.h"

@interface CMColorFactory : NSObject
+ (instancetype)sharedInstance;
- (CMColor*) createColor;
@end
