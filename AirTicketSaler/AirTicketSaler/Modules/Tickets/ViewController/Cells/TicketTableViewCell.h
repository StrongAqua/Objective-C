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

@interface TicketTableViewCell : UITableViewCell

@property (nonatomic, strong) Ticket *ticket;

@end

