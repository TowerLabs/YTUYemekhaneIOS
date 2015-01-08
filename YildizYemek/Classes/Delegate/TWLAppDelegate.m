//
//  AppDelegate.m
//  YildizYemek
//
//  Created by Said on 08/01/2015.
//  Copyright (c) 2015 Tower Labs. All rights reserved.
//

#import "TWLAppDelegate.h"

@interface TWLAppDelegate ()

@end

@implementation TWLAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor whiteColor], NSForegroundColorAttributeName,
      [UIFont fontWithName:@"Lato-Bold" size:18.0], NSFontAttributeName,nil]];
    
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:233.0f/255.0f green:125.0f/255.0f blue:54.0f/255.0f alpha:1.0f]];

    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Lato-Light" size:14.0f], NSFontAttributeName, nil] forState:UIControlStateNormal];

    
    return YES;
}
@end