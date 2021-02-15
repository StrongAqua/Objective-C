//
//  Calculator.h
//  Homework3
//
//  Created by aprirez on 2/10/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

enum MathOperator {
    opAdd,
    opSub,
    opMul,
    opDivide
};
typedef enum MathOperator Operator;

@interface Calculator : NSObject

- (instancetype) initWithNumber1 : (NSNumber *) number1
                      andNumber2 : (NSNumber *) number2
                     andOperator : (Operator) operator;

- (CGFloat) calculate;

@property (nonatomic, strong, readonly) NSNumber *number1;
@property (nonatomic, strong, readonly) NSNumber *number2;
@property (nonatomic, readonly) Operator operator;

@end

NS_ASSUME_NONNULL_END
