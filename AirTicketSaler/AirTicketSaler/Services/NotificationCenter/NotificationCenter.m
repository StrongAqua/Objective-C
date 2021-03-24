//
//  NotificationCenter.m
//  AirTicketSaler
//
//  Created by aprirez on 3/24/21.
//

#import "NotificationCenter.h"
#import <UserNotifications/UserNotifications.h>
#import <UIKit/UIImage.h>
#import "AppDelegate.h"
#import "TabBarController.h"

@interface NotificationCenter () <UNUserNotificationCenterDelegate>
@end

@implementation NotificationCenter

+ (instancetype)sharedInstance
{
    static NotificationCenter *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NotificationCenter alloc] init];
    });
    return instance;
}

- (void) registerService {
    UNUserNotificationCenter *center =
        [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    [center
        requestAuthorizationWithOptions:(
            UNAuthorizationOptionBadge |
            UNAuthorizationOptionSound |
            UNAuthorizationOptionAlert )
        completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (!error) {
                NSLog(@"request authorization succeeded!");
            }
    }];
}

- (NSString *) saveImageWithId:(UIImage*)image {
    // Create path.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *name = [[NSProcessInfo processInfo] globallyUniqueString];
    name = [name stringByAppendingString:@".png"];
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:name];

    // Save image.
    [UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES];
    return filePath;
}

- (void)sendNotification:(Notification)notification {
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = notification.title;
    content.body = notification.body;
    content.sound = [UNNotificationSound defaultSound];
    content.userInfo = notification.customData;

    if (notification.image) {
        NSString* imagePath = [self saveImageWithId:notification.image];
        NSURL* imageURL = [[NSURL alloc] initFileURLWithPath:imagePath];
        UNNotificationAttachment *attachment =
            [UNNotificationAttachment
                attachmentWithIdentifier:@"image"
                URL:imageURL options:nil error:nil];
        if (attachment) {
            content.attachments = @[attachment];
        }
    }
    
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *components = [calendar componentsInTimeZone:[NSTimeZone systemTimeZone] fromDate:notification.date];

    NSDateComponents *newComponents = [[NSDateComponents alloc] init];
    newComponents.calendar = calendar;
    newComponents.timeZone = [NSTimeZone defaultTimeZone];
    newComponents.month = components.month;
    newComponents.day = components.day;
    newComponents.hour = components.hour;
    newComponents.minute = components.minute;
    
    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:newComponents repeats:NO];
    
    // DEBUG:
    // UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:10 repeats:NO];
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"Notification" content:content trigger:trigger];
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (!error) {
            NSLog(@"ADD: NotificationRequest succeeded!");
        } else {
            NSLog(@"ERROR: NotificationRequest, %@", error);
        }
    }];
}

- (void) userNotificationCenter:(UNUserNotificationCenter *)center
 didReceiveNotificationResponse:(UNNotificationResponse *)response
          withCompletionHandler:(void (^)(void))completionHandler {
    for (id attach in response.notification.request.content.attachments) {
        if ([attach isKindOfClass:[UNNotificationAttachment class]]) {
            UNNotificationAttachment* a = (UNNotificationAttachment*) attach;
            if ([NSString isEqual:@"image"]) {
                NSFileManager *manager = [NSFileManager defaultManager];
                NSError* error;
                [manager removeItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:a.URL.path] error:&error];
                if (error) {
                    NSLog(@"Can't delete file: %@", a.URL.path);
                }
            }
        }
    }
    NSLog(@"USER Tapped notification!!!");
    completionHandler();
    [self openFavoriteViewController];
}

- (void) userNotificationCenter:(UNUserNotificationCenter *)center
        willPresentNotification:(UNNotification *)notification
          withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    NSLog(@"FOREGROUND NOTIFICATION!");
    completionHandler((
                       UNAuthorizationOptionBadge |
                       UNAuthorizationOptionSound |
                       UNAuthorizationOptionAlert ));
    [self openFavoriteViewController];
}

- (void) openFavoriteViewController {
    UIWindow* keyWindow = [AppDelegate getKeyWindow];
    id rootController = keyWindow.rootViewController;
    if (rootController && [rootController isKindOfClass:[TabBarController class]]) {
        TabBarController* tabBarController = (TabBarController*) rootController;
        [tabBarController setSelectedIndex:2];
    }
}

Notification NotificationMake(NSString* _Nullable title, NSString* _Nonnull body, NSDate* _Nonnull date, UIImage * _Nullable image, NSDictionary* customData) {
    Notification notification;
    notification.title = title;
    notification.body = body;
    notification.date = date;
    notification.image = image;
    notification.customData = customData;
    return notification;
}

@end

