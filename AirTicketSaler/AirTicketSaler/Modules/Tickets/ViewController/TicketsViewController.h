//
//  TicketsViewController.h
//  AirTicketSaler
//
//  Created by aprirez on 3/9/21.
//

#import <UIKit/UIKit.h>


@interface TicketsViewController : UITableViewController

- (instancetype)initWithTickets:(NSArray *)tickets;
- (instancetype)initFavoriteTicketsController;

@end


