//
//  CoreDataHelper.h
//  AirTicketSaler
//
//  Created by aprirez on 3/21/21.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "DataManager.h"
#import "FavoriteTicket+CoreDataClass.h"
#import "FavoriteMapPrice+CoreDataClass.h"
#import "MapPrice.h"
#import "Ticket.h"

@interface CoreDataHelper : NSObject

+ (instancetype)sharedInstance;

- (BOOL)isFavorite:(Ticket *)ticket;
- (void)addToFavorite:(Ticket *)ticket;
- (void)removeFromFavorite:(id)ticket;
- (FavoriteTicket *)favoriteFromTicket:(Ticket *)ticket;

- (BOOL)isFavoriteMapPrice:(MapPrice *)mapPrice;
- (void)mapPriceAddToFavorite:(MapPrice *)mapPrice;
- (void)mapPriceRemoveFromFavorite:(id)mapPrice;

- (NSArray *)favorites;
- (NSArray *)favoritesMapPrices;

@end

