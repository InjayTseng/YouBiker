//
//  SideMenuViewController.m
//  YouBikeBest
//
//  Created by injay on 13/5/13.
//  Copyright (c) 2013年 injay. All rights reserved.
//

#import "SideMenuViewController.h"
#import "SWRevealViewController.h"
#import "DetailViewController.h"
#import "ViewController.h"
#import "DataManager.h"
#import "Site.h"

@interface SideMenuViewController ()

@end

@implementation SideMenuViewController


- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender
{
    
    if ( [segue isKindOfClass: [SWRevealViewControllerSegue class]] )
    {
        //NSLog(@"SWRevealViewControllerSegue");
        SWRevealViewControllerSegue* rvcs = (SWRevealViewControllerSegue*) segue;
        SWRevealViewController* rvc = self.revealViewController;
        NSAssert( rvc != nil, @"oops! must have a revealViewController" );
        NSAssert( [rvc.frontViewController isKindOfClass: [UINavigationController class]], @"oops!  for this segue we want a permanent navigation controller in the front!" );
        
        rvcs.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
            
            UINavigationController* nc = (UINavigationController*)rvc.frontViewController;
            [nc setViewControllers: @[ dvc ] animated: NO ];
            [rvc setFrontViewPosition: FrontViewPositionLeft animated: YES];
        };
        
        /*
        if([[[nc viewControllers] objectAtIndex:0] isMemberOfClass:NSClassFromString(@"ViewController")] && sender == self.btnListView)
        {
//            rvcs.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
//                [rvc setFrontViewPosition: FrontViewPositionLeft animated: YES];
//            };
            rvcs.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
                
                UINavigationController* nc = (UINavigationController*)rvc.frontViewController;
                [nc setViewControllers: @[ dvc ] animated: NO ];
                [rvc setFrontViewPosition: FrontViewPositionLeft animated: YES];
            };
        }
        
         else if (sender == self.btnSearch){
            
            rvcs.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
                
                UINavigationController* nc = (UINavigationController*)rvc.frontViewController;
                [nc setViewControllers: @[ dvc ] animated: NO ];
                [rvc setFrontViewPosition: FrontViewPositionLeft animated: YES];
            };
        }
        
        else if (sender == self.btnMap){
        
            rvcs.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
                
                UINavigationController* nc = (UINavigationController*)rvc.frontViewController;
                [nc setViewControllers: @[ dvc ] animated: NO ];
                [rvc setFrontViewPosition: FrontViewPositionLeft animated: YES];
            };
        }else if (sender == self.btnSettings){
            
            rvcs.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
                
                UINavigationController* nc = (UINavigationController*)rvc.frontViewController;
                [nc setViewControllers: @[ dvc ] animated: NO ];
                [rvc setFrontViewPosition: FrontViewPositionLeft animated: YES];
            };
        }else{
            rvcs.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
                
                UINavigationController* nc = (UINavigationController*)rvc.frontViewController;
                [nc setViewControllers: @[ dvc ] animated: NO ];
                [rvc setFrontViewPosition: FrontViewPositionLeft animated: YES];
            };
        
        }
        */
     
    }
     
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)goLocation:(double)lat andLon:(double)lon withName:(NSString*)name{
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    for (Site *site1 in [[DataManager shareInstance] siteArray]){
        
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = [site1.lat doubleValue];
        coordinate.longitude = [site1.lng doubleValue];
        
        //NSLog(@"%f",coordinate.longitude );
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        [annotation setCoordinate:coordinate];
        [annotation setTitle:site1.name];
        [self.mapView addAnnotation:annotation];
        
    }
}

-(void)zoomatUserLocation{
    
    [self.mapView setShowsUserLocation:YES];
    CLLocationCoordinate2D now = [[DataManager shareInstance] getCurrentLocationNow];
    MKCoordinateRegion newRegion;
    newRegion.center.latitude=now.latitude;
    newRegion.center.longitude=now.longitude;
    newRegion.span.latitudeDelta=0.015;
    newRegion.span.longitudeDelta=0.015;
    
    [self.mapView setRegion:newRegion animated:NO];
    
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
    
    
    UIButton*myButton =[UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    myButton.frame =CGRectMake(0,0,40,40);
    [myButton addTarget:self action:@selector(annotaionViewClicked:) forControlEvents:UIControlEventTouchUpInside];
    [myButton setTitle:[annotation title] forState:UIControlStateNormal];
    [myButton setRestorationIdentifier:[annotation title]];
    
    annotationView.leftCalloutAccessoryView =imgView;
    annotationView.rightCalloutAccessoryView = myButton;
    
    //annotationView.image = [UIImage imageNamed:@"BikeAnnotation"];
    return annotationView;
}


-(void)annotaionViewClicked:(id)sender{
    
    UIButton *btn = sender;
    //    NSLog(@"sender %@",btn.restorationIdentifier);
    Site *site = [[DataManager shareInstance] searchSiteByTitle:btn.restorationIdentifier];
    //[self navigatesToDetailbySite:site];
    NSLog(@"Go to %@",site.name);
    
    SWRevealViewController* rvc = self.revealViewController;
    NSAssert( rvc != nil, @"oops! must have a revealViewController" );
    NSAssert( [rvc.frontViewController isKindOfClass: [UINavigationController class]], @"oops!  for this segue we want a permanent navigation controller in the front!" );
    
    DetailViewController *dv = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    [dv setTitleName:site.name];
    [dv.lbCanRent setText:site.availBike];
    [dv.lbCanPark setText:site.capacity];
    [dv setCurrentSite:site];
    [dv goLocation:[site.lat doubleValue] andLon:[site.lng doubleValue] withName:site.name];
    [self.navigationController pushViewController:dv animated:YES];
    UINavigationController* nc = (UINavigationController*)rvc.frontViewController;
    UIViewController *vc = [[nc viewControllers] objectAtIndex:0];
    [nc setViewControllers: @[ vc, dv ] animated: NO ];
    [rvc setFrontViewPosition: FrontViewPositionLeft animated: YES];

}




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[self zoomatUserLocation];
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [self goLocation:25.0365638889 andLon:121.568663889 withName:@"You"];
    [self zoomatUserLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
