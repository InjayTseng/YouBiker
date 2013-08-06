//
//  ContentViewBasicController.m
//  YouBikeBest
//
//  Created by injay on 13/5/14.
//  Copyright (c) 2013年 injay. All rights reserved.
//

#import "ContentViewBasicController.h"
#import "SWRevealViewController.h"
@interface ContentViewBasicController ()

@property (strong, nonatomic) UIButton *btnSideBar;


@end

@implementation ContentViewBasicController

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
    
    CGRect frameimg = CGRectMake(100, 100,50, 30);
    
    UIImage* image3 = [UIImage imageNamed:@"sideBarMenu4.png"];
    self.btnSideBar = [[UIButton alloc] initWithFrame:frameimg];
    [self.btnSideBar  setBackgroundImage:image3 forState:UIControlStateNormal];
    [self.btnSideBar  addTarget:self.revealViewController action:@selector(revealToggle:)
               forControlEvents:UIControlEventTouchUpInside];
    [self.btnSideBar  setShowsTouchWhenHighlighted:YES];
    UIBarButtonItem *listBtn =[[UIBarButtonItem alloc] initWithCustomView:self.btnSideBar];
    self.navigationItem.leftBarButtonItem= listBtn;
    
    [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    


    
	// Do any additional setup after loading the view.
}

-(void)setCustomTitleAs:(NSString*)title{
    CGRect frame = CGRectMake(0, 50, [self.title sizeWithFont:[UIFont fontWithName:@"STHeitiSC-Light" size:22.]].width, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];\
    label.textColor = [UIColor darkGrayColor];
    label.font = [UIFont fontWithName:@"STHeitiSC-Light" size:22.];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    label.text = title;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addGestureRecognizerOn:(id)anyObject{

    [anyObject addGestureRecognizer: self.revealViewController.panGestureRecognizer];
}

@end
