//
//  TicketTableViewCell.h
//  AirTicketSaler
//
//  Created by aprirez on 3/9/21.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"
#import "APIManager.h"
#import "Ticket.h"
#import "FavoriteTicket+CoreDataClass.h"
#import "FavoriteMapPrice+CoreDataClass.h"

@interface TicketTableViewCell : UITableViewCell

@property (nonatomic, strong) Ticket *ticket;
@property (nonatomic, strong) FavoriteTicket *favoriteTicket;
@property (nonatomic, strong) FavoriteMapPrice *favoriteDirection;

@end

