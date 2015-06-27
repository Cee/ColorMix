//
//  CMGameCenterHelper.h
//  ColorMix
//
//  Created by Cee on 27/06/2015.
//  Copyright (c) 2015 Cee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMGameCenterHelper : NSObject
+ (void)submitScore:(int64_t)score category:(NSString *)leaderboardIdentifier;
@end
