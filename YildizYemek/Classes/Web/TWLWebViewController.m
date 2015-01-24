//
//  TWLWebViewController.m
//  YildizYemek
//
//  Created by Said on 11/01/2015.
//  Copyright (c) 2015 Tower Labs. All rights reserved.
//

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
