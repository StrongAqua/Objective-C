//
//  NotificationCenter.h
//  AirTicketSaler
//
//  Created by aprirez on 3/24/21.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIImage.h>

typedef struct Notification {
    __unsafe_unretained NSString * _Nullable title;
    __unsafe_unretained NSString * _Nonnull body;
    __unsafe_unretained NSDate * _Nonnull date;
    __unsafe_unretained UIImage * _Nullable image;
    __unsafe_unretained NSDictionary * _Nullable customData;
} Notification;

@interface NotificationCenter : NSObject

+ (instancetype _Nonnull)sharedInstance;

- (void)registerService;
- (void)sendNotification:(Notification)notification;

Notification NotificationMake(
    NSString* _Nullable title,
    NSString* _Nonnull body,
    NSDate* _Nonnull date,
    UIImage* _Nullable image,
    NSDictionary* _Nullable customData
);

@end

