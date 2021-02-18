//
//  main.m
//  Ping-pong
//
//  Created by aprirez on 2/18/21.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Book.h"

NSString* directory() {
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingString:@"/book.txt"];
}

void writeBook(Book *book) {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:book requiringSecureCoding:true error:nil];
    [data writeToFile:directory() atomically:YES];
    NSLog(@"Сохранено!");
}

Book* readBook() {
    NSData *data = [NSData dataWithContentsOfFile:directory()];
    NSError *error;
    Book* book = [NSKeyedUnarchiver unarchivedObjectOfClass:[Book class] fromData:data error:&error];
    if (error != nil) {
        NSLog(@"Ошибка чтения: %@", error);
    } else {
        NSLog(@"Прочитано!");
    }
    return book;
    // return [NSKeyedUnarchiver unarchiveObjectWithFile:directory()];
}

void printBook(Book *book) {
    NSLog(@"author - %@, bookName - %@", book.author, book.bookName);
}

int main(int argc, char * argv[]) {

    NSString *appDelegateClassName;
    // -------------------------------------------------------------
    // Homework Task #1:
    @autoreleasepool {
        
        Book *book = [[Book alloc] init];
        book.author = @"Katherine Paterson";
        book.bookName = @"Bridge to Terabithia";

        printBook(book);

        writeBook(book);

        book = nil;
        printBook(book);
        
        book = readBook();
        printBook(book);

        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }

    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
