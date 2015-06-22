//
//  RestaurantListViewController.m
//  yelp
//
//  Created by Bipo Tsai on 6/21/15.
//  Copyright (c) 2015 Bipo Tsai. All rights reserved.
//

#import "RestaurantListViewController.h"
#import "RestaurantCell.h"
#import "YelpClient.h"
#import "ViewController.h"
#import <UIImageView+AFNetworking.h>
#import "ConfigurationViewController.h"
NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";

@interface RestaurantListViewController () <UITableViewDataSource, UITableViewDelegate>{
}
@property (strong, nonatomic) IBOutlet UITableView *RestaurentTableView;
@property (strong, nonatomic) NSArray *restaurants;
@property (nonatomic, strong) YelpClient *client;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *filterBtn;
@end

@implementation RestaurantListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.RestaurentTableView.dataSource = self;
    self.RestaurentTableView.delegate = self;
    
        UIBarButtonItem *filterBtn = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain target:self action:@selector(pressFilterBtn)];
    self.navigationItem.leftBarButtonItem = filterBtn;
    
    UISearchBar *searchBar = [UISearchBar new];
    [searchBar sizeToFit];
    self.navigationItem.titleView = searchBar;
    searchBar.delegate = (id)self;
   

    self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
    
    
    [self reloadData:@"taiwan"];
}

-(void)pressFilterBtn {
    NSLog(@"Eh up, someone just pressed the Filter button!");
    
        ConfigurationViewController *rvc = [[ConfigurationViewController alloc] init];
        UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:rvc];
        [self presentViewController:nvc animated:YES completion:nil];
}

-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text
{
    if(text.length > 0)
    {
        NSLog(@"textDidChange");
        [self reloadData:text];
    }
    
}

-(void)reloadData:(NSString*)text{
    NSLog(@"reload data");
    [self.client searchWithTerm:text success:^(AFHTTPRequestOperation *operation, id response) {
        //NSString* jsonResponse = [NSString stringWithFormat:@"{%@}",operation.responseString];
        //NSLog(@"%@", operation.responseString);
         NSData* data = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        //NSLog(@"restaurants count = %lu",dict.count);
        self.restaurants = dict[@"businesses"];
        [self.RestaurentTableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView  numberOfRowsInSection:(NSInteger)section{
    return self.restaurants.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //UITableViewCell *cell = [[UITableViewCell alloc] init];
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyRestaurantCell" forIndexPath:indexPath];
//    NSDictionary *restaurant = self.restaurants[indexPath.row];
//    cell.textLabel.text =restaurant[@"name"];
    
    /////////////////////////////
    //RestaurantCell *cell = [[RestaurantCell alloc] init];
    
    RestaurantCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyRestaurantCell" forIndexPath:indexPath];
    NSDictionary *restaurant = self.restaurants[indexPath.row];
    NSLog(@"%ld : %@",indexPath.row, restaurant);
    //cell.textLabel.text =restaurant[@"name"];
    cell.nameLabel.text = restaurant[@"name"];
    //NSLog(@"%@", restaurant[@"distance"]);
    cell.distanceLabel.text = [NSString stringWithFormat:@"%0.2lld", [restaurant[@"distance"] longLongValue]];
    NSString *rating_img_URLString = restaurant[@"rating_img_url"];
    [cell.ratingImge setImageWithURL:[NSURL URLWithString:rating_img_URLString]];
    cell.reviewLabel.text = [NSString stringWithFormat:@"%@", restaurant[@"review_count"]];
    
    

    if([restaurant[@"location"][@"display_address"] count] >= 1 ) {
       cell.address1Label.text = restaurant[@"location"][@"display_address"][0];
       cell.address2Label.text = @"";
    }
    if([restaurant[@"location"][@"display_address"] count] == 2 ) {
        cell.address2Label.text = restaurant[@"location"][@"display_address"][1];
    }else if ([restaurant[@"location"][@"display_address"] count] == 3){
        NSString *address = [NSString stringWithFormat:@"%@, %@",restaurant[@"location"][@"display_address"][1],restaurant[@"location"][@"display_address"][2]];
        
        cell.address2Label.text = address;
    }
    
    NSString *postURLString = restaurant[@"image_url"];
    [cell.image setImageWithURL:[NSURL URLWithString:postURLString]];
    
    return cell;
}


//#pragma mark - Navigation
//
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    RestaurantCell *cell = sender;
//    NSIndexPath *indexPath = [self.RestaurentTableView indexPathForCell:cell];
//    NSDictionary *restaurant = self.restaurants[indexPath.row];
//    ViewController *destinationVC = segue.destinationViewController;
//    destinationVC.restaurant = restaurant;
//    
//}

@end
