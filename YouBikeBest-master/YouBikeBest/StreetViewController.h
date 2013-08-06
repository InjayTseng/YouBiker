//
//  StreetViewController.h
//  YouBiker
//
//  Created by David Tseng on 6/7/13.
//  Copyright (c) 2013 injay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Site.h"
#import "SecondContentViewController.h"
@interface StreetViewController : SecondContentViewController
@property (strong, nonatomic) IBOutlet UIWebView *wbView;
@property (strong, nonatomic) Site *site;

@end
