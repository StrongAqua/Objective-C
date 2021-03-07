//
//  ViewController.m
//  AirTicketSaler
//
//  Created by aprirez on 3/2/21.
//

#import "MainViewController.h"
#import "DataManager.h"
#import "AnotherViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadDataComplete) name:kDataManagerLoadDataDidComplete object:nil];

    [[DataManager sharedInstance] loadData];
    [self configureControls];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kDataManagerLoadDataDidComplete object:nil];
}

- (void)loadDataComplete
{
    self.view.backgroundColor = [UIColor yellowColor];
}

#pragma mark - Navigation

- (void)openAnotherViewController
{
    AnotherViewController *anotherViewController = [[AnotherViewController alloc] init];
    
    [self.navigationController showViewController:anotherViewController sender:self];
}

#pragma mark - Configure UI

-(void)configureControls {
    
    UIButton *button = [UIButton buttonWithType: UIButtonTypeCustom];
    button.frame = CGRectMake(0.0, 0.0, 100.0, 80.0);
    button.center = self.view.center;
    [button setTitle:@"Go!" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor blueColor];
    button.tintColor = [UIColor whiteColor];
    [button addTarget:self action:@selector(openAnotherViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(110, 100, 100, 100)];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    
    CGRect labelFrame = CGRectMake(110.0, 30.0, 100.0, 100.0);
    UILabel *label = [[UILabel alloc] initWithFrame: labelFrame];
    label.font = [UIFont systemFontOfSize:24.0 weight:UIFontWeightBold];
    label.textColor = [UIColor darkGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"Hi!";
    [self.view addSubview: label];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"giraffe"]];
    imageView.frame = CGRectMake(110.0, 350.0, 100.0, 100.0);
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview: imageView];
    
    CGRect frame = CGRectMake(60.0, 450.0, 200.0, 50.0);
    UISlider *slider = [[UISlider alloc] init];
    slider.frame = frame;
    slider.tintColor = [UIColor blackColor];
    slider.value = 0.5;
    [self.view addSubview:slider];
}

@end
