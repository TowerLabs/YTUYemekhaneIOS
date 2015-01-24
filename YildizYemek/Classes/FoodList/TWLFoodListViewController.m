//
//  FirstViewController.m
//  YildizYemek
//
//  Created by Said on 08/01/2015.
//  Copyright (c) 2015 Tower Labs. All rights reserved.
//

#import "TWLFoodListViewController.h"
#import "TWLFoodListCellViewController.h"
#import "TWLDataManager.h"
#import "TWLFood.h"

@interface TWLFoodListViewController ()
@property (strong, nonatomic) NSMutableArray *foodList;
@property (strong, nonatomic) NSMutableArray *foodObjectsList;
@property (strong, nonatomic) TWLDataManager *dataManager;
@property BOOL isAttempted;
@property int keyOfToday;
@end

@implementation TWLFoodListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:240.0/255.0 green:237.0/255.0 blue:235.0/255.0 alpha:1.0]];
    self.foodObjectsList = [[NSMutableArray alloc] init];
    self.dataManager = [[TWLDataManager alloc] init];
    self.errorMessageLabel.font = [UIFont fontWithName:@"Lato-Medium" size:14];
    [_dataManager getFoodListWithCallback:^(NSMutableArray *foodList, NSError *error)
     {
         if (nil == error)
         {
             self.foodList = [[NSMutableArray alloc] initWithArray:foodList];
             if ([TWLDataManager validateData:_foodList])
             {
                 [self processData];
             }
             else
             {
                 [self showErrorMessage:@"Bu ay için yemek menüsü henüz yayınlanmadı."];
             }
         }
         else
         {
             [self showErrorMessage:@"Yemek menülerini alırken bir sorun oluştu. Lütfen daha sonra tekrar deneyiniz."];
         }
     }];
}
#pragma mark - Helpers
- (void)processData
{
    self.keyOfToday = [self getKeyOfToday];
    if ( -1 == _keyOfToday)
    {
        if (!_isAttempted)
        {
            _isAttempted = YES;
            [_dataManager refreshData:^(NSMutableArray *foodList, NSError *error) {
                if (nil == error)
                {
                    self.foodList = [[NSMutableArray alloc] initWithArray:foodList];
                    if ([TWLDataManager validateData:_foodList])
                    {
                        [self processData];
                    }
                    else
                    {
                        [self showErrorMessage:@"Bu ay için yemek menüsü henüz yayınlanmadı."];
                    }
                }
                else
                {
                    [self showErrorMessage:@"Yemek menülerini alırken bir sorun oluştu. Lütfen daha sonra tekrar deneyiniz."];
                }
            }];
        }
        else
        {
            [self showErrorMessage:@"Bu ay için görüntülenecek yemek menüsü kalmadı."];
        }
    }
    else
    {
        NSInteger end;
        
        if(_foodList.count <= _keyOfToday+10 )
        {
            end = _foodList.count-1;
        }
        else
        {
            end = _keyOfToday + 10;
        }
        
        for (int i=_keyOfToday; i<=end;i++)
        {
            @autoreleasepool {
                TWLFood *food = [[TWLFood alloc] initWithFoodDictionary:[_foodList objectAtIndex:i]];
                [_foodObjectsList addObject:food];
            }
        }
        if ([_foodObjectsList count] == 0)
        {
            [self showErrorMessage:@"Bu ay için görüntülenecek yemek menüsü kalmadı."];
        }
        else
        {
            self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:@{UIPageViewControllerOptionInterPageSpacingKey:@20}];
            self.pageController.dataSource = self;
            self.pageController.delegate = self;
            [[self.pageController view] setFrame:CGRectMake(0,64, self.view.frame.size.width, self.view.frame.size.height-114)];
            [self.pageController.view setBackgroundColor:[UIColor colorWithRed:240.0/255.0 green:237.0/255.0 blue:235.0/255.0 alpha:1.0]];

            for (UIView *subView in self.pageController.view.subviews) {
                if ([subView isKindOfClass:[UIPageControl class]]) {
                    UIPageControl *pageControl = (UIPageControl *)subView;
                    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:233.0/255.0 green:125.0/255.0 blue:54.0/255.0 alpha:1];
                    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
                    break;
                }
            }
        
            TWLFoodListCellViewController *initialViewController = [self viewControllerAtIndex:0];
            NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
        
            [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];

            [self addChildViewController:self.pageController];
            [[self view] addSubview:[self.pageController view]];
            [self.pageController didMoveToParentViewController:self];
        }
    }
    [_activityIndicator stopAnimating];
}
- (int)getKeyOfToday
{
    NSString *dateKey = @"";
    NSArray *key = [[NSArray alloc]init];
    NSInteger tempDay;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:[NSDate date]];
    NSInteger today = [components day];
    for (int i=0; i<_foodList.count; i++)
    {
        dateKey = [[[_foodList objectAtIndex:i] allKeys]objectAtIndex:0];
        key = [dateKey componentsSeparatedByString:@"."];
        tempDay = [[key objectAtIndex:0]integerValue];
        if (tempDay >= today) {
            return i;
        }
    }
    return -1;
}
- (TWLFoodListCellViewController *)viewControllerAtIndex:(NSUInteger)index {
    TWLFoodListCellViewController *childViewController = [[TWLFoodListCellViewController alloc] initWithData:[_foodObjectsList objectAtIndex:index]];
    childViewController.index = index;
    return childViewController;
}
- (void)showErrorMessage: (NSString *)message
{
    _errorMessageLabel.hidden = NO;
    _errorMessageLabel.text = message;
}
#pragma mark - UIPageViewControllerDataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(TWLFoodListCellViewController *)viewController index];
    
    if (index == 0) {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(TWLFoodListCellViewController *)viewController index];
    
    index++;
    
    if (index == [_foodObjectsList count]) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
    
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return [_foodObjectsList count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}
@end