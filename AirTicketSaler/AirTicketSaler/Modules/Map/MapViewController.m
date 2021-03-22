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
    
    self.title = @"Карта цен";
    
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
            annotation.subtitle = [NSString stringWithFormat:@"%ld руб.", (long)price.value];
            annotation.coordinate = price.destination.coordinate;
            annotation.mapPrice = price;
            [self.mapView addAnnotation: annotation];
        });
    }
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    // NSLog(@"Selected annotation: %@", view);
    MyAnnotation* annotation = (MyAnnotation*)[view annotation];

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Действия с билетом" message:@"Что необходимо сделать с выбранным билетом?" preferredStyle:UIAlertControllerStyleActionSheet];

    UIAlertAction *favoriteAction;
    if ([[CoreDataHelper sharedInstance] isFavoriteMapPrice:[annotation mapPrice]]) {
        favoriteAction = [UIAlertAction actionWithTitle:@"Удалить из избранного" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [[CoreDataHelper sharedInstance] mapPriceRemoveFromFavorite:[annotation mapPrice]];
        }];
    } else {
        favoriteAction = [UIAlertAction actionWithTitle:@"Добавить в избранное" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[CoreDataHelper sharedInstance] mapPriceAddToFavorite:[annotation mapPrice]];
        }];
    }
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Закрыть" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:favoriteAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];

}

@end
