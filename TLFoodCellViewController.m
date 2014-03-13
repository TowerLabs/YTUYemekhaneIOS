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
    NSMutableArray *lunchList = [[NSMutableArray alloc] initWithArray:[[_foodDictionary valueForKey:@"main_lunch"] componentsSeparatedByString:@","]];
    NSString *lunch = [[NSString alloc] init];
    int yOffset = 0;
    for (NSString *anyFood in lunchList)
    {
        lunch = [self clearCharactersInString:anyFood];
        UILabel *lunchLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, yOffset, _lunchContainer.frame.size.width, 20)];
        lunchLabel.text = lunch;
        [lunchLabel setFont:[UIFont fontWithName:@"Lato-Light" size:12.0f]];
        [_lunchContainer addSubview:lunchLabel];
        yOffset += 20;
    }
    

//    _lunchList.text = [objectAtIndex:0];
//    _dinnerList.text = [[[_foodDictionary valueForKey:@"main_dinner"] componentsSeparatedByString:@","]objectAtIndex:0];
}

- (NSString *)clearCharactersInString: (NSString *)dirtyString
{
    NSString *clearString = @"";
//    dirtyString = [dirtyString initWithData:[dirtyString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES] encoding:NSUTF8StringEncoding];

    clearString = [dirtyString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    clearString = [clearString stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    clearString = [clearString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    clearString = [clearString capitalizedString];

    return clearString;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
