//
//  FlockOfBirds.m
//  Homework3
//
//  Created by aprirez on 2/11/21.
//

#import "FlockOfBirds.h"
#import "Bird.h"

@implementation FlockOfBirds

- (instancetype) init
{
    self = [super init];
    if (self) {
        NSLog(@"Create flock");
    }
    return self;
}

- (void) configWithBirds: (NSArray *) birds
{
    [birds retain];
    [birds release];
    _birds = birds;
    for (Bird *bird in _birds) {
        NSLog(@"Add bird(%@, %@) in flock", bird.number, genderString(bird.sexOfBird));
    }
}

- (void) remove {
    NSLog(@"Remove birds from flock");
    for (Bird *bird in _birds) {
        [bird release];
    }
    [_birds release];
}

- (void) dealloc {
    [self remove];
    NSLog(@"Dealloc flockOfBirds");
    [super dealloc];
}
@end
