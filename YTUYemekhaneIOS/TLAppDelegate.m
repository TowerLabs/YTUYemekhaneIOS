//
//  TLAppDelegate.m
//  YTUYemekhaneIOS
//
//  Created by Davut Ucar on 6.03.2014.
//  Copyright (c) 2014 TowerLabs. All rights reserved.
//

#import "TLAppDelegate.h"
#import "TLFoodViewController.h"
#import "TLAboutViewController.h"

@interface TLAppDelegate ()

@property (strong, nonatomic) TLFoodViewController *foodViewController;

@end

@implementation TLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self setProjectMembers];
    [self setTabBarViews];
    [self.window makeKeyAndVisible];
    return YES;
}
- (void)setProjectMembers
{
    self.projectFont = [UIFont fontWithName:@"Lato-Light" size:16.0f];

}
- (void)setTabBarViews
{
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    [[UITabBar appearance] setTintColor:[UIColor redColor]];
    [[UITabBar appearance] setBarTintColor:[UIColor blueColor]];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_projectFont, NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    TLFoodViewController *foodViewController = [[TLFoodViewController alloc] initWithNibName:@"TLFoodViewController" bundle:nil];
    TLAboutViewController *aboutViewController = [[TLAboutViewController alloc] initWithNibName:@"TLAboutViewController" bundle:nil];
    
    [foodViewController.tabBarItem setTitle:@"Yemek Listesi"];
    [aboutViewController.tabBarItem setTitle:@"Hakkımızda"];
    
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:tabBarController];
    
#warning TODO: Set title
    [_navigationController setTitle:@"YTU"];

    [tabBarController setViewControllers:[NSArray arrayWithObjects:foodViewController,aboutViewController, nil]];
    
    [self.window setRootViewController:_navigationController];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
