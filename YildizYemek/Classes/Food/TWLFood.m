/*
 TWLFood.m
 YildizYemek
 
 Created by Said on 20/01/2015.
 Copyright (c) 2014 Tower Labs. All rights reserved.
 
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

#import "TWLFood.h"
@interface TWLFood()
@property (strong, nonatomic) NSDictionary *foodDictionary;
@property (strong, readwrite, nonatomic) NSDate *foodDate;
@property (strong, readwrite, nonatomic) NSString *lunchString;
@property (strong, readwrite, nonatomic) NSString *dinnerString;
@end

@implementation TWLFood
#pragma mark - Lifecycle
- (id)init
{
    self = [self initWithFoodDictionary:nil];
    return self;
}
- (id)initWithFoodDictionary: (NSDictionary *)foodDictionary
{
    self = [super init];
    if (self)
    {
        if (foodDictionary)
        {
            self.foodDictionary = foodDictionary;
            self.foodDate = nil;
            self.lunchString = [[NSString alloc] init];
            self.dinnerString = [[NSString alloc] init];;
            [self processData];
        }
        else
        {
            [NSException raise:@"Invalid parameter." format:@"Invalid parameter, foodDictionary:%@", foodDictionary];
        }
    }
    return self;
}
#pragma mark - Helpers
- (void)processData
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM.yyyy"];
    NSString *cellDateString = [[_foodDictionary allKeys] objectAtIndex:0];
    self.foodDate = [dateFormatter dateFromString:cellDateString];
    
    NSDictionary *foodValuesOfOneDay = [[_foodDictionary allValues]objectAtIndex:0];

    if ([[foodValuesOfOneDay valueForKey:@"main_lunch"] length])
    {
        _lunchString = [_lunchString stringByAppendingFormat:@"%@",[foodValuesOfOneDay valueForKey:@"main_lunch"]];
        NSMutableArray *altLunchList = [[NSMutableArray alloc] initWithArray:[[foodValuesOfOneDay valueForKey:@"alt_lunch"] componentsSeparatedByString:@","]];

        for (NSString *anyFood in altLunchList)
        {
            if ([anyFood rangeOfString:@"VJT."].location == NSNotFound)
            {
                _lunchString = [_lunchString stringByAppendingFormat:@",%@",anyFood];
            }
        }
        _lunchString = [self clearCharactersInString:_lunchString];
        _lunchString = [_lunchString stringByReplacingOccurrencesOfString:@"," withString:@"\n"];
    }
    
    if ([[foodValuesOfOneDay valueForKey:@"main_dinner"] length])
    {
        _dinnerString = [_dinnerString stringByAppendingFormat:@"%@,%@",[foodValuesOfOneDay valueForKey:@"main_dinner"],[foodValuesOfOneDay valueForKey:@"alt_dinner"]];
        _dinnerString = [self clearCharactersInString:_dinnerString];
        _dinnerString = [_dinnerString stringByReplacingOccurrencesOfString:@"," withString:@"\n"];
    }
}

- (NSString *)clearCharactersInString: (NSString *)dirtyString
{
    NSString *clearString = @"";
    clearString = [dirtyString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    clearString = [clearString stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    clearString = [clearString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    clearString = [clearString stringByReplacingOccurrencesOfString:@"&#13;" withString:@""];
    clearString = [clearString capitalizedStringWithLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"tr"]];
    return clearString;
}

#pragma mark - Getters
- (NSString *)getFormattedFoodDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"tr_TR"]];
    [dateFormatter setDateFormat:@"dd MMMM EEEE"];
    return [dateFormatter stringFromDate:_foodDate];
}
@end