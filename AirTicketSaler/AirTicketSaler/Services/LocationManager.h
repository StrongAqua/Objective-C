//
//  LocationManager.h
//  AirTicketSaler
//
//  Created by aprirez on 3/15/21.
//

#import <Foundation/Foundation.h>
#import "CoreLocation/CoreLocation.h"

#define kLocationManagerDidUpdateLocation @"kLocationManagerDidUpdateLocation"

@interface LocationManager : NSObject

@property (strong, nonatomic) CLLocation *currentLocation;

@end

