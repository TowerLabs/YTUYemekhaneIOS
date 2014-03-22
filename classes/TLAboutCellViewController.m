/*
 TLAboutCellViewController.m
 YTUYemekhaneIOS
 Copyright (C) 2014 TowerLabs
 
 This program is free software; you can redistribute it and/or
 modify it under the terms of the GNU General Public License
 as published by the Free Software Foundation; either version 2
 of the License, or (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program; if not, write to the
 Free Software Foundation, Inc., 51 Franklin Street,
 Fifth Floor, Boston, MA  02110-1301, USA.
 */

#import "TLAboutCellViewController.h"
#import "TLWebViewController.h"

@interface TLAboutCellViewController ()

@property (nonatomic, strong) NSDictionary *infoDictionary;

@end

@implementation TLAboutCellViewController

#pragma mark - LifeCycle
- (id)initWithDeveloperInfo: (NSDictionary *)infoDictionary
{
    if ([[UIScreen mainScreen] bounds].size.height > 480.0f) // retina 4"
    {
        self = [super initWithNibName:@"TLAboutCellViewController_4" bundle:nil];
    }
    else // retina 3.5"
    {
        self = [super initWithNibName:@"TLAboutCellViewController_3" bundle:nil];
    }

    if (self)
    {
        self.infoDictionary = [[NSDictionary alloc] initWithDictionary:infoDictionary];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setInfo];
}

- (void)setInfo
{
#warning TODO: Set the images when they're added to project
    NSString *name = [[NSString alloc] initWithString:[_infoDictionary valueForKey:@"name"]];
    NSString *twitter = [[NSString alloc] initWithString:[_infoDictionary valueForKey:@"twitter"]];
    
    [_nameLabel setText:name];
    [_nameLabel setFont:DELEGATE.projectFont];
    
    [_siteLabel setTitle:twitter forState:UIControlStateNormal];
    [_siteLabel.titleLabel setFont:DELEGATE.projectFont];
    [_icon setImage:[UIImage imageNamed:[_infoDictionary valueForKey:@"image"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action
- (IBAction)openWebView:(id)sender
{
    NSLog(@"Link: %@",[_infoDictionary valueForKey:@"link"]);
    
    NSURL *twitterURL = [NSURL URLWithString:[_infoDictionary valueForKey:@"link"]];
    TLWebViewController *webViewController = [[TLWebViewController alloc] initWithURL:twitterURL];
    [DELEGATE.navigationController pushViewController:webViewController animated:YES];
}




@end
