//
//  CMGameCenterHelper.m
//  ColorMix
//
//  Created by Cee on 27/06/2015.
//  Copyright (c) 2015 Cee. All rights reserved.
//

#import "CMGameCenterHelper.h"

@implementation CMGameCenterHelper

+ (void)submitScore:(int64_t)score category:(NSString *)leaderboardIdentifier
{
    if (![GKLocalPlayer localPlayer].authenticated) {
        NSLog(@"GKLocalPlayer is not authenticated");
        return;
    }
    GKScore *gkScore = [[GKScore alloc] initWithLeaderboardIdentifier:leaderboardIdentifier];
    gkScore.value = score;
    NSArray *array = [[NSArray alloc] initWithObjects:gkScore, nil];
    [GKScore reportScores:array withCompletionHandler:^(NSError *error) {
        
    }];
}

@end
