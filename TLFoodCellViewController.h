//
//  TLFoodCellViewController.h
//  YTUYemekhaneIOS
//
//  Created by Davut Ucar on 6.03.2014.
//  Copyright (c) 2014 TowerLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLFoodCellViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lunchTitle;
@property (weak, nonatomic) IBOutlet UIView *lunchContainer;

@property (weak, nonatomic) IBOutlet UILabel *dinnerTitle;
@property (weak, nonatomic) IBOutlet UIView *dinnerContainer;

- (id)initWithFoodDictionary:(NSDictionary *)foodDictionary;

@end
