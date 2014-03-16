//
//  TLWebViewController.h
//  YTUYemekhaneIOS
//
//  Created by Meryem on 3/1/14.
//  Copyright (c) 2014 TowerLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLWebViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *refreshButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

- (id)initWithURL:(NSURL *)twitterURL;
- (IBAction)goBack:(id)sender;
- (IBAction)goForward:(id)sender;
- (IBAction)refresh:(id)sender;

@end
