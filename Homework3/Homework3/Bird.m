//
//  Birds.m
//  Homework3
//
//  Created by aprirez on 2/11/21.
//

#import "Bird.h"

@implementation Bird

- (instancetype) initWithNumber: (NSNumber *) number
                         andSex: (SexOfBird) sexOfBird
{
    self = [super init];
    if (self) {
        [number retain];
        [number release];

        _number = number;
        _sexOfBird = sexOfBird;
        
        NSLog(@"Create bird %@, %@", number, genderString(sexOfBird));
        
        
    }
    return self;
}

- (void) dealloc {
    NSLog(@"Dealloc Bird - %@", _number);
    [_number release];
    [super dealloc];
}

@end
