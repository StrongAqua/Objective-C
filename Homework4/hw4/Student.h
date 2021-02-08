//
//  Student.h
//  hw4
//
//  Created by aprirez on 2/8/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Student : NSObject
    
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;

@property (nonatomic, readonly) NSInteger age;
@property (readonly) NSString *fullName;

-(id) initWithFirstName:(NSString*)firstName
            andLastName:(NSString*)lastName
                 andAge:(NSInteger)age;

+(instancetype) studentWithFirstName:(NSString*)firstName
                         andLastName:(NSString*)lastName
                              andAge:(NSInteger)age;

// method to rase student's age up
-(void) ageUp:(NSInteger) diff;

@end

NS_ASSUME_NONNULL_END


