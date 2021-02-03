//
//  ViewController.m
//  Homework3
//
//  Created by aprirez on 2/3/21.
//

#import "ViewController.h"

@implementation ViewController

// -------------------------------------------------------
// Calculator
// -------------------------------------------------------
// Calculator types:
enum MathOperator {
    opAdd,
    opSub,
    opMul,
    opDivide
};
typedef enum MathOperator Operator;

// Calculator helpers:
CGFloat add(CGFloat a, CGFloat b) {
    return a + b;
}

CGFloat sub(CGFloat a, CGFloat b) {
    return a - b;
}

CGFloat mul(CGFloat a, CGFloat b) {
    return a * b;
}

CGFloat divide(CGFloat a, CGFloat b) {
    return (b != 0) ? a / b : NAN;
}

// major method
CGFloat calculate(Operator operator, CGFloat first, CGFloat second) {
    switch(operator) {
        case opAdd:
            return add(first, second);
        case opSub:
            return sub(first, second);
        case opMul:
            return mul(first, second);
        case opDivide:
            return divide(first, second);
        default:
            return 0;
    }
}

// -------------------------------------------------------
// Humans
// -------------------------------------------------------
// Types:
typedef enum {
    male,
    female
} Gender;

typedef struct {
    NSString *name;
    NSInteger age;
    Gender key;
} Human;

// Let's declare enum-to-string converter as the ViewController's method:
- (NSString*) convertToString:(Gender) whichGender {
    switch(whichGender) {
        case male:
            return @"male";
        case female:
            return @"female";
        default:
            return @"unknown";
    }
}

// And another one method to convert enum to string:
#define genderString(_enum_) [@[@"male", @"female"] objectAtIndex:_enum_]

// our "entry point":
- (void) viewDidLoad {
    [super viewDidLoad];

    // -----------------------------------------------------
    // Homework Task #1:
    NSMutableArray *numbers =
        [NSMutableArray arrayWithObjects: @"one", @"two", @"three", @"four", @"five", nil];

    NSInteger count = 0;
    for (NSNumber *number in numbers) {
        NSLog(@"[%ld]: %@", count++, number);
    }
    
    // -----------------------------------------------------
    // Homework Task #2:
    CGFloat first  = (CGFloat)(rand() % 10000) / 100.0;
    CGFloat second = (CGFloat)(rand() % 10000) / 100.0;

    NSLog(@"\nCalculator:\n"
          "First number: %.2f\n"
          "Second number: %.2f\n",
          first, second);

    NSLog(@"\nAdd = %f,\nSub = %f,\nMul = %f,\nDiv = %f",
          calculate(opAdd, first, second),
          calculate(opSub, first, second),
          calculate(opMul, first, second),
          calculate(opDivide, first, second)
    );
    
    // -----------------------------------------------------
    // Homework Task #3:
    Human human1, human2;

    human1.name = @"Alex";
    human1.age = 29;
    human1.key = male;

    human2.name = @"Mary";
    human2.age = 25;
    human2.key = female;
    
    NSLog(@"\nHuman1: %@, %ld, %@\n"
          "Human2: %@, %ld, %@\n",
          human1.name, (long)human1.age, genderString(human1.key),
          human2.name, (long)human2.age, [self convertToString:human2.key]);
}

@end
