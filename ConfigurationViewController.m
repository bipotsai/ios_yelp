//
//  ConfigurationViewController.m
//  
//
//  Created by Bipo Tsai on 6/21/15.
//
//

#import "ConfigurationViewController.h"
#import "SwitchCell.h"



@interface ConfigurationViewController ()<UITableViewDataSource, UITableViewDelegate, SwitchCellDelegate>{
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *categories;
@property (nonatomic, strong) NSMutableSet *selectedCatories;
@property (nonatomic, readonly) NSDictionary *filters;
@end

@implementation ConfigurationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self){
        self.selectedCatories = [NSMutableSet set];
         [self initCategories];
    }
    return self;
}

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
    [self initCategories];

    
  
    
    
}

- (void)loadView{
    [super loadView];
    NSLog(@"loadView");
}

-(void)initCategories {
    self.categories = @[@{@"name" : @"Lounges", @"code":@"lounges"},
                        @{@"name" : @"Pubs", @"code":@"pubs"},
                        @{@"name" : @"Sports Bars", @"code":@"sportsbars"},
                        @{@"name" : @"Wine Bars", @"code":@"wine_bars"}];

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

- (NSInteger)tableView:(UITableView *)tableView  numberOfRowsInSection:(NSInteger)section{
    return self.categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MySwitchCell" forIndexPath:indexPath];
    cell.nameLabel.text = self.categories[indexPath.row][@"name"];
    cell.on = [self.selectedCatories containsObject:self.categories[indexPath.row]];
    cell.delegate = self;

    
    return cell;
}

@end
