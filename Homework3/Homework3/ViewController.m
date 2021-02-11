//
//  ViewController.m
//  Homework3
//
//  Created by aprirez on 2/3/21.
//

#import "ViewController.h"
#import "Calculator.h"

#import "FlockOfBirds.h"
#import "Bird.h"

@implementation ViewController

// our "entry point":
- (void) viewDidLoad {
    [super viewDidLoad];

    // -----------------------------------------------------
    // Homework Task #1:
    NSNumber *number1 = [[NSNumber alloc] initWithDouble: (CGFloat)(rand() % 10000) / 100.0];
    NSNumber *number2 = [[NSNumber alloc] initWithDouble: (CGFloat)(rand() % 10000) / 100.0];

    NSLog(@"\nCalculator:\n"
          "Number1: %@\n"
          "Number2: %@\n",
          number1, number2);
    
    Calculator *calcAdd = [[Calculator alloc]
                            initWithNumber1: [number1 retain]
                            andNumber2: [number2 retain]
                            andOperator: opAdd
                          ];
    Calculator *calcMul = [[Calculator alloc]
                            initWithNumber1: [number1 retain]
                            andNumber2: [number2 retain]
                            andOperator: opMul
                          ];
    Calculator *calcSub = [[Calculator alloc]
                            initWithNumber1: [number1 retain]
                            andNumber2: [number2 retain]
                            andOperator: opSub
                          ];
    Calculator *calcDiv = [[Calculator alloc]
                            initWithNumber1: number1 // do not retain here
                            andNumber2: number2 // do not retain here
                            andOperator: opDivide
                          ];
    NSLog(@"\nAdd = %f\nSub = %f\nMul = %f\nDiv = %f\n",
          [calcAdd calculate],
          [calcSub calculate],
          [calcMul calculate],
          [calcDiv calculate]
    );

    [calcAdd release];
    [calcSub release];
    [calcMul release];
    [calcDiv release];

    // -----------------------------------------------------
    // Homework Task #2:
    // NSAutoreleasePool *pool;
    // pool = [NSAutoreleasePool new];
    @autoreleasepool {
        FlockOfBirds *flockOfBirds = [[FlockOfBirds alloc] init];

        Bird *bird1 = [[Bird alloc] initWithNumber:@1 andSex: male];
        Bird *bird2 = [[Bird alloc] initWithNumber:@2 andSex: female];
        Bird *bird3 = [[Bird alloc] initWithNumber:@3 andSex: male];
        Bird *bird4 = [[Bird alloc] initWithNumber:@4 andSex: female];
        
        NSArray *birds = [[NSArray alloc] initWithObjects:bird1, bird2, bird3, bird4, nil];
        [flockOfBirds configWithBirds:birds];

        [flockOfBirds autorelease];
    }
    // [pool release]; // this also works!

}
@end
