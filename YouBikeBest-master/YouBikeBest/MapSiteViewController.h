//
//  MapSiteViewController.h
//  YouBiker
//
//  Created by David Tseng on 13/8/8.
//  Copyright (c) 2013年 injay. All rights reserved.
//
#import "Site.h"

typedef void (^SelectSiteBlock)(Site*);

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapSiteViewController : UIViewController<MKMapViewDelegate>

@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) SelectSiteBlock selectBlock;


@end
