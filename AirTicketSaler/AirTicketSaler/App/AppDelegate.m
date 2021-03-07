//
//  AppDelegate.m
//  AirTicketSaler
//
//  Created by aprirez on 3/2/21.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    CGRect windowFrame = [[UIScreen mainScreen] bounds];
    self.window = [[UIWindow alloc] initWithFrame: windowFrame];
    
    MainViewController *mainViewController = [[MainViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController: mainViewController];
    
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    return YES;
}



@end
