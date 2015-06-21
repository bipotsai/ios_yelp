//
//  ConfigurationViewController.m
//  
//
//  Created by Bipo Tsai on 6/21/15.
//
//

#import "ConfigurationViewController.h"

@interface ConfigurationViewController ()

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

-(void)pressCancelBtn {
    NSLog(@"Eh up, someone just pressed the Cancel button!");
}

-(void)pressSearchBtn {
    NSLog(@"Eh up, someone just pressed the Search button!");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
