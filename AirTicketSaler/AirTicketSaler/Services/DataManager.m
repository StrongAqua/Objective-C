//
//  DataManager.m
//  AirTicketSaler
//
//  Created by aprirez on 3/2/21.
//

#import "DataManager.h"

@interface DataManager ()
@property (nonatomic, strong) NSMutableArray *countriesArray;
@property (nonatomic, strong) NSMutableArray *citiesArray;
@property (nonatomic, strong) NSMutableArray *airportsArray;
@end

@implementation DataManager

+ (instancetype)sharedInstance
{
    static DataManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DataManager alloc] init];
    });
    return instance;
}

- (City *)cityForIATA:(NSString *)iata {
    if (iata) {
        for (City *city in _citiesArray) {
            if ([city.code isEqualToString:iata]) {
                return city;
            }
        }
    }
    return nil;
}

- (City *)cityForLocation:(CLLocation *)location {
    if (_citiesArray.count <= 0)
        return nil;

    City* nearestCity = _citiesArray.firstObject;
    double dLatt = location.coordinate.latitude - nearestCity.coordinate.latitude;
    double dLong = location.coordinate.longitude - nearestCity.coordinate.longitude;
    double minR = dLatt*dLatt + dLong*dLong;
    
    for (City *city in _citiesArray) {
        dLatt = location.coordinate.latitude - city.coordinate.latitude;
        dLong = location.coordinate.longitude - city.coordinate.longitude;
        double r = dLatt*dLatt + dLong*dLong;
        if (r < minR) {
            nearestCity = city;
            minR = r;
        }
        /*
        if (ceilf(city.coordinate.latitude) == ceilf(coordinate.latitude) && ceilf(city.coordinate.longitude) == ceilf(coordinate.longitude)) {
            return city;
        }
        */
    }
    return nearestCity;
}


- (void)loadData
{
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0), ^{
        NSArray *countriesJsonArray = [self arrayFromFileName:@"countries" ofType:@"json"];
        self->_countriesArray = [self createObjectsFromArray:countriesJsonArray withType: DataSourceTypeCountry];
        
        NSArray *citiesJsonArray = [self arrayFromFileName:@"cities" ofType:@"json"];
        self->_citiesArray = [self createObjectsFromArray:citiesJsonArray withType: DataSourceTypeCity];
        
        NSArray *airportsJsonArray = [self arrayFromFileName:@"airports" ofType:@"json"];
        self->_airportsArray = [self createObjectsFromArray:airportsJsonArray withType: DataSourceTypeAirport];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:kDataManagerLoadDataDidComplete object:nil];
        });
        NSLog(@"Complete load data");
    });
}

- (NSMutableArray *)createObjectsFromArray:(NSArray *)array withType:(DataSourceType)type
{
    NSMutableArray *results = [NSMutableArray new];
    
    for (NSDictionary *jsonObject in array) {
        if (type == DataSourceTypeCountry) {
            Country *country = [[Country alloc] initWithDictionary: jsonObject];
            [results addObject: country];
        }
        else if (type == DataSourceTypeCity) {
            City *city = [[City alloc] initWithDictionary: jsonObject];
            [results addObject: city];
        }
        else if (type == DataSourceTypeAirport) {
            Airport *airport = [[Airport alloc] initWithDictionary: jsonObject];
            [results addObject: airport];
        }
    }
    
    return results;
}

- (NSArray *)arrayFromFileName:(NSString *)fileName ofType:(NSString *)type
{
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:type];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
}


- (NSArray *)countries
{
    return _countriesArray;
}

- (NSArray *)cities
{
    return _citiesArray;
}

- (NSArray *)airports
{
    return _airportsArray;
}


@end
