//
//  DetailViewController.h
//  YouBikeBest
//
//  Created by injay on 13/5/8.
//  Copyright (c) 2013年 injay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Site.h"
#import "GAI.h"
@interface DetailViewController : GAITrackedViewController<UIScrollViewDelegate>

@property (nonatomic, retain) IBOutlet MKMapView *mapView;
-(void)goLocation:(double)lat andLon:(double)lon withName:(NSString*)name;
-(void)setTitleName:(NSString*)name;

@property (strong, nonatomic) IBOutlet UILabel *lbCanRent;
@property (strong, nonatomic) IBOutlet UILabel *lbCanPark;
@property (strong, nonatomic) UILabel *naviTitle;
@property (strong, nonatomic) Site *currentSite;

@property (strong, nonatomic) IBOutlet UIScrollView *scrView;
@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (strong, nonatomic) IBOutlet UIImageView *imgStreetView;







@end
