//
//  SwitchCell.h
//  yelp
//
//  Created by Bipo Tsai on 6/22/15.
//  Copyright (c) 2015 Bipo Tsai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SwitchCell;

@protocol SwitchCellDelegate <NSObject>
- (void) switchCell:(SwitchCell *)cell didUpdateValue:(BOOL)value;
@end

@interface SwitchCell : UITableViewCell
@property (nonatomic, assign) BOOL on;
@property (nonatomic, weak) id<SwitchCellDelegate> delegate;

- (void) setOn:(BOOL)on animated:(BOOL)animated;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UISwitch *toggleSwitch;
- (IBAction)didUpdatedValue:(id)sender;

@end
