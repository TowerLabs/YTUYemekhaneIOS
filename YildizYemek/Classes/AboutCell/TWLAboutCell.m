//
//  TWLAboutCell.m
//  YildizYemek
//
//  Created by Said on 11/01/2015.
//  Copyright (c) 2015 Tower Labs. All rights reserved.
//

#import "TWLAboutCell.h"

@implementation TWLAboutCell

- (void)awakeFromNib {
    self.nameLabel.font = [UIFont fontWithName:@"Lato-Light" size:16.0f];
    self.twitterButton.titleLabel.font = [UIFont fontWithName:@"Lato-Light" size:16.0f];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
