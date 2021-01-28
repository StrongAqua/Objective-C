//
//  main.m
//  ObjC_Homework1
//
//  Created by aprirez on 1/28/21.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    
    @autoreleasepool {

        CGFloat first = 0;
        CGFloat second = 0;
        CGFloat third = 0;

        double tmp = 0;

        printf("Calculator\n");
        printf("Please, input first number: ");
        // It is not a good idea scan to CGFloat (it is an object),
        // It works, because CGFloat has only one data field of type double,
        // But it is wrong in general.
        // See: http://macbug.ru/cocoa/stringfspec
        scanf("%lf", &tmp);
        first = tmp;

        printf("Please, input second number: ");
        scanf("%lf", &tmp);
        second = tmp;

        /* How to work with strings in ObjC
        https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Strings/Articles/CreatingStrings.html
         */
        NSString* divResult =
            (second != 0)
                ? [NSString stringWithFormat:@"%lf", first / second]
                : @"ERROR";

        NSLog(@"Add = %lf, Sub = %lf, Mul = %lf, Div = %@\n",
              first + second, first - second, first * second, divResult);

        printf("\nAVG Calculator\n");

        printf("Please, input first number: ");
        scanf("%lf", &tmp);
        first = tmp;

        printf("Please, input second number: ");
        scanf("%lf", &tmp);
        second = tmp;

        printf("Please, input third number: ");
        scanf("%lf", &tmp);
        third = tmp;

        NSLog(@"AVG: %lf \n", (first + second + third) / 3);
    }
}
