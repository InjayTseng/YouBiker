//
//  MapViewController.h
//  YouBikeBest
//
//  Created by injay on 13/5/14.
//  Copyright (c) 2013年 injay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "SecondContentViewController.h"

@interface MapViewController : SecondContentViewController <MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIButton *btnSelect;

@property (readwrite, nonatomic) CLLocationCoordinate2D startLoc;
@property (readwrite, nonatomic) CLLocationCoordinate2D endLoc;

@property (strong, nonatomic) IBOutlet UIButton *btnStart;
-(void)changeStartName:(NSString*)stringForTitle;

@end
