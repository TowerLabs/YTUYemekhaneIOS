//
//  TLFoodCellViewController.m
//  YTUYemekhaneIOS
//
//  Created by Davut Ucar on 6.03.2014.
//  Copyright (c) 2014 TowerLabs. All rights reserved.
//

#import "TLFoodCellViewController.h"

@interface TLFoodCellViewController ()

@property (nonatomic,strong) NSDictionary *foodDictionary;

@end

@implementation TLFoodCellViewController

#pragma mark - LifeCycle
- (id)initWithFoodDictionary:(NSDictionary *)foodDictionary
{
    self = [super initWithNibName:@"TLFoodCellViewController" bundle:nil];
    if (self)
    {
        self.foodDictionary = [[NSDictionary alloc] initWithDictionary:foodDictionary];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setFoodList];
}

- (void)setFoodList
{
    _lunchList.text = [_foodDictionary valueForKey:@"main_lunch"];
    _dinnerList.text = [_foodDictionary valueForKey:@"main_dinner"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
