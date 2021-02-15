//
//  FlockOfBirds.h
//  Homework3
//
//  Created by aprirez on 2/11/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FlockOfBirds : NSObject

- (void) configWithBirds: (NSArray *) birds;

@property (nonatomic, strong) NSArray *birds;

@end

NS_ASSUME_NONNULL_END
