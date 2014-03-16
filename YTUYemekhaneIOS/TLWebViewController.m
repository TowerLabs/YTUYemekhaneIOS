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
    if ([[UIScreen mainScreen] bounds].size.height > 480.0f) // retina 4"
    {
        self = [super initWithNibName:@"TLWebViewController_4" bundle:nil];
    }
    else // retina 3.5"
    {
        self = [super initWithNibName:@"TLWebViewController_3" bundle:nil];
    }
    if (self)
    {
        self.twitterURL = twitterURL;
    }
    return self;
}

- (IBAction)goBack:(id)sender
{
    if ([_webView canGoBack])
    {
        [_webView goBack];
    }
}

- (IBAction)goForward:(id)sender
{
    if ([_webView canGoForward])
    {
        [_webView goForward];
    }
}

- (IBAction)refresh:(id)sender
{
    
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
