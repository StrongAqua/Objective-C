//
//  ViewController.m
//  hw4
//
//  Created by aprirez on 2/8/21.
//

#import "ViewController.h"
#import "Student.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Student *student1 = [Student studentWithFirstName:@"James" andLastName:@"Bond" andAge:19];
    // NSLog(@"%@, was %ld year old", [student1 fullName], (long)[student1 age]);
    NSLog(@"%@", student1);
    [student1 ageUp:5];
    // NSLog(@"%@, now %ld year old", [student1 fullName], (long)[student1 age]);
    NSLog(@"%@", student1);

    Student *student2 = [Student studentWithFirstName:@"John" andLastName:@"Doe" andAge:21];
    // NSLog(@"%@, was %ld year old", [student2 fullName], (long)[student2 age]);
    NSLog(@"%@", student2);
    [student2 ageUp:-2];
    // NSLog(@"%@, now %ld year old", [student2 fullName], (long)[student2 age]);
    NSLog(@"%@", student2);
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
