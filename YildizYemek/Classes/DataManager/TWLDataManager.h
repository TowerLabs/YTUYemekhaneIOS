//
//  TWLDataManager.h
//  YildizYemek
//
//  Created by Said on 08/01/2015.
//  Copyright (c) 2015 Tower Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWLDataManager : NSObject
- (void)getFoodListWithCallback: (void (^)(NSMutableArray *foodList, NSError *error))completionBlock;
- (void)refreshData: (void (^)(NSMutableArray *foodList, NSError *error))completionBlock;
+ (BOOL)validateData: (NSArray*)data;
@end
