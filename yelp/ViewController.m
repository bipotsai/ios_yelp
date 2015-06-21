//
//  ViewController.m
//  yelp
//
//  Created by Bipo Tsai on 6/21/15.
//  Copyright (c) 2015 Bipo Tsai. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UISearchBar *searchBar = [UISearchBar new];
    [searchBar sizeToFit];
    self.navigationItem.titleView = searchBar;
   
    //UIView *barWrapper = [[UIView alloc]initWithFrame:CGRectMake(0, 55, 0, 0)];
    //[barWrapper addSubview:searchBar];
    //self.navigationItem.titleView = barWrapper;
    
    
    //UIView *navigationTitleView = [[UIView alloc]initWithFrame:self.searchBar.bounds];
    //[navigationTitleView addSubview:self.searchBtn];
    //[navigationTitleView addSubview:self.searchBar];
    //self.navigationItem.titleView = navigationTitleView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
