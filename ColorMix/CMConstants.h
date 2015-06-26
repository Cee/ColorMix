//
//  CMConstants.h
//  ColorMix
//
//  Created by Cee on 25/06/2015.
//  Copyright (c) 2015 Cee. All rights reserved.
//

#ifndef ColorMix_CMConstants_h
#define ColorMix_CMConstants_h

#define kUmengAppKey                    @"558bb56c67e58ef671001f86"
#define kAppStoreUrl                    @"https://itunes.apple.com/app/co!ormix/id1011677035"

// keys
#define kFirstLaunchKey @"firstLaunch"
#define kClassicHighScoreKey @"classicHighScore"
#define kFantasyHighScoreKey @"fantasyHighScore"
#define kGrayscaleSwitchKey @"grayscaleSwitch"
#define kFirstPlayClassicKey @"fistPlayClassic"
#define kFirstPlayFantasyKey @"firstPlayFantasy"
#define kVibrateSwitchKey @"vibrateSwitch"

// Macros
#define IOS8_OR_LATER   ([[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending)
#define IS_IPAD         UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPhone
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#endif
