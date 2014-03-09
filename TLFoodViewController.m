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
@interface TLFoodViewController ()

@property (nonatomic,strong) NSMutableArray *foodArray;
@property (nonatomic,strong) NSMutableDictionary *todaysFood;
@property (nonatomic,strong) NSDateComponents *dateComponents;
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
    
    [self loadData];
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
- (void)loadData
{
    [self.todaysFoodViewContainer addSubview:self.todaysFoodView];
    
    [self checkDateDataReceived];
}

- (void)checkDateDataReceived
{
    NSDate *dataLastReceived   = [[NSUserDefaults standardUserDefaults] objectForKey:@"dataLastReceived"];
    
    if (nil == dataLastReceived)
    {
        NSLog(@"Daha once hic yazilmamis nsuser a simdi cekilip yazilcak");
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
    NSLog(@"Data: %@",[jsonResponse JSONValue]);
//    self.foodArray = [[NSMutableArray alloc]initWithArray:[jsonResponse JSONValue]];
}

@end
