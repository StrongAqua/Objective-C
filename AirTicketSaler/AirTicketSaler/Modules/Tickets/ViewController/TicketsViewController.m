//
//  TicketsViewController.m
//  AirTicketSaler
//
//  Created by aprirez on 3/9/21.
//

#import "TicketsViewController.h"
#import "TicketTableViewCell.h"
#import "CoreDataHelper.h"

#define TicketCellReuseIdentifier @"TicketCellIdentifier"

typedef enum {
    fvTickets,
    fvDirections
} FavoritesPage;

@interface TicketsViewController ()

@property (nonatomic, strong) NSMutableArray *tickets;
@property (nonatomic, strong) NSMutableArray *directions;
@property (nonatomic, strong) NSMutableArray *currentArray;

@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic) FavoritesPage favoritesPage;

@end

@implementation TicketsViewController {
    BOOL isFavorites;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    _favoritesPage = fvTickets;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (isFavorites) {
        
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Билеты", @"Направления"]];
        [_segmentedControl addTarget:self action:@selector(changeSource) forControlEvents:UIControlEventValueChanged];
        _segmentedControl.tintColor = [UIColor blackColor];
        self.navigationItem.titleView = _segmentedControl;
        _segmentedControl.selectedSegmentIndex = 0;

        self.navigationController.navigationBar.prefersLargeTitles = YES;
        
        if (!_tickets) { _tickets = [NSMutableArray new]; }
        [_tickets removeAllObjects];
        [_tickets addObjectsFromArray:[[CoreDataHelper sharedInstance] favorites]];

        if (!_directions) { _directions = [NSMutableArray new]; }
        [_directions removeAllObjects];
        [_directions addObjectsFromArray:[[CoreDataHelper sharedInstance] favoritesMapPrices]];
    
        [self changeSource];
    }
}

- (void)changeSource
{
    switch (_segmentedControl.selectedSegmentIndex) {
        case 0:
            _currentArray = _tickets;
            _favoritesPage = fvTickets;
            self.title = @"Билеты";
            break;
        case 1:
            _currentArray = _directions;
            _favoritesPage = fvDirections;
            self.title = @"Направления";
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

#pragma mark - Public

- (instancetype)initFavoriteTicketsController {
    self = [super init];
    if (self) {
        isFavorites = YES;
        self.tickets = [NSMutableArray new];
        self.directions = [NSMutableArray new];
        self.title = @"Избранное";
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tableView registerClass:[TicketTableViewCell class] forCellReuseIdentifier:TicketCellReuseIdentifier];
    }
    return self;
}


- (instancetype)initWithTickets:(NSArray *)tickets {
    self = [super init];
    if (self)
    {
        isFavorites = NO;
        self.tickets = [NSMutableArray new];
        [_tickets removeAllObjects];
        [_tickets addObjectsFromArray:tickets];
        self.title = @"Билеты";
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tableView registerClass:[TicketTableViewCell class] forCellReuseIdentifier:TicketCellReuseIdentifier];
    }
    return self;
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (isFavorites) {
        switch (_favoritesPage) {
            case fvTickets: return _tickets.count;
            case fvDirections: return _directions.count;
            default: return 0;
        }
    }
    return _tickets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TicketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TicketCellReuseIdentifier forIndexPath:indexPath];
    
    if (isFavorites) {
        switch (_favoritesPage) {
            case fvTickets:
                cell.favoriteTicket = [_tickets objectAtIndex:indexPath.row];
                break;

            case fvDirections:
                cell.favoriteDirection = [_directions objectAtIndex:indexPath.row];
                break;

            default:
                break;
        }
    } else {
        cell.ticket =
            [_tickets objectAtIndex:indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!isFavorites) {
        [self rowSelectedTicket:indexPath];
    } else {
        switch (_favoritesPage) {
            case fvTickets: [self rowSelectedTicket:indexPath]; break;
            case fvDirections: [self rowSelectedDirection:indexPath]; break;
        }
    }
}

- (void) rowSelectedTicket:(NSIndexPath *)indexPath
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Действия с билетом" message:@"Что необходимо сделать с выбранным билетом?" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *favoriteAction;
    
    id ticket = [self->_tickets objectAtIndex:indexPath.row];
    if ( [ticket isKindOfClass:[FavoriteTicket class]] ||
         ( [ticket isKindOfClass:[Ticket class]] &&
           [[CoreDataHelper sharedInstance] isFavorite: ticket]
         )
       ) {
        favoriteAction = [UIAlertAction actionWithTitle:@"Удалить из избранного" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [[CoreDataHelper sharedInstance] removeFromFavorite:ticket];
            if (self->isFavorites) {
                [self.currentArray removeObjectAtIndex:indexPath.row];
                [self.tableView reloadData];
            }
        }];
    } else {
        favoriteAction = [UIAlertAction actionWithTitle:@"Добавить в избранное" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[CoreDataHelper sharedInstance] addToFavorite:ticket];
            [self.tableView reloadData];
        }];
    }
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Закрыть" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:favoriteAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void) rowSelectedDirection:(NSIndexPath *)indexPath
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Действия с билетом" message:@"Что необходимо сделать с выбранным направлением?" preferredStyle:UIAlertControllerStyleActionSheet];

    UIAlertAction *favoriteAction;
    favoriteAction = [UIAlertAction actionWithTitle:@"Удалить из избранного" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [[CoreDataHelper sharedInstance] mapPriceRemoveFromFavorite:[self->_directions objectAtIndex:indexPath.row]];
        [self.currentArray removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Закрыть" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:favoriteAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
