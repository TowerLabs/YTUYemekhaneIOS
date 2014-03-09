//
//  TLWebViewController.m
//  YTUYemekhaneIOS
//
//  Created by Meryem on 3/1/14.
//  Copyright (c) 2014 TowerLabs. All rights reserved.
//

#import "TLWebViewController.h"

@interface TLWebViewController ()

@property (nonatomic, strong) NSURL *twitterURL;

@end

@implementation TLWebViewController

- (id)initWithURL:(NSURL *)twitterURL
{
    self = [super initWithNibName:@"TLWebViewController" bundle:nil];
    if (self)
    {
        self.twitterURL = twitterURL;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self openURL];
}

- (void)openURL
{
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:_twitterURL];
    [self.webView loadRequest:urlRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
