//
//  TLAboutCellViewController.m
//  YTUYemekhaneIOS
//
//  Created by Meryem on 3/8/14.
//  Copyright (c) 2014 TowerLabs. All rights reserved.
//

#import "TLAboutCellViewController.h"
#import "TLWebViewController.h"

@interface TLAboutCellViewController ()

@property (nonatomic, strong) NSDictionary *infoDictionary;

@end

@implementation TLAboutCellViewController

#pragma mark - LifeCycle
- (id)initWithDeveloperInfo: (NSDictionary *)infoDictionary
{
    self = [super initWithNibName:@"TLAboutCellViewController" bundle:nil];
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
#warning TODO: Change back title
    [DELEGATE.navigationController pushViewController:webViewController animated:YES];
}




@end
