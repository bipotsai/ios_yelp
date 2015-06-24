//
//  RestaurantCell.m
//  yelp
//
//  Created by Bipo Tsai on 6/21/15.
//  Copyright (c) 2015 Bipo Tsai. All rights reserved.
//

#import "RestaurantCell.h"

@implementation RestaurantCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)prepareForReuse{
    [super prepareForReuse];
    self.nameLabel.text = @"name la";
    self.distanceLabel.text = @"distance la";
    self.image.image = nil;
}


@end
