/*
 TLAboutViewController.m
 YTUYemekhaneIOS
 Copyright (C) 2014 TowerLabs
 
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

#import "TLAboutViewController.h"
#import "TLAboutCellViewController.h"

@interface TLAboutViewController ()

@property (nonatomic, strong) NSMutableArray *teamAboutArray;
@property (nonatomic, strong) NSString *pathForPlist;

@end

@implementation TLAboutViewController

#pragma mark -LifeCycle
- (id)initWithNibByDevice
{
    if ([[UIScreen mainScreen] bounds].size.height > 480.0f) // retina 4"
    {
        self = [super initWithNibName:@"TLAboutViewController_4" bundle:nil];
    }
    else // retina 3.5"
    {
        self = [super initWithNibName:@"TLAboutViewController_3" bundle:nil];
    }
    
    if (self)
    {
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getTeamInfo];

}

- (void)viewDidAppear:(BOOL)animated
{
    self.navigationController.navigationBar.topItem.title = @"Hakkımızda";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Creation of Child View Controller
- (void)getTeamInfo
{
    self.pathForPlist = [[NSBundle mainBundle] pathForResource:@"TeamAboutList" ofType:@"plist"];
    self.teamAboutArray = [[NSMutableArray alloc] initWithContentsOfFile:_pathForPlist];
    
    NSLog(@"Path: %@",_pathForPlist);
    
    [self setDeveloperInfo];
}

- (void)setDeveloperInfo
{
    int startX = 0;
    int startY = 0;
    int currentX = startX;
    int currentY = startY;
    
    for (int i=0; i<_teamAboutArray.count; i++)
    {
        
        TLAboutCellViewController *aboutCellViewController = [[TLAboutCellViewController alloc] initWithDeveloperInfo:[_teamAboutArray objectAtIndex:i]];

        //Bu satir candir, kandir. ARC projede VC icinde VC kullanip yapmazsaniz, her actionda BAD ACCESS'le patlarsiniz
        [self addChildViewController:aboutCellViewController];
            
        [aboutCellViewController.view setFrame:CGRectMake(currentX, currentY, aboutCellViewController.view.frame.size.width, aboutCellViewController.view.frame.size.height)];
            
        currentY += aboutCellViewController.view.frame.size.height + 5;
    
        [self.teamListContainerView addSubview:aboutCellViewController.view];
    }

}



@end
