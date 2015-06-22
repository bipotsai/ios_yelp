//
//  ConfigurationViewController.m
//  
//
//  Created by Bipo Tsai on 6/21/15.
//
//

#import "ConfigurationViewController.h"
#import "RestaurantListViewController.h"
@interface ConfigurationViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ConfigurationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(pressCancelBtn)];
    
    UIBarButtonItem *searchBtn = [[UIBarButtonItem alloc] initWithTitle:@"Search" style:UIBarButtonItemStylePlain target:self action:@selector(pressSearchBtn)];

//    
//    UIView *barWrapper = [[UIView alloc] init];
//    [barWrapper addSubview:cancelBtn];
//    [barWrapper addSubview:searchBtn];
//    
//    self.navigationItem.titleView = barWrapper;
    
    self.navigationItem.rightBarButtonItem = searchBtn;
    self.navigationItem.leftBarButtonItem = cancelBtn;
    
}

#pragma mark - Private methods

-(void)pressCancelBtn {
    NSLog(@"Eh up, someone just pressed the Cancel button!");
    [self dismissViewControllerAnimated:YES completion:nil];
//    RestaurantListViewController *rvc = [[RestaurantListViewController alloc] init];
//    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:rvc];
//    [self presentViewController:nvc animated:YES completion:nil];
}

-(void)pressSearchBtn {
    NSLog(@"Eh up, someone just pressed the Search button!");
    [self dismissViewControllerAnimated:YES completion:nil];
//    RestaurantListViewController *rvc = [[RestaurantListViewController alloc] init];
//    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:rvc];
//    [self presentViewController:nvc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
