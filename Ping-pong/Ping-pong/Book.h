//
//  Book.h
//  Ping-pong
//
//  Created by aprirez on 2/18/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Book : NSObject <NSSecureCoding>

@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *bookName;

@end

NS_ASSUME_NONNULL_END
