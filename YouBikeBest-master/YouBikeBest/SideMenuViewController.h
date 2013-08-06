//
//  SideMenuViewController.h
//  YouBikeBest
//
//  Created by injay on 13/5/13.
//  Copyright (c) 2013年 injay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface SideMenuViewController : UIViewController
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIButton *btnListView;
@property (strong, nonatomic) IBOutlet UIButton *btnSearch;
@property (strong, nonatomic) IBOutlet UIButton *btnMap;
@property (strong, nonatomic) IBOutlet UIButton *btnSettings;


@end
