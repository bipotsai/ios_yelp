//
//  SwitchCell.h
//  yelp
//
//  Created by Bipo Tsai on 6/22/15.
//  Copyright (c) 2015 Bipo Tsai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwitchCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UISwitch *toggleSwitch;
- (IBAction)didUpdatedValue:(id)sender;

@end
