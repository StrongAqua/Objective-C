//
//  APIManager.h
//  AirTicketSaler
//
//  Created by aprirez on 3/9/21.
//

#import <Foundation/Foundation.h>
#import "SearchRequest.h"

@class City;

NS_ASSUME_NONNULL_BEGIN

@interface APIManager : NSObject

+ (instancetype)sharedInstance;
- (void)cityForCurrentIP:(void (^)(City *city))completion;
- (void)ticketsWithRequest: (SearchRequest)request withCompletion:(void(^)(NSArray *ticket))completion;
- (void)mapPricesFor:(City *)origin withCompletion:(void (^)(NSArray *prices))completion;


@end

NS_ASSUME_NONNULL_END
