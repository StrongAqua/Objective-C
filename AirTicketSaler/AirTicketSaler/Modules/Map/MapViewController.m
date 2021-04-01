//
//  MapViewController.m
//  AirTicketSaler
//
//  Created by aprirez on 3/15/21.
//

#import "MapViewController.h"

#import "LocationManager.h"
#import "APIManager.h"
#import "MapPrice.h"
#import "CoreDataHelper.h"
#import "NSString+Localize.h"

@interface MyAnnotation : MKPointAnnotation
@property(nonatomic, strong) MapPrice *mapPrice;
@end

@implementation MyAnnotation
@end

@interface MapViewController () <MKMapViewDelegate>

@property (strong, nonatomic) MKMapView *mapView;
@property (nonatomic, strong) LocationManager *locationManager;
@property (nonatomic, strong) City *origin;
@property (nonatomic, strong) NSArray *prices;
@property (nonatomic, strong) NSMutableDictionary *annotationToPrice;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [@"map_tab" localize];
    
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    
    [[DataManager sharedInstance] loadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataLoadedSuccessfully) name:kDataManagerLoadDataDidComplete object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCurrentLocation:) name:kLocationManagerDidUpdateLocation object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Private

- (void)dataLoadedSuccessfully {
    self.locationManager = [[LocationManager alloc] init];
}

- (void)updateCurrentLocation:(NSNotification *)notification {
    CLLocation *currentLocation = notification.object;
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(currentLocation.coordinate, 1000000, 1000000);
    [_mapView setRegion: region animated: YES];
    
    if (currentLocation) {
        _origin = [[DataManager sharedInstance] cityForLocation:currentLocation];
        if (_origin) {
            
            [[APIManager sharedInstance] mapPricesFor:_origin withCompletion:^(NSArray *prices) {
                self.prices = prices;
            }];
        }
    }
}

- (void)setPrices:(NSArray *)prices {
    _prices = prices;

    [self.mapView removeAnnotations: self.mapView.annotations];
    [self.annotationToPrice removeAllObjects];

    for (MapPrice *price in prices) {
        dispatch_async(dispatch_get_main_queue(), ^{
            MyAnnotation *annotation = [[MyAnnotation alloc] init];
            annotation.title = [NSString stringWithFormat:@"%@ (%@)", price.destination.name, price.destination.code];
            annotation.subtitle = [NSString stringWithFormat:[@"%ld rub." localize], (long)price.value];
            annotation.coordinate = price.destination.coordinate;
            annotation.mapPrice = price;
            [self.mapView addAnnotation: annotation];
        });
    }
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    // NSLog(@"Selected annotation: %@", view);
    MyAnnotation* annotation = (MyAnnotation*)[view annotation];

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[@"actions_with_tickets" localize] message:[@"actions_with_tickets_describe?" localize] preferredStyle:UIAlertControllerStyleActionSheet];

    UIAlertAction *favoriteAction;
    if ([[CoreDataHelper sharedInstance] isFavoriteMapPrice:[annotation mapPrice]]) {
        favoriteAction = [UIAlertAction actionWithTitle:[@"remove_from_favorite" localize] style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [[CoreDataHelper sharedInstance] mapPriceRemoveFromFavorite:[annotation mapPrice]];
        }];
    } else {
        favoriteAction = [UIAlertAction actionWithTitle:[@"add_to_favorite" localize] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[CoreDataHelper sharedInstance] mapPriceAddToFavorite:[annotation mapPrice]];
        }];
    }
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:[@"close" localize] style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:favoriteAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];

}

@end
