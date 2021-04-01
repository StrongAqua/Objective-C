//
//  TicketsViewController.m
//  AirTicketSaler
//
//  Created by aprirez on 3/9/21.
//

#import "TicketsViewController.h"
#import "TicketTableViewCell.h"
#import "CoreDataHelper.h"
#import "NotificationCenter.h"
#import "AirlineLogo.h"

#define TicketCellReuseIdentifier @"TicketCellIdentifier"

typedef enum {
    fvTickets,
    fvDirections
} FavoritesPage;

@interface TicketsViewController ()

@property (nonatomic, strong) NSMutableArray *tickets;
@property (nonatomic, strong) NSMutableArray *directions;
@property (nonatomic, strong) NSMutableArray *currentArray;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UITextField *dateTextField;

@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic) FavoritesPage favoritesPage;

@end

@implementation TicketsViewController {
    BOOL isFavorites;
    TicketTableViewCell *notificationCell;
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
        
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        _datePicker.preferredDatePickerStyle = UIDatePickerStyleWheels;
        _datePicker.minimumDate = [NSDate date];
        
        CGRect bounds = self.view.bounds;
        _dateTextField = [[UITextField alloc] initWithFrame:bounds];
        _dateTextField.hidden = YES;
        _dateTextField.inputView = _datePicker;
        
        UIToolbar *keyboardToolbar = [[UIToolbar alloc] init];
        [keyboardToolbar sizeToFit];
        UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonDidTap:)];
        keyboardToolbar.items = @[flexBarButton, doneBarButton];
        
        _dateTextField.inputAccessoryView = keyboardToolbar;
        [self.view addSubview:_dateTextField];
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

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CATransform3D rotation;
    rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
    rotation.m34 = 1.0/ -600;
    
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    
    cell.layer.transform = rotation;
    cell.layer.anchorPoint = CGPointMake(0, 0.5);
    
    [UIView animateWithDuration:1.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        cell.layer.transform = CATransform3DIdentity;
        cell.alpha = 1;
        cell.layer.shadowOffset = CGSizeMake(0, 0);
    } completion:^(BOOL finished) {
        nil;
    }];
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
    
    UIAlertAction *notificationAction = [UIAlertAction actionWithTitle:@"Напомнить" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        self->notificationCell = [self.tableView cellForRowAtIndexPath:indexPath];
        [self->_dateTextField becomeFirstResponder];
    }];

    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Закрыть" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:favoriteAction];
    [alertController addAction:notificationAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)doneButtonDidTap:(UIBarButtonItem *)sender
{
    if (_datePicker.date && notificationCell) {
        NSString *message = [NSString stringWithFormat:@"%@ - %@ за %lld руб.",
            notificationCell.favoriteTicket.from,
            notificationCell.favoriteTicket.to,
            notificationCell.favoriteTicket.price];

        UIImage *image = NULL;
        if (notificationCell.favoriteTicket.airline) {
            image = [notificationCell getLogoImage];
        }

        // TODO: provide data to seek for a cell in table
        NSDictionary* dict = @{
            @"Key1": @"Value1",
            @"Key2": @"Value2",
        };
        Notification notification = NotificationMake(@"Напоминание о билете", message, _datePicker.date, image, dict);
        [[NotificationCenter sharedInstance] sendNotification:notification];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Успешно" message:[NSString stringWithFormat:@"Уведомление будет отправлено - %@", _datePicker.date] preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Закрыть" style:UIAlertActionStyleCancel handler:^(UIAlertAction* action) {
            [self.view endEditing:YES];
        }];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:^() {
            [self.view endEditing:YES];
        }];
    }
    _datePicker.date = [NSDate date];
    notificationCell = nil;
    [self.view endEditing:YES];
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
