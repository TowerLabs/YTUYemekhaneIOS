//
//  Food.h
//  YildizYemek
//
//  Created by Said on 20/01/2015.
//  Copyright (c) 2015 Tower Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWLFood : NSObject
//Properties
@property (strong, nonatomic, readonly) NSDate *foodDate;
@property (strong, nonatomic, readonly) NSString *lunchString;
@property (strong, nonatomic, readonly) NSString *dinnerString;

//Initializers
- (id)initWithFoodDictionary: (NSDictionary *)foodDictionary;

//Other methods
- (NSString *)getFormattedFoodDate;
@end
