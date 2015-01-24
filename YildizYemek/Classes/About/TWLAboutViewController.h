//
//  SecondViewController.h
//  YildizYemek
//
//  Created by Said on 08/01/2015.
//  Copyright (c) 2015 Tower Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWLAboutViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *aboutTableView;
@end