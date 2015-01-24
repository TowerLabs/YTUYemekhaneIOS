/*
 TWLDataManager.m
 YildizYemek
 
 Created by Said on 08/01/2015.
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


#import "TWLDataManager.h"
#import "AFNetworking.h"
#import "SBJson.h"

@interface TWLDataManager()
@property (nonatomic, strong) NSMutableArray *foodList;
@end

@implementation TWLDataManager

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.foodList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)getFoodListWithCallback: (void (^)(NSMutableArray *foodList, NSError *error))completionBlock
{
    NSString *foodListJSON = [[NSUserDefaults standardUserDefaults] objectForKey:@"foodList"];
    if (nil != foodListJSON)
    {
        self.foodList = [foodListJSON JSONValue];
        if ([TWLDataManager validateData:_foodList])
        {
            if (completionBlock)
            {
                completionBlock(self.foodList, nil);
            }
        }
        else
        {
            [self retrieveDataFromAPIWithCompletion:^(NSError *error) {
                if (completionBlock)
                {
                    completionBlock(_foodList, error);
                }
            }];
        }
    }
    else
    {
        [self retrieveDataFromAPIWithCompletion:^(NSError *error) {
            if (completionBlock)
            {
                completionBlock(_foodList, error);
            }
        }];
    }
}

+ (BOOL)validateData: (NSArray *)data
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:[NSDate date]];
    NSInteger currentMonth = [components month];
    
    if (currentMonth == [[[[[[data objectAtIndex:0] allKeys]objectAtIndex:0]componentsSeparatedByString:@"."]objectAtIndex:1]integerValue])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (void)retrieveDataFromAPIWithCompletion: (void (^)(NSError *error))completionBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *pathForPlist = [[NSBundle mainBundle] pathForResource:@"api" ofType:@"plist"];
    NSMutableDictionary *apiDict = [[NSMutableDictionary alloc] initWithContentsOfFile:pathForPlist];
    NSString *apiUrl = [[NSString alloc] initWithString:[apiDict valueForKey:@"apiUrl"]];
    
    [manager GET:apiUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        self.foodList = [[NSMutableArray alloc] initWithArray:[[operation responseString] JSONValue]];
        
        [[NSUserDefaults standardUserDefaults] setObject:[operation responseString] forKey:@"foodList"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        if (completionBlock)
        {
            completionBlock(nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
         self.foodList = nil;
         if (completionBlock)
         {
             completionBlock(error);
         }
     }];
}

- (void)refreshData: (void (^)(NSMutableArray *foodList, NSError *error))completionBlock
{
    [self retrieveDataFromAPIWithCompletion:^(NSError *error) {
        if (completionBlock)
        {
            completionBlock(_foodList, error);
        }
    }];
}
@end