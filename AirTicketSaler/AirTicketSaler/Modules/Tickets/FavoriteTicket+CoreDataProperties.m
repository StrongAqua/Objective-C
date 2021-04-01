//
//  FavoriteTicket+CoreDataProperties.m
//  
//
//  Created by aprirez on 3/21/21.
//
//

#import "FavoriteTicket+CoreDataProperties.h"

@implementation FavoriteTicket (CoreDataProperties)

+ (NSFetchRequest<FavoriteTicket *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"FavoriteTicket"];
}

@dynamic price;
@dynamic airline;
@dynamic departure;
@dynamic expires;
@dynamic flightNumber;
@dynamic returnDate;
@dynamic from;
@dynamic to;
@dynamic created;

@end
