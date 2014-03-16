//
//  TLAboutCellViewController.h
//  YTUYemekhaneIOS
//
//  Created by Meryem on 3/8/14.
//  Copyright (c) 2014 TowerLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLAboutCellViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageOutlet;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *siteLabel;
@property (strong, nonatomic) IBOutlet UIImageView *icon;


- (id)initWithDeveloperInfo: (NSDictionary *)infoDictionary;
- (IBAction)openWebView:(id)sender;

@end
