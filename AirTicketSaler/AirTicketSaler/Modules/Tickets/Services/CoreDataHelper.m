//
//  CoreDataHelper.m
//  AirTicketSaler
//
//  Created by aprirez on 3/21/21.
//

#import "CoreDataHelper.h"

@interface CoreDataHelper ()
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@end


@implementation CoreDataHelper

+ (instancetype)sharedInstance
{
    static CoreDataHelper *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CoreDataHelper alloc] init];
        [instance setup];
    });
    return instance;
}

- (void)setup {
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"FavoriteTicket" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    NSURL *docsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *storeURL = [docsURL URLByAppendingPathComponent:@"base.sqlite"];
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_managedObjectModel];
    
    NSError* error;
    NSPersistentStore* store = [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
    if (!store) {
        NSLog(@"error = %@", error);
        abort();
    }
    
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    _managedObjectContext.persistentStoreCoordinator = _persistentStoreCoordinator;
}

- (void)save {
    NSError *error;
    [_managedObjectContext save: &error];
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
}

- (FavoriteTicket *)favoriteFromTicket:(Ticket *)ticket {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FavoriteTicket"];
    request.predicate = [NSPredicate predicateWithFormat:@"price == %ld AND airline == %@ AND from == %@ AND to == %@ AND departure == %@ AND expires == %@ AND flightNumber == %ld", (long)ticket.price.integerValue, ticket.airline, ticket.from, ticket.to, ticket.departure, ticket.expires, (long)ticket.flightNumber.integerValue];
    return [[_managedObjectContext executeFetchRequest:request error:nil] firstObject];
}

- (BOOL)isFavorite:(Ticket *)ticket {
    return [self favoriteFromTicket:ticket] != nil;
}

- (void)addToFavorite:(Ticket *)ticket {
    FavoriteTicket *favorite = [NSEntityDescription insertNewObjectForEntityForName:@"FavoriteTicket" inManagedObjectContext:_managedObjectContext];
    favorite.price = ticket.price.intValue;
    favorite.airline = ticket.airline;
    favorite.departure = ticket.departure;
    favorite.expires = ticket.expires;
    favorite.flightNumber = ticket.flightNumber.intValue;
    favorite.returnDate = ticket.returnDate;
    favorite.from = ticket.from;
    favorite.to = ticket.to;
    favorite.created = [NSDate date];
    [self save];
}

- (void)removeFromFavorite:(id)ticket {
    FavoriteTicket *favorite = NULL;
    if ([ticket isKindOfClass:[Ticket class]]) {
        favorite = [self favoriteFromTicket:ticket];
    } else if ([ticket isKindOfClass:[FavoriteTicket class]]) {
        favorite = ticket;
    }
    if (favorite) {
        [_managedObjectContext deleteObject:favorite];
        [self save];
    }
}

- (NSArray *)favorites {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FavoriteTicket"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"created" ascending:NO]];
    return [_managedObjectContext executeFetchRequest:request error:nil];
}

- (FavoriteMapPrice *)favoriteFromMapPrice:(MapPrice *)mapPrice {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FavoriteMapPrice"];
    request.predicate =
        [NSPredicate
         predicateWithFormat:@"origin == %@ AND destination == %@",
         mapPrice.origin.code,
         mapPrice.destination.code];
    return [[_managedObjectContext executeFetchRequest:request error:nil] firstObject];
}

- (BOOL)isFavoriteMapPrice:(MapPrice *)mapPrice {
    return [self favoriteFromMapPrice:mapPrice] != nil;
}

- (void)mapPriceAddToFavorite:(MapPrice *)mapPrice {
    FavoriteMapPrice *favorite = [NSEntityDescription insertNewObjectForEntityForName:@"FavoriteMapPrice" inManagedObjectContext:_managedObjectContext];
    favorite.destination = mapPrice.destination.code;
    favorite.origin = mapPrice.origin.code;
    favorite.departure = mapPrice.departure;
    favorite.returnDate = mapPrice.returnDate;
    favorite.numberOfChanges = mapPrice.numberOfChanges;
    favorite.value = mapPrice.value;
    favorite.distance = mapPrice.distance;
    favorite.actual = mapPrice.actual;
    favorite.created = [NSDate date];
    [self save];
}

- (void)mapPriceRemoveFromFavorite:(id) mapPrice {
    FavoriteMapPrice *favorite = NULL;
    if ([mapPrice isKindOfClass:[MapPrice class]]) {
        favorite = [self favoriteFromMapPrice:mapPrice];
    } else if ([mapPrice isKindOfClass:[FavoriteMapPrice class]]) {
        favorite = mapPrice;
    }
    if (favorite) {
        [_managedObjectContext deleteObject:favorite];
        [self save];
    }
}

- (NSArray *)favoritesMapPrices {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FavoriteMapPrice"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"created" ascending:NO]];
    return [_managedObjectContext executeFetchRequest:request error:nil];
}

@end
