/*
 TLFoodViewController.m
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

- (id)initWithNibByDevice
{
    if ([[UIScreen mainScreen] bounds].size.height > 480.0f) // retina 4"
    {
        self = [super initWithNibName:@"TLFoodViewController_4" bundle:nil];
    }
    else // retina 3.5"
    {
        self = [super initWithNibName:@"TLFoodViewController_3" bundle:nil];
    }

    if (self)
    {

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
        if(1 == _day || 2 == _day)
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

    NSString *pathForPlist = [[NSBundle mainBundle] pathForResource:@"api" ofType:@"plist"];
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
        [self operationErrorWithCode:error.code];
    }];
}

- (void)operationErrorWithCode: (NSInteger)errorCode
{
    [_loadingIndicator stopAnimating];
    
    if (errorCode == -1009 || errorCode == -1007 || errorCode == -1004)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Bağlanılamıyor" message:@"Yemek listesini görüntüleyebilmek için lütfen internet bağlantınızı kontrol edin." delegate:nil cancelButtonTitle:@"Tamam" otherButtonTitles: nil];
        [alert show];
        
    }
    else if (errorCode == -1001)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sunucuya erişim sağlanamıyor" message:@"Lütfen daha sonra tekrar deneyin." delegate:nil cancelButtonTitle:@"Tamam" otherButtonTitles: nil];
        [alert show];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sunucu hatası" message:@"Lütfen daha sonra tekrar deneyin." delegate:nil cancelButtonTitle:@"Tamam" otherButtonTitles: nil];
        [alert show];
    }

}

-(void)parseJson:( NSString*) jsonResponse
{
//    NSLog(@"Data: %@",[jsonResponse JSONValue]);
    self.foodArray = [[NSMutableArray alloc]initWithArray:[jsonResponse JSONValue]];


    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:[NSDate date]];
    NSInteger curMonth = [components month];
   
    if (curMonth == [[[[[[self.foodArray objectAtIndex:0] allKeys]objectAtIndex:0]componentsSeparatedByString:@"."]objectAtIndex:1]integerValue]){
        
        int keyOfToday = [self getKeyOfToday];
        
        if ( -1 == keyOfToday)
        {
            [self printErrorView:@"Bu ay için görüntülenecek yemek menüsü kalmadı."];
        }
        else
        {
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
            _pageControl.numberOfPages = end - keyOfToday +1;
            int startX= 0;
            int startY= 0;
            int currentX = startX;
            
            [_loadingIndicator stopAnimating];
            
            for (int i=keyOfToday; i<=end; i++)
            {
                
                TLFoodCellViewController *foodCellViewController = [[TLFoodCellViewController alloc] initWithFoodDictionary:[[[_foodArray objectAtIndex:i] allValues] objectAtIndex:0] Date:[[[_foodArray objectAtIndex:i] allKeys]objectAtIndex:0]];
                
                [foodCellViewController.view setFrame:CGRectMake(currentX, startY, foodCellViewController.view.frame.size.width, foodCellViewController.view.frame.size.height)];
                [_scrollView addSubview:foodCellViewController.view];
                //        NSLog(@"CurrentX: %d StartY: %d StartX: %d FWidth: %f FHeight: %f SWidth: %f SHeight: %f",currentX, startY, startX, foodCellViewController.view.frame.size.width, foodCellViewController.view.frame.size.height,_scrollView.frame.size.width,_scrollView.frame.size.height);
                
                currentX += foodCellViewController.view.frame.size.width;
            }
            
            [_scrollView setContentSize:CGSizeMake(320 * (_pageControl.numberOfPages),_scrollView.contentSize.height)];
        }
    }
    else
    {
        [self printErrorView:@"Güncel yemek menüsü sks.yildiz.edu.tr adresinde henüz yayınlanmadı."];
    }

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
- (int)getKeyOfToday{
    NSString *dateKey = @"";
    NSArray *key = [[NSArray alloc]init];
    NSInteger tempDay;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:[NSDate date]];
    NSInteger today = [components day];
    for (int i=0; i<_foodArray.count; i++)
    {
        dateKey = [[[_foodArray objectAtIndex:i] allKeys]objectAtIndex:0];
        key = [dateKey componentsSeparatedByString:@"."];
        tempDay = [[key objectAtIndex:0]integerValue];
        if (tempDay >= today) {
            return i;
        }
    }
    return -1;
}
-(void)printErrorView: (NSString*) message
{
    [_loadingIndicator stopAnimating];
    _pageControl.numberOfPages = 0;
    
    UILabel * dontHaveCurrentMenuLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 100, 280, 200)];
    dontHaveCurrentMenuLabel.backgroundColor = [UIColor whiteColor];
    dontHaveCurrentMenuLabel.text = message;
    dontHaveCurrentMenuLabel.font= DELEGATE.projectFont;
    dontHaveCurrentMenuLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.view addSubview:dontHaveCurrentMenuLabel];
    dontHaveCurrentMenuLabel.numberOfLines = 3;
    dontHaveCurrentMenuLabel.textAlignment = NSTextAlignmentCenter;
    
}
@end