//
//  TimerViewController.m
//  YouBikeBest
//
//  Created by injay on 13/6/4.
//  Copyright (c) 2013年 injay. All rights reserved.
//

#import "TimerViewController.h"
#import "DataManager.h"
#import "DTTimer.h"
#import "DTTime.h"
#import "DTLocalNotification.h"

@interface TimerViewController ()
@property (strong, nonatomic) IBOutlet UILabel *lbTime;
- (IBAction)btnStartClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnStart;

@end

@implementation TimerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.trackedViewName = @"TimerView";
    [self updateText];
    
    //DTTimer *timer = [[DataManager shareInstance] timer];
    
    self.notifArray = [DTLocalNotification getAllNotifications];
    
    if (self.notifArray!=nil && [self.notifArray count]>0) {
        [self.btnStart setTitle:@"STOP" forState:UIControlStateNormal];
        [self.btnStart setBackgroundColor:[UIColor colorWithRed:255./255. green:60./255. blue:74./255. alpha:1.]];
    }
    
    self.notifArray =  [DTLocalNotification getAllNotifications];
    [self.tbView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.trackedViewName = @"TimerPage";
	// Do any additional setup after loading the view.
    self.xtimer = [NSTimer scheduledTimerWithTimeInterval: 1.
                                                   target: self
                                                 selector: @selector(updateText)
                                                 userInfo: nil
                                                  repeats: YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnStartClicked:(id)sender {
    DTTimer *timer = [[DataManager shareInstance] timer];
    //if ([self.btnStart.titleLabel.text isEqualToString:@"STOP"]) {
    if ([timer isCounting]) {
        
        [timer stop];
        [timer clear];
        [self cancelAll];
        [self.btnStart setTitle:@"開始" forState:UIControlStateNormal];
        [self.btnStart setBackgroundColor:[UIColor colorWithRed:0./255. green:128./255. blue:64./255. alpha:1.]];
        
        
    }else{
        
        [timer start];

        [self startSchedule];
        [self.btnStart setTitle:@"STOP" forState:UIControlStateNormal];
        [self.btnStart setBackgroundColor:[UIColor colorWithRed:255./255. green:60./255. blue:74./255. alpha:1.]];
    }
    

}


-(void)updateText{

    [self.lbTime setText:[[[DataManager shareInstance] timer] currentTime] ];
}

-(void)startSchedule{


    [DTLocalNotification cancelAllNotifications];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"MM-dd-yyyy HH:mm"];
	[formatter setTimeZone:[NSTimeZone systemTimeZone]];
    
    NSArray *array = [DTTime createTimeAfterNowInEach:30 andNumberOfTimes:25 andOffsetBy:-5];
    for (int i=1;i<=[array count];i++){
        NSDate *notifDate = [array objectAtIndex:i-1];
        NSString *strTime = [formatter stringFromDate:notifDate];
        [DTLocalNotification createNotification:strTime withText:[NSString stringWithFormat:@"再五分鐘就要付 %d 元了喔!",i*10]];
    }
    
    [DTLocalNotification logAllNotifications];
    self.notifArray =  [DTLocalNotification getAllNotifications];
    [self.tbView reloadData];
    
    
}

-(void)cancelAll{

    [DTLocalNotification cancelAllNotifications];
    self.notifArray =  [DTLocalNotification getAllNotifications];
    [self.tbView reloadData];
    NSLog(@"%@",self.notifArray);
}

#pragma mark - Table View


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.notifArray count];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 44.;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault   reuseIdentifier:CellIdentifier];
    
    }
    //NSDate *notifDate = [array objectAtIndex:i];
    
    UILocalNotification *loc  = [self.notifArray objectAtIndex:indexPath.row];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"MM/dd HH:mm a"];
	[formatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSString *strDate = [formatter stringFromDate:loc.fireDate];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",strDate];
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return NO;
}




@end
