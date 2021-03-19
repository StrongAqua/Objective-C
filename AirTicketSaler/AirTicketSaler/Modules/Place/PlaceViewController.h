//
//  PlaceViewController.h
//  AirTicketSaler
//
//  Created by aprirez on 3/7/21.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"

typedef enum PlaceType {
    PlaceTypeArrival,
    PlaceTypeDeparture
} PlaceType;

@protocol PlaceViewControllerDelegate <NSObject>
- (void)selectPlace:(id)place withType:(PlaceType)placeType andDataType:(DataSourceType)dataType;
@end

@interface PlaceViewController : UITableViewController 

@property (nonatomic, strong) id<PlaceViewControllerDelegate>delegate;
- (instancetype)initWithType:(PlaceType)type;


@end

