//
//  FavoriteMapPrice+CoreDataProperties.h
//  
//
//  Created by aprirez on 3/21/21.
//
//

#import "FavoriteMapPrice+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface FavoriteMapPrice (CoreDataProperties)

+ (NSFetchRequest<FavoriteMapPrice *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *destination;
@property (nullable, nonatomic, copy) NSString *origin;
@property (nullable, nonatomic, copy) NSDate *departure;
@property (nullable, nonatomic, copy) NSDate *created;
@property (nullable, nonatomic, copy) NSDate *returnDate;
@property (nonatomic) int64_t numberOfChanges;
@property (nonatomic) int64_t value;
@property (nonatomic) int64_t distance;
@property (nonatomic) BOOL actual;

@end

NS_ASSUME_NONNULL_END
