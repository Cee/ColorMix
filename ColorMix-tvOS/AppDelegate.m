//
//  AppDelegate.m
//  ColorMix-tvOS
//
//  Created by Cee on 10/09/2015.
//  Copyright © 2015 Cee. All rights reserved.
//

#import "AppDelegate.h"
#import "CMMenuViewController.h"
#import "CMGameCenterHelper.h"

@interface AppDelegate () <GKGameCenterControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    [self registerUmenddgTraking];
    
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
                if (![[NSUserDefaults standardUserDefaults] objectForKey:kGameCenterEntryKey]) {
                    [weakSelf presentGameCenterController:viewcontroller];
                }
            } else if ([[GKLocalPlayer localPlayer] isAuthenticated]) {
                NSLog(@"Player already authenticated");
            } else {
                NSLog(@"Player not authenticated");
            }
        })];
    } else {
        NSLog(@"Authentication Handler already set");
    }
    [[NSUserDefaults standardUserDefaults] setObject:@"钦哥哥才不帅" forKey:kGameCenterEntryKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
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
                                                                               completion:nil];
}

- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController
{
    [self gameCenterViewControllerCleanUp];
}

- (void)gameCenterViewControllerCleanUp
{
    // Do nothing here
}


@end
