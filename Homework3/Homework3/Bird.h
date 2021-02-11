//
//  Birds.h
//  Homework3
//
//  Created by aprirez on 2/11/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

enum SexOfBird {
    male,
    female
};
typedef enum SexOfBird SexOfBird;
#define genderString(_enum_) [@[@"male", @"female"] objectAtIndex:_enum_]

@interface Bird : NSObject

- (instancetype) initWithNumber: (NSNumber *) number
                         andSex: (SexOfBird) sexOfBird;

@property (nonatomic, strong) NSNumber *number;
@property (nonatomic) SexOfBird sexOfBird;

@end

NS_ASSUME_NONNULL_END
