//
//  FirstViewController.h
//  YildizYemek
//
//  Created by Said on 08/01/2015.
//  Copyright (c) 2015 Tower Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWLFoodListViewController : UIViewController <UIPageViewControllerDataSource,UIPageViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *errorMessageLabel;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (strong, nonatomic) UIPageViewController *pageController;

@end

