//
//  ViewController.m
//  hw6
//
//  Created by aprirez on 2/15/21.
//

#import "ViewController.h"

#define PI 3.14159

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //--------------------------------------------------------
    // Task #1: dispatch_async

    __block CGFloat circumference = 0;

    void (^printStartCalculation)(void) = ^{
        NSLog(@"Some calculate:\n");
    };
    
    void (^printDone)(void) = ^{
        NSLog(@"DONE\n");
    };

    void (^doCalculate)(CGFloat) = ^(CGFloat radius) {
        circumference = 2 * PI * radius;
    };
    
    void (^printFromDefaultQueue)(void) = ^(void) {
        NSLog(@"Just a message from default queue!\n");
    };
    
    void (^printCalculationResultFromHighPriorityQueue)(CGFloat) = ^(CGFloat circumference) {
        NSLog(@"Calculation result (high priority queue) = %f", circumference);
    };

    void (^printCalculationResultFromLowPriorityQueue)(CGFloat) = ^(CGFloat circumference) {
        NSLog(@"Calculation result (low priority queue) = %f", circumference);
    };

    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    dispatch_queue_t lowPriorityQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
    dispatch_queue_t defaultPriorityQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t highPriorityQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    
    dispatch_async(mainQueue, ^{
        // this will be printed at the end of log with a high probability
        // because will wait while all current UI events been processed.
        printStartCalculation();
    });
    
    // Other blocks may shuffle, but possible high priority will be first,
    // but not exactly because queues are empty now
    dispatch_async(defaultPriorityQueue, ^{
        printFromDefaultQueue();
    });

    dispatch_async(lowPriorityQueue, ^{
        doCalculate(5);
    });
    
    dispatch_async(lowPriorityQueue, ^{
        // will probably print 0 because calculations is still in progress
        printCalculationResultFromLowPriorityQueue(circumference);
    });
    
    dispatch_async(highPriorityQueue, ^{
        printCalculationResultFromHighPriorityQueue(circumference);
    });
    
    dispatch_async(lowPriorityQueue, ^{
        // may be called before calculation is really done
        // seems like the one queue is processed with several threads.
        printDone();
    });

    //--------------------------------------------------------
    // Let's start task #2 here
    dispatch_barrier_async(lowPriorityQueue, ^{
        NSLog(@"Barrier for the task #2.");
    });
    
    // let's call task #2 after all
    dispatch_async(lowPriorityQueue, ^{
        // TODO: need to keep self here, or may crash
        [self task2];
    });
}

- (void)task2 {
    //--------------------------------------------------------
    // Task #2: Custom Queue
    NSOperationQueue *customQueue = [[NSOperationQueue alloc] init];

    for (NSInteger i = 0; i < 10; i++ ) {
      [customQueue addOperationWithBlock:^{
          NSLog(@"Number %ld\n", (long)i);
       }];
    }

    NSLog(@"Hello!");
    [customQueue waitUntilAllOperationsAreFinished];
    NSLog(@"Custom queue tasks done!");
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    
    // Update the view, if already loaded.
}


@end
