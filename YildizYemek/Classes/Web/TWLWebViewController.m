/*
 TWLWebViewController.m
 YildizYemek
 
 Created by Said on 11/01/2015.
 Copyright (c) 2014 Tower Labs. All rights reserved.
 
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

#import "TWLWebViewController.h"

@interface TWLWebViewController ()

@end

@implementation TWLWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    [[UIBarButtonItem appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"Lato-Bold" size:18.0],
      NSFontAttributeName, nil] forState:UIControlStateNormal];

    [self toggleButtons];
    [self openURL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)goBack:(id)sender
{
    if ([_webView canGoBack])
    {
        [_webView goBack];
    }
    [self toggleButtons];
}

- (IBAction)goForward:(id)sender
{
    if ([_webView canGoForward])
    {
        [_webView goForward];
    }
    [self toggleButtons];
}

- (IBAction)refresh:(id)sender
{
    [_webView reload];
}


- (void)openURL
{
    NSLog(@"%@", _link);
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:_link];
    [_webView loadRequest:urlRequest];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self toggleButtons];
    [_loadingIndicator stopAnimating];
}
- (void)toggleButtons
{
    if (![_webView canGoBack])
    {
        [_backButton setEnabled:NO];
    }
    else
    {
        [_backButton setEnabled:YES];
    }
    if (![_webView canGoForward])
    {
        [_forwardButton setEnabled:NO];
    }
    else
    {
        [_forwardButton setEnabled:YES];
    }
}

-(BOOL)hidesBottomBarWhenPushed
{
    return YES;
}

@end
