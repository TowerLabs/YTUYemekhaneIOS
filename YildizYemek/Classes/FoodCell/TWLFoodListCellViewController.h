//
//  TWLFoodListCellViewController.h
//  YildizYemek
//
//  Created by Said on 07/01/2015.
//  Copyright (c) 2015 Tower Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWLFoodListCellViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (assign, nonatomic) NSInteger index;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (instancetype)initWithData: (NSDictionary *)foodData;
@end
