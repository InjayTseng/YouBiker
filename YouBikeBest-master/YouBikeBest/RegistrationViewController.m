//
//  RegistrationViewController.m
//  YouBiker
//
//  Created by injay on 13/6/21.
//  Copyright (c) 2013年 injay. All rights reserved.
//

#import "RegistrationViewController.h"

@interface RegistrationViewController ()

@end

@implementation RegistrationViewController
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
    NSString *urlText = @"https://www.youbike.com.tw/user/member_regist02.php";
    [self.wbView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlText]]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
