//
//  Student.m
//  hw4
//
//  Created by aprirez on 2/8/21.
//

#import "Student.h"

// re-declare age property to make it writable internally
@interface Student ()
@property (nonatomic, readwrite) NSInteger age;
@end

@implementation Student

@synthesize firstName;
@synthesize lastName;
@synthesize age;

-(id) initWithFirstName:(NSString *)firstName
            andLastName:(NSString *)lastName
                 andAge:(NSInteger)age
{
    self = [super init];
    if (self) {
        self.firstName = firstName;
        self.lastName = lastName;
        self.age = age;
    }
    return self;
}

+(instancetype) studentWithFirstName:(NSString *)firstName
                         andLastName:(NSString *)lastName
                              andAge:(NSInteger)age
{
    Student *student = [[Student alloc]
                        initWithFirstName:firstName
                        andLastName:lastName
                        andAge:age
                        ];
    return student;
}

-(NSString *) fullName
{
    return [NSString stringWithFormat:@"%@ %@", [self firstName], [self lastName]];
}

-(void) ageUp:(NSInteger) diff {
    self.age += diff;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@, %@, %ld", self.className, self.fullName, self.age];
}
 
@end
