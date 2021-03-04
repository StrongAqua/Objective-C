//
//  ViewController.m
//  Lifecycles
//
//  Created by aprirez on 2/23/21.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"ViewController, viewDidLoad");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"ViewController, viewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"ViewController, viewDidAppear");
}

// ---------------------------------------------------------------------
// To see the following callbacks we need at least two UIViewControllers
// That's why the UITabBarController was added - to switch between two
// similar controllers
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"ViewController, viewWillDisappear");
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"ViewController, viewDidDisappear");
}

// ---------------------------------------------------------------------
// This callback is called on screen rotation
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    NSLog(@"ViewController, viewWillTransitionToSize");
}


@end
