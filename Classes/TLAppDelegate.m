/*
 TLAppDelegate.m
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
    
    UILocalNotification *localNotif = [launchOptions
                                       objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    
    if (localNotif)
    {
        NSLog(@"Has notifications.");
    }
    else {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
    }
    
    return YES;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notif
{
    NSLog(@"application: didReceiveLocalNotification:");
}

- (void)setProjectMembers
{
   
    self.projectFont = [UIFont fontWithName:@"Lato-Light" size:16.0f];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}
- (void)setTabBarViews
{
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:233.0f/255.0f green:125.0f/255.0f blue:54.0f/255.0f alpha:1.0f]];
//    [[UITabBar appearance] setBarTintColor:[UIColor colorWithRed:194.0f/255.0f green:188.0f/255.0f blue:169.0f/255.0f alpha:0.54f]];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Lato-Light" size:14.0f], NSFontAttributeName, nil] forState:UIControlStateNormal];
    [[UIBarButtonItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"Lato-Medium" size:18.0f], NSFontAttributeName,nil] forState:UIControlStateNormal];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"Lato-Bold" size:18.0f], NSFontAttributeName,nil]];
    
    TLFoodViewController *foodViewController = [[TLFoodViewController alloc] initWithNibByDevice];
    TLAboutViewController *aboutViewController = [[TLAboutViewController alloc] initWithNibByDevice];
    
    [foodViewController.tabBarItem setTitle:@"Yemek Listesi"];
    [foodViewController.tabBarItem setImage:[UIImage imageNamed:@"foodLight"]];
//    [foodViewController.tabBarItem setSelectedImage:[UIImage imageNamed:@"foodDark"]];
    [aboutViewController.tabBarItem setTitle:@"Hakkımızda"];
    [aboutViewController.tabBarItem setImage:[UIImage imageNamed:@"TeamLight"]];
//    [aboutViewController.tabBarItem setSelectedImage:[UIImage imageNamed:@"TeamDark"]];
    
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:tabBarController];
    _navigationController.navigationBar.barTintColor = [UIColor colorWithRed:233.0f/255.0f green:125.0f/255.0f blue:54.0f/255.0f alpha:1.0f];

    [tabBarController setViewControllers:[NSArray arrayWithObjects:foodViewController,aboutViewController, nil]];
    
    [self.window setRootViewController:_navigationController];
    [self.window setTintColor:[UIColor whiteColor]];
}

- (void)setLocalNotification
{
//    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
//
//    [dateComponents setDay:1];
//    [dateComponents setHour:10];
//    [dateComponents setMinute:0];
//    
//    
//    UIApplication* app = [UIApplication sharedApplication];
//    UILocalNotification *foodLocalNotification = [[UILocalNotification alloc] init];
//    
//    foodLocalNotification.soundName = @"";
//    foodLocalNotification.repeatInterval = NSMinuteCalendarUnit;
//    foodLocalNotification.timeZone = [NSTimeZone localTimeZone];
//    foodLocalNotification.fireDate = dateComponents.date;
//    
//    NSArray* oldNots = [app scheduledLocalNotifications];
//    
//    if ([oldNots count]>0)
//    {
//        [app cancelAllLocalNotifications];
//    }
//    
//    foodLocalNotification.alertBody = @"asad";
//    
//    [app presentLocalNotificationNow:foodLocalNotification];
    NSCalendar *localCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSLocaleCalendar];
    
    NSDateComponents *dateComponent = [localCalendar components:NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:[NSDate date]];
    
    
    [dateComponent setWeekday:5];
    [dateComponent setHour:22];
    [dateComponent setMinute:34];
    
    
    
    UILocalNotification *notification = [[UILocalNotification alloc]init];
    [notification setAlertBody:@"GOOD MORNING!"];
    [notification setSoundName:UILocalNotificationDefaultSoundName];
    [notification setFireDate:[localCalendar dateFromComponents:dateComponent]];
    notification.repeatInterval = NSWeekdayCalendarUnit;
    [notification setTimeZone:[NSTimeZone defaultTimeZone]];
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
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
    [self setLocalNotification];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
\
}

@end
