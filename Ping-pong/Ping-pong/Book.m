//
//  Book.m
//  Ping-pong
//
//  Created by aprirez on 2/18/21.
//

#import "Book.h"

@implementation Book

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.author = [aDecoder decodeObjectForKey:@"author"];
        self.bookName = [aDecoder decodeObjectForKey:@"bookName"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.author forKey:@"author"];
    [aCoder encodeObject:self.bookName forKey:@"bookName"];
}

+ (BOOL)supportsSecureCoding {
   return YES;
}

@end
