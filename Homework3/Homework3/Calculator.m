//
//  Calculator.m
//  Homework3
//
//  Created by aprirez on 2/10/21.
//

#import "Calculator.h"

@implementation Calculator

- (instancetype) initWithNumber1 : (NSNumber *) number1
                      andNumber2 : (NSNumber *) number2
                     andOperator : (Operator) operator
{
    self = [super init];
    if (self) {
        [number1 retain];
        [number1 release];
        _number1 = number1;
        NSLog(@"Number1 = %@", number1);
        
        [number2 retain];
        [number2 release];
        _number2 = number2;
        NSLog(@"Number2 = %@", number2);
        
        _operator = operator;
    }
    return self;
}

- (CGFloat) add {
    return _number1.doubleValue + _number2.doubleValue;
}

- (CGFloat) sub {
    return _number1.doubleValue - _number2.doubleValue;
}

- (CGFloat) mul {
    return _number1.doubleValue * _number2.doubleValue;
}

- (CGFloat) divide {
    return (_number2.doubleValue != 0)
        ? _number1.doubleValue / _number2.doubleValue
        : NAN;
}

- (CGFloat) calculate
{
    switch(_operator) {
        case opAdd:
            return [self add];
        case opSub:
            return [self sub];
        case opMul:
            return [self mul];
        case opDivide:
            return [self divide];
        default:
            return 0;
    }
}

- (void) dealloc {
    NSLog(@"Dealloc Numbers");
    [_number1 release];
    [_number2 release];
    [super dealloc];
}

@end
