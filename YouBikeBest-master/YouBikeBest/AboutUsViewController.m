//
//  AboutUsViewController.m
//  YouBikeBest
//
//  Created by injay on 13/5/15.
//  Copyright (c) 2013年 injay. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

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
    NSString *urlText = @"http://4tyone.blogspot.tw/search/label/YouBike";
    [self.wbView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlText]]];
     
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
