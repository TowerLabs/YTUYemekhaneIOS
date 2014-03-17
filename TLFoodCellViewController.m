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
    int yOffset = 0;
    
    UIFont *labelFont12pt = [UIFont fontWithName:@"Lato-Light" size:12.0f];
    UIFont *labelFont14pt = [UIFont fontWithName:@"Lato-Light" size:14.0f];

    UIFont *headingFont = [UIFont fontWithName:@"Lato-Medium" size:14.0f];
    
    //setting fonts
    [self.lunchTitle setFont:headingFont];
    [self.dinnerTitle setFont:headingFont];
    [self.dateTitle setFont:headingFont];
    
    //settting texts
    _lunchTitle.text = @"Öğle Yemeği";
    _dinnerTitle.text = @"Akşam Yemeği";
    
    //creating date string
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd.MM.yyyy"];
    [dateFormat setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"tr_TR"]];
    NSDate *date = [dateFormat dateFromString:_foodDate];
    [dateFormat setDateFormat:@"dd MMMM EEEE"];
    
    //setting date string
    _dateTitle.text = [dateFormat stringFromDate:date];
    
    NSString *lunch = @"";
    
    if ([[_foodDictionary valueForKey:@"main_lunch"] length])
    {
        NSMutableArray *lunchList = [[NSMutableArray alloc] initWithArray:[[_foodDictionary valueForKey:@"main_lunch"] componentsSeparatedByString:@","]];

        for (NSString *anyFood in lunchList)
        {
            lunch = [self clearCharactersInString:anyFood];
            UILabel *lunchLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, yOffset, _lunchContainer.frame.size.width, 20)];
            lunchLabel.text = lunch;
            [lunchLabel setFont:labelFont14pt];
            [_lunchContainer addSubview:lunchLabel];
            yOffset += 15;
            
        }
        
        NSMutableArray *altLunchList = [[NSMutableArray alloc] initWithArray:[[_foodDictionary valueForKey:@"alt_lunch"] componentsSeparatedByString:@","]];
        
        for (NSString *anyFood in altLunchList)
        {
            lunch = [self clearCharactersInString:anyFood];
            if ([lunch rangeOfString:@"Vjt"].location == NSNotFound) {
                UILabel *lunchLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, yOffset, _lunchContainer.frame.size.width, 20)];
                lunchLabel.text = lunch;
                [lunchLabel setFont:labelFont14pt];
                [_lunchContainer addSubview:lunchLabel];
                yOffset += 15;
            }
            
        }
    }
    else
    {
        UILabel *noFoodLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, yOffset, _lunchContainer.frame.size.width, 20)];
        noFoodLabel.text = @"Bugün için öğle yemeği malesef yok.";
        [noFoodLabel setFont:labelFont14pt];
        [_lunchContainer addSubview:noFoodLabel];
    }

    
    yOffset = 0;
    
    if ([[_foodDictionary valueForKey:@"main_dinner"] length])
    {
        NSMutableArray *dinnerList = [[NSMutableArray alloc] initWithArray:[[_foodDictionary valueForKey:@"main_dinner"] componentsSeparatedByString:@","]];
        
        for (NSString *anyFood in dinnerList)
        {
            lunch = [self clearCharactersInString:anyFood];
            UILabel *dinnerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, yOffset, _dinnerContainer.frame.size.width, 20)];
            dinnerLabel.text = lunch;
            [dinnerLabel setFont:labelFont14pt];
            [_dinnerContainer addSubview:dinnerLabel];
            yOffset += 15;
            
        }
        
        NSMutableArray *altDinnerList = [[NSMutableArray alloc] initWithArray:[[_foodDictionary valueForKey:@"alt_dinner"] componentsSeparatedByString:@","]];
        
        for (NSString *anyFood in altDinnerList)
        {
            lunch = [self clearCharactersInString:anyFood];
            UILabel *dinnerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, yOffset, _dinnerContainer.frame.size.width, 20)];
            dinnerLabel.text = lunch;
            [dinnerLabel setFont:labelFont14pt];
            [_dinnerContainer addSubview:dinnerLabel];
            yOffset += 15;
            
        }
    }
    else
    {

        UILabel *noFoodLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, yOffset, _dinnerContainer.frame.size.width, 20)];
        noFoodLabel.text = @"Bugün için akşam yemeği malesef yok.";
        [noFoodLabel setFont:labelFont14pt];
        [_dinnerContainer addSubview:noFoodLabel];
    }
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
