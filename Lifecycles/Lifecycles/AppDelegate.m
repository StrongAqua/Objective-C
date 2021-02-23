//
//  AppDelegate.m
//  Lifecycles
//
//  Created by aprirez on 2/23/21.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSLog(@"UIApplication, didFinishLaunchingWithOptions");
    return YES;
}

// developer.apple.com says:
// If you're using scenes (see Scenes), UIKit will not call this method.
// SceneDelegate:sceneWillResignActive will be called instead
- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"UIApplication, applicationWillResignActive");
}

// developer.apple.com says:
// If you're using scenes (see Scenes), UIKit will not call this method.
// SceneDelegate:didBecomeActiveNotification will be called instead.
- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"UIApplication, applicationDidBecomeActive");
}

// developer.apple.com says:
// If you're using scenes (see Scenes), UIKit will not call this method.
// SceneDelegate:didBecomeActiveNotification will be called instead.
- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"UIApplication, applicationDidEnterBackground");
}

// developer.apple.com says:
// If you're using scenes (see Scenes), UIKit will not call this method.
// SceneDelegate:willEnterForegroundNotification will be called instead.
- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"UIApplication, applicationWillEnterForeground");
}

// Should add UIApplicationExitsOnSuspend = true to the Info.plist
// for this callback
- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"UIApplication, applicationWillTerminate");
}

#pragma mark - UISceneSession lifecycle

- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    NSLog(@"UIApplication, do init scene");
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}

- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    NSLog(@"UIApplication, did discard scene");
}


@end
