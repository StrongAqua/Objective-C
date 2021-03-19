//
//  LocationManager.m
//  AirTicketSaler
//
//  Created by aprirez on 3/15/21.
//

#import "LocationManager.h"
#import "UIKit/UIKit.h"

@interface LocationManager () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *manager;

@end

@implementation LocationManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.manager = [[CLLocationManager alloc] init];
        self.manager.delegate = self;
        self.manager.desiredAccuracy = kCLLocationAccuracyKilometer;
        self.manager.distanceFilter = 500;
        
        [self.manager requestAlwaysAuthorization];
    }
    return self;
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation *location = [locations firstObject];
    if (location) {
       
        NSLog(@"Геолокация пользователя \n\n %@\n", location);
        
        _currentLocation = location;
        [[NSNotificationCenter defaultCenter] postNotificationName:kLocationManagerDidUpdateLocation object:location];
        
    }
}

-(void)locationManagerDidChangeAuthorization:(CLLocationManager *)manager {
    
    
    switch (manager.authorizationStatus) {
            
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            [self.manager startUpdatingLocation];
            break;
            
        case kCLAuthorizationStatusAuthorizedAlways:
            break;
            
        case kCLAuthorizationStatusDenied:
            break;
            
        default: {
            UIAlertController *alert =
            [UIAlertController alertControllerWithTitle:@"Уппс! " message:@"Не удается получить локацию" preferredStyle:(UIAlertControllerStyleAlert)];
            
            [alert addAction: [UIAlertAction actionWithTitle:@"Ok" style:(UIAlertActionStyleDefault) handler:nil]];
            [[[UIApplication sharedApplication].windows firstObject].rootViewController presentViewController:alert animated:YES completion:nil];
        }
    }
}

@end
