/*
 TWLAboutViewController.m
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

#import "TWLAboutViewController.h"
#import "TWLWebViewController.h"
#import "TWLAboutCell.h"

@interface TWLAboutViewController ()
@property (nonatomic, strong) NSMutableArray *teamAboutArray;
@end

@implementation TWLAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.aboutTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self getTeamInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Creation of Child View Controller
- (void)getTeamInfo
{
    NSString *pathForPlist = [[NSBundle mainBundle] pathForResource:@"TeamAboutList" ofType:@"plist"];
    self.teamAboutArray = [[NSMutableArray alloc] initWithContentsOfFile:pathForPlist];
    
    [self.aboutTableView reloadData];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.teamAboutArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TWLAboutCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AboutTableViewCell"];
    if (nil == cell)
    {
        cell = [[TWLAboutCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AboutTableViewCell"];
    }
    
    cell.twitterButton.tag = indexPath.section;

    cell.nameLabel.text = [[self.teamAboutArray objectAtIndex:indexPath.section] valueForKey:@"name"];
    [cell.twitterButton setTitle:[[self.teamAboutArray objectAtIndex:indexPath.section] valueForKey:@"twitter"] forState:UIControlStateNormal];
    cell.authorImage.image = [UIImage imageNamed:[[self.teamAboutArray objectAtIndex:indexPath.section] valueForKey:@"image"]];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}
- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 22)];
    [headerView setBackgroundColor:[UIColor colorWithRed:245.0/255.0 green:242.0/255.0 blue:238.0/255.0 alpha:1.0]];
    
    return headerView;
}

#pragma mark - 
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"link"])
    {
        TWLWebViewController *webViewController = (TWLWebViewController *)segue.destinationViewController;
        NSInteger tagIndex = [(UIButton *)sender tag];
        NSString *link = [[_teamAboutArray objectAtIndex:tagIndex] valueForKey:@"link"];
        webViewController.link = [NSURL URLWithString:link];
    }
    
}
@end
