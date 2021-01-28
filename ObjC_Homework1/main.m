//
//  main.m
//  ObjC_Homework1
//
//  Created by aprirez on 1/28/21.
//

#import <Foundation/Foundation.h>

double first = 0;
double second = 0;
double third = 0;

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        printf("First number: ");
        scanf("%lf", &first);
        printf("Second number: ");
        scanf("%lf", &second);
        printf("%lf + %lf = %lf \n",first, second, first + second);
        printf("%lf - %lf = %lf \n",first, second, first - second);
        printf("%lf * %lf = %lf \n",first, second, first * second);
        printf("%lf : %lf = %lf \n",first, second, first / second);
        printf("Add = %lf, Sub = %lf, Mul = %lf, Diff = %lf \n", first + second, first - second, first * second, first / second);
        printf("AVG \n");
        printf("First number: ");
        scanf("%lf", &first);
        printf("Second number: ");
        scanf("%lf", &second);
        printf("Third number: ");
        scanf("%lf", &third);
        printf("AVG: %lf \n", (first + second + third) / 3);
    }
}
