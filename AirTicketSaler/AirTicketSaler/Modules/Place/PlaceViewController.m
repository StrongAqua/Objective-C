//
//  PlaceViewController.m
//  AirTicketSaler
//
//  Created by aprirez on 3/7/21.
//

#import "PlaceViewController.h"
#import "DataManager.h"
#import "City.h"
#import "Airport.h"
#import "NSString+Localize.h"

#define ReuseIdentifier @"CellIdentifier"

@interface PlaceViewController () <UISearchResultsUpdating>

@property (nonatomic) PlaceType placeType;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) NSArray *currentArray;

///
@property (nonatomic, strong) NSArray *searchArray;
@property (nonatomic, strong) UISearchController *searchController;

@end

@implementation PlaceViewController

- (instancetype)initWithType:(PlaceType)type
{
    self = [super init];
    if (self) {
        _placeType = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ///
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.obscuresBackgroundDuringPresentation = NO;
    _searchController.searchResultsUpdater = self;

    self.searchArray = @[];
    self.navigationItem.searchController = _searchController;
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[[@"cities" localize], [@"airports" localize]]];
    [_segmentedControl addTarget:self action:@selector(changeSource) forControlEvents:UIControlEventValueChanged];
    _segmentedControl.tintColor = [UIColor blackColor];
    self.navigationItem.titleView = _segmentedControl;
    _segmentedControl.selectedSegmentIndex = 0;
    [self changeSource];
    
    if (_placeType == PlaceTypeDeparture) {
        self.title = [@"main_from" localize];
    } else {
        self.title = [@"main_to" localize];
    }
    
}

#pragma mark - Actions

- (void)changeSource
{
    switch (_segmentedControl.selectedSegmentIndex) {
        case 0:
            _currentArray = [[DataManager sharedInstance] cities];
            break;
        case 1:
            _currentArray = [[DataManager sharedInstance] airports];

            break;
         default:
             break;
     }
     [self.tableView reloadData];
 }


#pragma mark - UISearchResultsUpdating

///
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    if (searchController.searchBar.text.length > 0) {
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS[cd] %@", searchController.searchBar.text];
        self.searchArray = [self.currentArray filteredArrayUsingPredicate: predicate];
        
        //[self.resultsViewController update];
        [self.tableView reloadData];
    } else {
        [self.tableView reloadData];
    }
}


#pragma mark - UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ///
//    if (_searchController.isActive && [_searchArray count] > 0) {
//           return [_searchArray count];
//       }
//       return [_currentArray count];
    return self.searchArray.count > 0 ? self.searchArray.count : self.currentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:ReuseIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    ///
    NSArray *array = self.searchArray.count > 0 ? self.searchArray : self.currentArray;
    
    if (_segmentedControl.selectedSegmentIndex == 0) {
        ///
        City *city = array[indexPath.row];
        cell.textLabel.text = city.name;
        cell.detailTextLabel.text = city.code;
    }
    else if (_segmentedControl.selectedSegmentIndex == 1) {
        ///
        Airport *airport = array[indexPath.row];
        cell.textLabel.text = airport.name;
        cell.detailTextLabel.text = airport.code;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DataSourceType dataType = ((int)_segmentedControl.selectedSegmentIndex) + 1;
    
    ///
    NSArray *array = self.searchArray.count > 0 ? self.searchArray : self.currentArray;
    
    
    [self.delegate selectPlace:array[indexPath.row] withType:_placeType andDataType:dataType];
    [self.navigationController popViewControllerAnimated:YES];
    
    ///
//    DataSourceType dataType = ((int)_segmentedControl.selectedSegmentIndex) + 1;
//       if (_searchController.isActive && [_searchArray count] > 0) {
//           [self.delegate selectPlace:[_searchArray objectAtIndex:indexPath.row] withType:_placeType andDataType:dataType];
//           _searchController.active = NO;
//       } else {
//           [self.delegate selectPlace:[_currentArray objectAtIndex:indexPath.row] withType:_placeType andDataType:dataType];
//       }
//       [self.navigationController popViewControllerAnimated:YES];
}

@end
