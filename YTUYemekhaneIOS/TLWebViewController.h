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

- (id)initWithURL:(NSURL *)twitterURL;

@end
