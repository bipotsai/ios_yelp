//
//  ConfigurationViewController.m
//  
//
//  Created by Bipo Tsai on 6/21/15.
//
//

#import "ConfigurationViewController.h"
#import "SwitchCell.h"
#import "CheckCell.h"


@interface ConfigurationViewController ()<UITableViewDataSource, UITableViewDelegate, SwitchCellDelegate>{
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableSet *selectedCatories;
@property (nonatomic, readonly) NSDictionary *filters;
@property (nonatomic, strong) NSArray *configsSectionTitles;
@property (nonatomic, strong) NSMutableArray *configsSectionExpanded;
@property (strong, nonatomic) NSArray *categories;
@property (nonatomic, strong) NSArray *sortModes;
@property (nonatomic, strong) NSArray *distances;

@end

@implementation ConfigurationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad ConfigurationViewController");
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(pressCancelBtn)];
    
    UIBarButtonItem *searchBtn = [[UIBarButtonItem alloc] initWithTitle:@"Search" style:UIBarButtonItemStylePlain target:self action:@selector(pressSearchBtn)];

    self.navigationItem.rightBarButtonItem = searchBtn;
    self.navigationItem.leftBarButtonItem = cancelBtn;

    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    
    self.selectedCatories = [NSMutableSet set];
    [self initConfiguration];

    
  
    
    
}

- (void)loadView{
    [super loadView];
    NSLog(@"loadView");
}

-(void)initConfiguration {
    self.categories = @[@{@"name" : @"Lounges", @"code":@"lounges"},
                        @{@"name" : @"Pubs", @"code":@"pubs"},
                        @{@"name" : @"Sports Bars", @"code":@"sportsbars"},
                        @{@"name" : @"Wine Bars", @"code":@"wine_bars"}];
    self.sortModes =
    @[
      @{@"name" : @"Best Match", @"value" : @0},
      @{@"name" : @"Closest", @"value" : @1},
      @{@"name" : @"Highest rated", @"value" : @2}
      ];
    self.distances =
    @[
      @{@"name" : @"Auto", @"value" : @0},
      @{@"name" : @"100 m", @"value" : @100},
      @{@"name" : @"1 km", @"value" : @1000},
      @{@"name" : @"5 kms", @"value" : @5000},
      @{@"name" : @"10 kms", @"value" : @10000},
      ];
    self.configsSectionTitles = @[@"deals",@"sortModes",@"distance",@"categories"];
    self.configsSectionExpanded = [ [ NSMutableArray alloc ] initWithObjects:@NO,@NO,@NO,@NO,nil];

}

- (void) switchCell:(SwitchCell *)cell didUpdateValue:(BOOL)value{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if(value){
        NSLog(@"value");
        [self.selectedCatories addObject:self.categories[indexPath.row]];
    }else{
        NSLog(@"no value");
        [self.selectedCatories removeObject:self.categories[indexPath.row]];
    }
}

#pragma mark - Private methods

- (NSDictionary *)filters {
    NSMutableDictionary *filters = [NSMutableDictionary dictionary];
    if (self.selectedCatories.count > 0){
        NSMutableArray *names = [NSMutableArray array];
        for (NSDictionary *category in self.selectedCatories){
            [names addObject:category[@"code"]];
        }
        NSString *categoryFilter = [names componentsJoinedByString:@","];
        [filters setObject:categoryFilter forKey:@"category_filter"];
    }
    return filters;
}

-(void)pressCancelBtn {
    NSLog(@"Eh up, someone just pressed the Cancel button!");
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)pressSearchBtn {
    NSLog(@"Eh up, someone just pressed the Search button!");
    [self.delegate configurationViewController:self didChangeFilters:self.filters];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.configsSectionTitles count];
}

#pragma mark - Table view delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    NSLog(@"section : %ld %@",(long)section, self.configsSectionExpanded[section]);
    if ( self.configsSectionExpanded[section] == NO) {
        self.configsSectionExpanded[section] = @YES;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
    }else{
        self.configsSectionExpanded[section]= @1;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:(NSUInteger) section]
                      withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
}


#pragma mark - Table view data source methods

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Offering Deals";
        case 1:
            return @"Sort By";
        case 2:
            return @"Distance";
        case 3:
            return @"Categories";  // only restaurants for the moment
        default:
            return @"Nothing";
    }
}


- (NSInteger)tableView:(UITableView *)tableView  numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
        case 1:
            if (self.configsSectionExpanded[section]) {
               return self.sortModes.count;
            }else{
               return 1;
            }
        case 2:
            if (self.configsSectionExpanded[section]) {
            return self.distances.count;
            }else{
                return 1;
            }
        case 3:

            return self.categories.count;

        default:
            return 0;
    }

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CheckCell *checkcell = [tableView dequeueReusableCellWithIdentifier:@"MyCheckCell"];
    SwitchCell *switchcell = [tableView dequeueReusableCellWithIdentifier:@"MySwitchCell"];
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    switch (section) {
        case 0:
            NSLog(@"Offering a Deal");
            switchcell.nameLabel.text = @"Offering a Deal";
            switchcell.accessoryType = UITableViewCellAccessoryNone;
            switchcell.delegate = self;
            return switchcell;
        case 1:
            NSLog(@"sortModes");
            checkcell.accessoryView = nil;
            checkcell.accessoryType = UITableViewCellAccessoryNone;
            //if (self.configsSectionExpanded[section]) {
                checkcell.nameLabel.text = self.sortModes[indexPath.row][@"name"];
            //}else{
            //    checkcell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"drop25"]];
            //}
            return checkcell;
        case 2:
            NSLog(@"distances");
            checkcell.accessoryView = nil;
            checkcell.accessoryType = UITableViewCellAccessoryNone;
            //if (self.configsSectionExpanded[section]) {
                checkcell.nameLabel.text = self.distances[indexPath.row][@"name"];
            //}else{
            //    checkcell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"drop25"]];
            //}
            return checkcell;
        case 3:
            NSLog(@"categories");
            //if (self.configsSectionExpanded[section]) {
            switchcell.nameLabel.text = self.categories[indexPath.row][@"name"];
            switchcell.on = [self.selectedCatories containsObject:self.categories[indexPath.row]];
            switchcell.delegate = self;
            //}else{
            //    switchcell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"drop25"]];
            //}
            return switchcell;
        default:
            return nil;

    }
}

@end
