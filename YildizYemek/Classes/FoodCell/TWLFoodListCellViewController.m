//
//  TWLFoodListCellViewController.m
//  YildizYemek
//
//  Created by Said on 07/01/2015.
//  Copyright (c) 2015 Tower Labs. All rights reserved.
//

#import "TWLFoodListCellViewController.h"
#import "TWLFood.h"

@interface TWLFoodListCellViewController ()
@property (nonatomic, strong) TWLFood *foodData;
@end

@implementation TWLFoodListCellViewController
- (instancetype)initWithData: (TWLFood *)foodData
{
    self = [super initWithNibName:@"TWLFoodListCellViewController" bundle:nil];
    if (self)
    {
        self.foodData = foodData;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dateLabel.text = [_foodData getFormattedFoodDate];
    self.dateLabel.font = [UIFont fontWithName:@"Lato-Medium" size:14.0f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return [[[_foodData lunchString] componentsSeparatedByString:@"\n"] count];
    }
    else
    {
        return [[[_foodData dinnerString] componentsSeparatedByString:@"\n"] count];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FoodCell"];
    if (nil == cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FoodCell"];
    }
    NSString *cellText = @"";
    if (indexPath.section == 0)
    {
        cellText = [[[_foodData lunchString] componentsSeparatedByString:@"\n"] objectAtIndex:indexPath.row];
        if ([cellText isEqualToString:@""])
        {
            cellText = @"Bugün için öğle yemeği menüsü malesef yok.";
        }
    }
    else
    {
        cellText = [[[_foodData dinnerString] componentsSeparatedByString:@"\n"] objectAtIndex:indexPath.row];
        if ([cellText isEqualToString:@""])
        {
            cellText = @"Akşam yemeği menüsü bulunamadı.";
        }
    }
    cell.textLabel.text = cellText;
    cell.textLabel.font = [UIFont fontWithName:@"Lato-Light" size:14.0f];

    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NSString *sectionTitle = @"";
    
    if (section == 0 )
    {
        sectionTitle = @"Öğle Yemeği";
    }
    else
    {
        sectionTitle = @"Akşam Yemeği";
    }
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, 250, 23);
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.font = [UIFont fontWithName:@"Lato-Bold" size:14];
    label.text = sectionTitle;
    label.backgroundColor = [UIColor clearColor];
    
    // Create header view and add label as a subview
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    [view addSubview:label];
    
    return view;
}
@end
