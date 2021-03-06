//
//  SwitchCell.m
//  yelp
//
//  Created by Bipo Tsai on 6/22/15.
//  Copyright (c) 2015 Bipo Tsai. All rights reserved.
//

#import "SwitchCell.h"

@implementation SwitchCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setOn:(BOOL)on {
    [self setOn:on animated:NO];
}
- (void) setOn:(BOOL)on animated:(BOOL)animated{
    _on = on;
    [self.toggleSwitch setOn:on animated:animated];
}

- (IBAction)didUpdatedValue:(id)sender {
    [self.delegate switchCell:self didUpdateValue:self.toggleSwitch.on];
}
@end
