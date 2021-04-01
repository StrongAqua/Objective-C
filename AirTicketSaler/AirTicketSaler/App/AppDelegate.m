//
//  AppDelegate.m
//  AirTicketSaler
//
//  Created by aprirez on 3/2/21.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "MapViewController.h"
#import "TabBarController.h"
#import "NotificationCenter.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    CGRect windowFrame = [[UIScreen mainScreen] bounds];
    self.window = [[UIWindow alloc] initWithFrame: windowFrame];
    
    TabBarController *tabBarController = [[TabBarController alloc] init];
       
    self.window.rootViewController = tabBarController;
    
    [self.window makeKeyAndVisible];
    
    [[NotificationCenter sharedInstance] registerService];
    
    return YES;
}

+ (UIWindow*) getKeyWindow {
    for (id window in [[UIApplication sharedApplication] windows]) {
        UIWindow* w = (UIWindow*) window;
        if (w.keyWindow) {
            return w;
        }
    }
    return nil;
}

@end
