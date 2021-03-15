//
//  DataManager.h
//  AirTicketSaler
//
//  Created by aprirez on 3/2/21.
//

#import <Foundation/Foundation.h>
#import "Country.h"
#import "City.h"
#import "Airport.h"

#define kDataManagerLoadDataDidComplete @"DataManagerLoadDataDidComplete"

typedef enum DataSourceType {
    DataSourceTypeCountry,
    DataSourceTypeCity,
    DataSourceTypeAirport
} DataSourceType;

NS_ASSUME_NONNULL_BEGIN

@interface DataManager : NSObject

@property (nonatomic, strong, readonly) NSArray *countries;
@property (nonatomic, strong, readonly) NSArray *cities;
@property (nonatomic, strong, readonly) NSArray *airports;

+ (instancetype)sharedInstance;
- (void)loadData;
- (City *)cityForIATA:(NSString *)iata;
- (City *)cityForLocation:(CLLocation *)location;

@end

NS_ASSUME_NONNULL_END
