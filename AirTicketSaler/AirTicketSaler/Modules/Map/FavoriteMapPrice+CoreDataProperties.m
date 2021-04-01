//
//  FavoriteMapPrice+CoreDataProperties.m
//  
//
//  Created by aprirez on 3/21/21.
//
//

#import "FavoriteMapPrice+CoreDataProperties.h"

@implementation FavoriteMapPrice (CoreDataProperties)

+ (NSFetchRequest<FavoriteMapPrice *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"FavoriteMapPrice"];
}

@dynamic destination;
@dynamic origin;
@dynamic departure;
@dynamic returnDate;
@dynamic numberOfChanges;
@dynamic value;
@dynamic distance;
@dynamic actual;
@dynamic created;

@end
