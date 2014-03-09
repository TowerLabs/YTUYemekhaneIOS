//
//  TLAboutViewController.m
//  YTUYemekhaneIOS
//
//  Created by Davut Ucar on 6.03.2014.
//  Copyright (c) 2014 TowerLabs. All rights reserved.
//

#import "TLAboutViewController.h"
#import "TLAboutCellViewController.h"

@interface TLAboutViewController ()

@property (nonatomic, strong) NSMutableArray *teamAboutArray;
@property (nonatomic, strong) NSString *pathForPlist;

@end

@implementation TLAboutViewController

#pragma mark -LifeCycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self getTeamInfo];
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
