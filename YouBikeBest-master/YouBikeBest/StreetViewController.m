//
//  StreetViewController.m
//  YouBiker
//
//  Created by David Tseng on 6/7/13.
//  Copyright (c) 2013 injay. All rights reserved.
//

#import "StreetViewController.h"

@interface StreetViewController ()

@end

@implementation StreetViewController

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
    NSString *htmlString = [NSString stringWithFormat:@"<html>\
                            <head>\
                            <meta id=\"viewport\" name=\"viewport\" content=\"width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;\">\
                            <script src='http://maps.google.com/maps/api/js?sensor=false' type='text/javascript'></script>\
                            </head>\
                            <body onload=\"new google.maps.StreetViewPanorama(document.getElementById('p'),{position:new google.maps.LatLng(%@, %@)});\" style='padding:0px;margin:0px;'>\
                            <div id='p' style='height:460;width:320;'></div>\
                            </body>\
                            </html>",self.site.lat,self.site.lng];
    
    [self.wbView loadHTMLString:htmlString baseURL:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
