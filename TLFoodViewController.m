//
//  TLFoodViewController.m
//  YTUYemekhaneIOS
//
//  Created by Davut Ucar on 6.03.2014.
//  Copyright (c) 2014 TowerLabs. All rights reserved.
//

#import "TLFoodViewController.h"
#import "AFNetworking.h"
#import "SBJson.h"
#import "TLFoodCellViewController.h"

@interface TLFoodViewController ()

@property (nonatomic,strong) NSMutableArray *foodArray;
@property (nonatomic,strong) NSMutableDictionary *todaysFood;
@property (nonatomic,strong) NSDateComponents *dateComponents;
@property (nonatomic,strong) NSString *todaysDate;
@property NSInteger day;

@end

@implementation TLFoodViewController

#pragma mark - LifeCycle
#warning TODO: Specify init method for iPhone 4/4S & 5/5S

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
    self.dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    self.day = [_dateComponents day];
    
    for (UILabel *label in [self.view subviews])
    {
        if ([label isKindOfClass:[UILabel class]])
        {
            [label setFont:DELEGATE.projectFont];
        }
    }
    
    [self loadDataWithDate:_todaysDate];
}

- (void)viewDidAppear:(BOOL)animated
{
    self.navigationController.navigationBar.topItem.title = @"Yemek Listesi";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Loading Data
- (void)loadDataWithDate:(NSString*)today
{
    
    [self checkDateDataReceived];
}

- (void)checkDateDataReceived
{
    NSDate *dataLastReceived   = [[NSUserDefaults standardUserDefaults] objectForKey:@"dataLastReceived"];
    
    if (nil == dataLastReceived)
    {
        NSLog(@"Daha once hic yazilmamis");
        [self retrieveDataFromAPI];
    }
    else
    {
        if(1 == _day)
        {
            NSLog(@"Sifirdan cekiyorum");
            
            [self retrieveDataFromAPI];
        }
        else
        {
            NSLog(@"Sifirdan cekmeme gerek yok");
            
            NSString *APIData = [[NSUserDefaults standardUserDefaults] valueForKey:@"APIData"];
            
            [self parseJson:APIData];
        }
    }
}



#pragma mark - Client Methods

-(void)retrieveDataFromAPI
{
    //request atmadan once burada loading gif konulabilir.
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    NSString *pathForPlist = [[NSBundle mainBundle] pathForResource:@"Api" ofType:@"plist"];
    NSMutableDictionary *apiDict = [[NSMutableDictionary alloc] initWithContentsOfFile:pathForPlist];
    NSString *apiUrl = [[NSString alloc] initWithString:[apiDict valueForKey:@"apiUrl"]];
    
    [manager GET:apiUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"dataLastReceived"];
        [[NSUserDefaults standardUserDefaults] setValue:[operation responseString] forKey:@"APIData"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self parseJson:[operation responseString]];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        NSLog(@"Error: %@", error);
    }];
}

-(void)parseJson:( NSString*) jsonResponse
{
//    NSLog(@"Data: %@",[jsonResponse JSONValue]);
    self.foodArray = [[NSMutableArray alloc]initWithArray:[jsonResponse JSONValue]];
    
    NSDate *currDate = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"dd.MM.YYYY"];
    
    NSString *today = [dateFormatter stringFromDate:currDate];

    int keyOfToday;
    
    for (int i=0; i<_foodArray.count; i++)
    {
        if ([[[[_foodArray objectAtIndex:i] allKeys]objectAtIndex:0]isEqualToString:today])
        {
            keyOfToday = i;
        }
    }
    NSInteger end;
    
    if(_foodArray.count <= keyOfToday+10 )
    {
        end = _foodArray.count-1;
    }
    else
    {
        end = keyOfToday + 10;
    }
    
    NSLog(@"%d-%ld",keyOfToday,(long)end);
    
    int startX= 0;
    int startY= 0;
    int currentX = startX;
    
    for (int i=keyOfToday; i<end; i++)
    {
        
        TLFoodCellViewController *foodCellViewController = [[TLFoodCellViewController alloc] initWithFoodDictionary:[[[_foodArray objectAtIndex:i] allValues] objectAtIndex:0]];
        
        [foodCellViewController.view setFrame:CGRectMake(currentX, startY, foodCellViewController.view.frame.size.width, foodCellViewController.view.frame.size.height)];
        [_scrollView addSubview:foodCellViewController.view];
//        NSLog(@"CurrentX: %d StartY: %d StartX: %d FWidth: %f FHeight: %f SWidth: %f SHeight: %f",currentX, startY, startX, foodCellViewController.view.frame.size.width, foodCellViewController.view.frame.size.height,_scrollView.frame.size.width,_scrollView.frame.size.height);
        
        currentX += foodCellViewController.view.frame.size.width;
    }
    
    [_scrollView setContentSize:CGSizeMake(3200,_scrollView.contentSize.height)];
}

#pragma  mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    NSLog(@"scroll");
    //Scroll işlemi bittiğinde içeriğin x koordinatı
    int xCoordinate = scrollView.contentOffset.x;
//    NSLog(@"X Coord: %d",xCoordinate);
    
    //x koordinatı / 320 bize index numarasını verecektir.
    int pageNumber = (xCoordinate / (_scrollView.frame.size.width));
//    NSLog(@"Page Number: %d",pageNumber);
    
    self.pageControl.currentPage = pageNumber;
}

@end
