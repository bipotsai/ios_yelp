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

NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";

@interface RestaurantListViewController () <UITableViewDataSource, UITableViewDelegate>{
    UIRefreshControl *refreshControl;
}
@property (strong, nonatomic) IBOutlet UITableView *RestaurentTableView;
@property (strong, nonatomic) NSArray *restaurants;
@property (nonatomic, strong) YelpClient *client;
@end

@implementation RestaurantListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
        self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
        
        [self.client searchWithTerm:@"Thai" success:^(AFHTTPRequestOperation *operation, id response) {
            NSLog(@"response: %@", response);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error: %@", [error description]);
        }];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.RestaurentTableView.dataSource = self;
    self.RestaurentTableView.delegate = self;

    [self reloadData];
}

-(void)reloadData{
    NSLog(@"reload data");
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
    RestaurantCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyRestaurantsCell" forIndexPath:indexPath];
//    NSDictionary *movie = self.movies[indexPath.row];
//    cell.titleLabel.text = movie[@"title"];
//    cell.synopsisLabel.text = movie[@"synopsis"];
//    NSString *postURLString = [movie valueForKeyPath:@"posters.thumbnail"];
//    [cell.posterView setImageWithURL:[NSURL URLWithString:postURLString]];
    return cell;
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
