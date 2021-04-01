//
//  NSString+Localize.m
//  AirTicketSaler
//
//  Created by aprirez on 4/1/21.
//

#import <Foundation/Foundation.h>
#import "NSString+Localize.h"

@implementation NSString (Localize)

- (NSString *)localize {
    return NSLocalizedString(self, "");
}

@end

