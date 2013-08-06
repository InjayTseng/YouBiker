//
//  MapViewController.m
//  YouBikeBest
//
//  Created by injay on 13/5/14.
//  Copyright (c) 2013年 injay. All rights reserved.
//

#import "MapViewController.h"
#import "DetailViewController.h"
#import "DataManager.h"
#import "Site.h"
@interface MapViewController ()

- (IBAction)btnSelectClicked:(id)sender;

@end

@implementation MapViewController


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
     self.trackedViewName = @"RoutePage";
	// Do any additional setup after loading the view.
    self.btnSelect.hidden = YES;
    [self.mapView setShowsUserLocation:YES];
    [self zoomatUserLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated{
    [self goLocation:25.0365638889 andLon:121.568663889 withName:@"You"];
}


-(void)zoomatUserLocation{

    CLLocationCoordinate2D now = [[DataManager shareInstance] getCurrentLocationNow];
    MKCoordinateRegion newRegion;
    newRegion.center.latitude=now.latitude;
    newRegion.center.longitude=now.longitude;
    newRegion.span.latitudeDelta=0.02;
    newRegion.span.longitudeDelta=0.02;
    
    [self.mapView setRegion:newRegion animated:NO];
    
    self.startLoc = [[DataManager shareInstance] getCurrentLocationNow];
    
}

-(void)goLocation:(double)lat andLon:(double)lon withName:(NSString*)name{
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    for (Site *site1 in [[DataManager shareInstance] siteArray]){
    
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = [site1.lat doubleValue];
        coordinate.longitude = [site1.lng doubleValue];
        
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        [annotation setCoordinate:coordinate];
        [annotation setTitle:site1.name];
        [annotation setSubtitle:[NSString stringWithFormat:@"%@/%@",site1.availBike,site1.capacity]];
        [self.mapView addAnnotation:annotation];
    }
    
}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{


    NSLog(@"select %@",[view.annotation title]);
    NSString *string  =[NSString stringWithFormat:@"到 %@",[view.annotation title]];
    [self.btnSelect setTitle:string forState:UIControlStateNormal];
    self.btnSelect.hidden = NO;
    
    
}



- (IBAction)btnSelectClicked:(id)sender {
    
    Site *site = [[DataManager shareInstance] searchSiteByTitle:self.btnSelect.titleLabel.text];
    
    if (site == nil) {
        NSLog(@"Cant Find %@",self.btnSelect.titleLabel.text);
    }
    [self navigatesToDetailbySite:site];
}


-(void)annotaionViewClicked:(id)sender{
    
    UIButton *btn = sender;
    Site *site = [[DataManager shareInstance] searchSiteByTitle:btn.restorationIdentifier];
    [self routeFrom:self.startLoc.latitude andLon:self.startLoc.longitude toLocation:[site.lat doubleValue] andLon:[site.lng doubleValue]];

}


-(void)navigatesToDetailbySite:(Site*)site{
    DetailViewController *dv = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    [dv setTitleName:site.name];
    [dv.lbCanRent setText:site.availBike];
    [dv.lbCanPark setText:site.capacity];
    [dv setCurrentSite:site];
    [dv goLocation:[site.lat doubleValue] andLon:[site.lng doubleValue] withName:site.name];
    [self.navigationController pushViewController:dv animated:YES];
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    
    if (annotation == mapView.userLocation) {
        
        return nil;
    }
    
    // this part is boilerplate c/Users/injay/Desktop/right2.pngode used to create or reuse a pin annotation
    
    static NSString *viewId = @"MKPinAnnotationView";
    MKPinAnnotationView *annotationView = (MKPinAnnotationView*)
    [self.mapView dequeueReusableAnnotationViewWithIdentifier:viewId];
    if (annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc]
                           initWithAnnotation:annotation reuseIdentifier:viewId];
    }
    
    // set your custom image
    annotationView.canShowCallout = YES;
    UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(0, -50, 35, 35)];
    [tempView setBackgroundColor:[UIColor blackColor]];
    
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60*25/35, 25)];
    [imgView setImage:[UIImage imageNamed:@"bycicle.png"]];
    
    
    UIButton*myButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [myButton setBackgroundImage:[UIImage imageNamed:@"injay_navigates.png"] forState:UIControlStateNormal];
    myButton.frame =CGRectMake(0,0,35,35);
    [myButton addTarget:self action:@selector(annotaionViewClicked:) forControlEvents:UIControlEventTouchUpInside];
    //[myButton setTitle:[annotation title] forState:UIControlStateNormal];
    [myButton setRestorationIdentifier:[annotation title]];
    
    annotationView.leftCalloutAccessoryView =imgView;
    annotationView.rightCalloutAccessoryView = myButton;
    
    //annotationView.image = [UIImage imageNamed:@"BikeAnnotation"];
    return annotationView;
}

-(void)routeFrom:(double)lat1 andLon:(double)lon1 toLocation:(double)lat2 andLon:(double)lon2{
    
    CLLocationCoordinate2D location1;
    location1.latitude = lat1;
    location1.longitude = lon1;

    CLLocationCoordinate2D location2;
    location2.latitude = lat2;
    location2.longitude = lon2;
    
    MKPlacemark *annotation1 = [[MKPlacemark alloc]initWithCoordinate:location1 addressDictionary:nil];
    MKMapItem *curItem = [[MKMapItem alloc]initWithPlacemark:annotation1];
    
    MKPlacemark *annotation2 = [[MKPlacemark alloc]initWithCoordinate:location2 addressDictionary:nil];
    MKMapItem *toItem = [[MKMapItem alloc]initWithPlacemark:annotation2];
    
    NSArray *array = [[NSArray alloc] initWithObjects:curItem,toItem,nil];
    NSDictionary *dicOption = @{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking,
                                MKLaunchOptionsShowsTrafficKey:[NSNumber numberWithBool:YES] };
    [MKMapItem openMapsWithItems:array launchOptions:dicOption];
}

-(void)changeStartName:(NSString*)stringForTitle{
    NSLog(@"%@",stringForTitle);
    [self.btnStart setTitle:stringForTitle forState:UIControlStateNormal];
    //[self.btnStart setBackgroundColor:[UIColor whiteColor]];
}

@end
