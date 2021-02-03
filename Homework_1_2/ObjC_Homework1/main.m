//
//  main.m
//  ObjC_Homework1
//
//  Created by aprirez on 1/28/21.
//

#import <Foundation/Foundation.h>

BOOL isLatinCharacter(char ch) {
    @autoreleasepool {
        // NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
        // NSCharacterSet *latinCharacters = [NSCharacterSet characterSetWithCharactersInString: letters];
        // BOOL isLetter = [latinCharacters characterIsMember: insertChar];
        BOOL isLetter = ('a' <= ch && ch <= 'z')
                     || ('A' <= ch && ch <= 'Z');
        return isLetter;
    }
}

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

int main(int argc, const char * argv[]) {
    
    @autoreleasepool {

        CGFloat first = 0;
        CGFloat second = 0;
        CGFloat third = 0;
        
        char ch;
        
        printf("Fun function\n");
        printf("Please, input one symbol: ");
        scanf("%c", &ch);

        NSLog(@"Is Latin: %s\n",
              isLatinCharacter(ch)
                ? "true"
                : "false"
        );
        
        printf("Calculator\n");

        printf("Please, input first number: ");
        // CGFloat is just a typedef of double or float depends on a platform, not an object
        scanf("%lf", &first);

        printf("Please, input second number: ");
        scanf("%lf", &second);
        
        CGFloat divResult = divide(first, second);
        NSLog(@"Add = %f, Sub = %f, Mul = %f, Div = %@\n",
              add(first, second),
              sub(first, second),
              mul(first, second),
              isnan(divResult)
                  ? @"ERROR"
                  : [NSString stringWithFormat:@"%f", divResult]
        );

        printf("\nAVG Calculator\n");

        printf("Please, input first number: ");
        scanf("%lf", &first);

        printf("Please, input second number: ");
        scanf("%lf", &second);

        printf("Please, input third number: ");
        scanf("%lf", &third);

        NSLog(@"AVG: %lf \n", (first + second + third) / 3);
    }
}
