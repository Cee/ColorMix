//
//  AppDelegate.m
//  ColorMix
//
//  Created by Cee on 24/06/2015.
//  Copyright (c) 2015 Cee. All rights reserved.
//

#import "AppDelegate.h"
#import "CMMenuViewController.h"
#import "CMGameCenterHelper.h"

@interface AppDelegate () <GKGameCenterControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![userDefaults objectForKey:kFirstLaunchKey]) {
        [userDefaults setObject:@"钦哥哥好帅" forKey:kFirstLaunchKey];
        [userDefaults setBool:NO forKey:kGrayscaleSwitchKey];
        [userDefaults setBool:NO forKey:kVibrateSwitchKey];
        [userDefaults synchronize];
    }
    // init analytics
    [self registerUmengTraking];
    
    [self authenticateLocalUser];
    // init views
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    CMMenuViewController *menuViewController = [[CMMenuViewController alloc] initWithNibName:NSStringFromClass([CMMenuViewController class]) bundle:nil];
    UINavigationController *rootNavigationController = [[UINavigationController alloc] initWithRootViewController:menuViewController];
    [rootNavigationController setNavigationBarHidden:YES];
    self.window.rootViewController = rootNavigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Private Method
- (void)registerUmengTraking
{
    [MobClick startWithAppkey:kUmengAppKey reportPolicy:BATCH channelId:@"Test"];
}

#pragma mark - Game Center
- (void)authenticateLocalUser
{
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    __weak __typeof__(self) weakSelf = self;
    
    if (!localPlayer.authenticateHandler) {
        [localPlayer setAuthenticateHandler:(^(UIViewController* viewcontroller, NSError* error) {
            if (error) {
                NSLog(@"Game Center Error: %@", [error localizedDescription]);
            }
            if (viewcontroller) {
                [weakSelf presentGameCenterController:viewcontroller];
            } else if ([[GKLocalPlayer localPlayer] isAuthenticated]) {
                // Enable GameKit features
                NSLog(@"Player already authenticated");
            } else {
                // Disable GameKit features
                NSLog(@"Player not authenticated");
            }
        })];
    } else {
        NSLog(@"Authentication Handler already set");
    }
}

- (void)testForGameCenterDismissal
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        if ([UIApplication sharedApplication].keyWindow.rootViewController.presentedViewController) {
            NSLog(@"Still presenting game center login");
            [self testForGameCenterDismissal];
        }
        else {
            NSLog(@"Done presenting, clean up");
            [self gameCenterViewControllerCleanUp];
        }
    });
}

- (void)presentGameCenterController:(UIViewController *)viewController
{
    BOOL testForGameCenterDismissalInBackground = YES;
    if ([viewController isKindOfClass:[GKGameCenterViewController class]]) {
        [(GKGameCenterViewController *)viewController setGameCenterDelegate:self];
        testForGameCenterDismissalInBackground = NO;
    }
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:viewController
                                                                                 animated:YES
                                                                               completion:^{
        if (testForGameCenterDismissalInBackground) {
            [self testForGameCenterDismissal];
        }
    }];
}

- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController
{
    [self gameCenterViewControllerCleanUp];
}

- (void)gameCenterViewControllerCleanUp
{
    // Do whatever needs to be done here, resume game etc
}

@end
