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
@property (nonatomic,strong) NSString *foodDate;
@property (nonatomic,strong) NSLocale *locale;
@end

@implementation TLFoodCellViewController

#pragma mark - LifeCycle

- (id)initWithFoodDictionary:(NSDictionary *)foodDictionary Date: (NSString *)foodDate
{
    self = [super initWithNibName:@"TLFoodCellViewController" bundle:nil];
    if (self)
    {
        self.foodDictionary = [[NSDictionary alloc] initWithDictionary:foodDictionary];
        self.foodDate = [[NSString alloc] initWithString:foodDate];
        self.locale =  [[NSLocale alloc] initWithLocaleIdentifier:@"tr"];
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
    
//    NSMutableArray *lunchList = [[NSMutableArray alloc] initWithArray:[[_foodDictionary valueForKey:@"main_lunch"] componentsSeparatedByString:@","]];
//    NSMutableArray *altLunchList = [[NSMutableArray alloc] initWithArray:[[_foodDictionary valueForKey:@"alt_lunch"] componentsSeparatedByString:@","]];
    
    NSMutableArray *lunchList = [[NSMutableArray alloc] init];
    NSLog(@"%d",lunchList.count);
    
    NSMutableArray *altLunchList = [[NSMutableArray alloc] init];

    NSMutableArray *dinnerList = [[NSMutableArray alloc] initWithArray:[[_foodDictionary valueForKey:@"main_dinner"] componentsSeparatedByString:@","]];
    NSMutableArray *altDinnerList = [[NSMutableArray alloc] initWithArray:[[_foodDictionary valueForKey:@"alt_dinner"] componentsSeparatedByString:@","]];

    UIFont *labelFont12pt = [UIFont fontWithName:@"Lato-Light" size:12.0f];
    UIFont *headingFont = [UIFont fontWithName:@"Lato-Medium" size:14.0f];
    
    NSString *lunch = [[NSString alloc] init];
    int yOffset = 0;

    [self.lunchTitle setFont:headingFont];
    [self.dinnerTitle setFont:headingFont];
    [self.dateTitle setFont:headingFont];
    _lunchTitle.text = @"Öğle Yemeği";
    _dinnerTitle.text = @"Akşam Yemeği";
    
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd.MM.yyyy"];
    [dateFormat setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"tr_TR"]];
    NSDate *date = [dateFormat dateFromString:_foodDate];
    [dateFormat setDateFormat:@"dd MMMM EEEE"];
    _dateTitle.text = [dateFormat stringFromDate:date];
    
    if (nil == lunchList && nil == altLunchList)
    {
        UILabel *noFoodLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _lunchContainer.frame.size.width, 20)];
        noFoodLabel.text = @"Bugün yemek yok";
        [noFoodLabel setFont:labelFont12pt];
        [_lunchContainer addSubview:noFoodLabel];
    }
    
    for (NSString *anyFood in lunchList)
    {
        lunch = [self clearCharactersInString:anyFood];
        UILabel *lunchLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, yOffset, _lunchContainer.frame.size.width, 20)];
        lunchLabel.text = lunch;
        [lunchLabel setFont:labelFont12pt];
        [_lunchContainer addSubview:lunchLabel];
        yOffset += 15;
        
    }

    for (NSString *anyFood in altLunchList)
    {
        lunch = [self clearCharactersInString:anyFood];
        if ([lunch rangeOfString:@"Vjt"].location == NSNotFound) {
            UILabel *lunchLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, yOffset, _lunchContainer.frame.size.width, 20)];
            lunchLabel.text = lunch;
            [lunchLabel setFont:labelFont12pt];
            [_lunchContainer addSubview:lunchLabel];
            yOffset += 15;
        }

    }
    
    yOffset = 0;
    
    if (0 == dinnerList.count && 0 == altDinnerList.count)
    {
        UILabel *noFoodLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _dinnerContainer.frame.size.width, 20)];
        noFoodLabel.text = @"Bugün yemek yok";
        [noFoodLabel setFont:labelFont12pt];
        [_dinnerContainer addSubview:noFoodLabel];
    }
    
    for (NSString *anyFood in dinnerList)
    {
        lunch = [self clearCharactersInString:anyFood];
        UILabel *dinnerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, yOffset, _dinnerContainer.frame.size.width, 20)];
        dinnerLabel.text = lunch;
        [dinnerLabel setFont:labelFont12pt];
        [_dinnerContainer addSubview:dinnerLabel];
        yOffset += 15;
        
    }
    
    for (NSString *anyFood in altDinnerList)
    {
        lunch = [self clearCharactersInString:anyFood];
        UILabel *dinnerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, yOffset, _dinnerContainer.frame.size.width, 20)];
        dinnerLabel.text = lunch;
        [dinnerLabel setFont:labelFont12pt];
        [_dinnerContainer addSubview:dinnerLabel];
        yOffset += 15;
        
    }
    

//    _lunchList.text = [objectAtIndex:0];
//    _dinnerList.text = [[[_foodDictionary valueForKey:@"main_dinner"] componentsSeparatedByString:@","]objectAtIndex:0];
}

- (NSString *)clearCharactersInString: (NSString *)dirtyString
{
    
    NSString *clearString = @"";
//    dirtyString = [dirtyString initWithData:[dirtyString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES] encoding:NSUTF8StringEncoding]
    clearString = [dirtyString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    clearString = [clearString stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    clearString = [clearString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    clearString = [clearString stringByReplacingOccurrencesOfString:@"&#13;" withString:@""];
    clearString = [clearString capitalizedStringWithLocale:_locale];

    return clearString;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
