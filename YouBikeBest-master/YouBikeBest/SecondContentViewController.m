//
//  SecondContentViewController.m
//  YouBikeBest
//
//  Created by injay on 13/5/15.
//  Copyright (c) 2013年 injay. All rights reserved.
//

#import "SecondContentViewController.h"

@interface SecondContentViewController ()

@end

@implementation SecondContentViewController

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
	// Do any additional setup after loading the view.
    CGRect frameimg = CGRectMake(0, 100, 50, 30);
    UIButton *backButton = [[UIButton alloc] initWithFrame:frameimg];
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    
    
}


-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
    [self.naviTitle setText:@""];
    self.naviTitle = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
