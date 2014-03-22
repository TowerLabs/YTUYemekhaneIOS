/*
 TLWebViewController.m
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
    [_webView reload];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self openURL];
    _webView.delegate = self;
}

- (void)openURL
{
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:_twitterURL];
    [self.webView loadRequest:urlRequest];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_loadingIndicator stopAnimating];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
