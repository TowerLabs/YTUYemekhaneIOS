//
//  TWLAboutCell.h
//  YildizYemek
//
//  Created by Said on 11/01/2015.
//  Copyright (c) 2015 Tower Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWLAboutCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *twitterButton;
@property (strong, nonatomic) IBOutlet UIImageView *authorImage;
@end
