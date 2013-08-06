//
//  DetailViewController.m
//  YouBikeBest
//
//  Created by injay on 13/5/8.
//  Copyright (c) 2013年 injay. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "MapViewController.h"
#import "DataManager.h"
#import "JLActionSheet.h"
#import "WebServiceOperation.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "SocialSharing.h"
#import <QuartzCore/QuartzCore.h>
#import "StreetViewController.h"
@interface DetailViewController () <JLActionSheetDelegate>
@property (nonatomic, strong) JLActionSheet* actionSheet;

- (IBAction)btnFacebookClicked:(id)sender;
- (IBAction)btnTweeterClicked:(id)sender;
- (IBAction)btnStreetViewClicked:(id)sender;

@end

@implementation DetailViewController

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return interfaceOrientation == UIInterfaceOrientationPortrait;
}


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
    self.trackedViewName = @"DetailView";
	// Do any additional setup after loading the view.
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 35)];
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    // Do any additional setup after loading the view.
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    [rightButton setImage:[UIImage imageNamed:@"right3.png"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    [self.scrView addSubview:self.contentView];
    self.scrView.contentSize = CGSizeMake(self.contentView.frame.size.width,self.contentView.frame.size.height);
    [self.scrView addSubview:self.mapView];
    
    
    if(![self isStreetViewImageExist] ){
        [self loadImageByLocation:self.currentSite.lat andLon:self.currentSite.lng withFinishBlock:^(NSData *imageData) {
            [self.imgStreetView setImage:[UIImage imageWithData:imageData]];
            [self saveImage:[UIImage imageWithData:imageData]];
        }];
    }else{
        [self.imgStreetView setImage:[self loadImage]];
    }
}

- (UIImage*)loadImage
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *fileName = [NSString stringWithFormat:@"%@.png",self.currentSite.name];
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:
                      [NSString stringWithString:fileName] ];
    UIImage* image = [UIImage imageWithContentsOfFile:path];
    return image;
}



-(BOOL)isStreetViewImageExist{
    
    NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *fileName = [NSString stringWithFormat:@"%@.png",self.currentSite.name];
    NSString* foofile = [documentsPath stringByAppendingPathComponent:fileName];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:foofile];
    
    return fileExists;
}

- (void)saveImageByData: (NSData*)imageData
{
    if (imageData != nil)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString* fileName = self.currentSite.name;
        NSString* appendPNG = [NSString stringWithFormat:@"%@.png",fileName];
        NSString* path = [documentsDirectory stringByAppendingPathComponent:appendPNG];
        NSLog(@"Path %@",path);
        [imageData writeToFile:path atomically:YES];
    }
}


- (void)saveImage: (UIImage*)image
{
    if (image != nil)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString* path = [documentsDirectory stringByAppendingPathComponent:@"test.png" ];
        NSData* data = UIImagePNGRepresentation(image);
        [data writeToFile:path atomically:YES];
    }
}



-(void)viewWillAppear:(BOOL)animated{
    
    
    self.naviTitle  = [[UILabel alloc]initWithFrame:CGRectMake(80,6,160,32)];
    self.naviTitle.text = self.currentSite.name;
    self.naviTitle.font = [UIFont fontWithName:@"STHeitiSC-Light" size:17.];
    self.naviTitle.textColor = [UIColor darkGrayColor];
    self.naviTitle.textAlignment = NSTextAlignmentCenter;
    self.naviTitle.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar addSubview:self.naviTitle];
}

-(void)backAction{
    if ([[[self.navigationController viewControllers] objectAtIndex:[[self.navigationController viewControllers] count]-2] isKindOfClass:[ViewController class]]) {
        
        ViewController *vc = [[self.navigationController viewControllers] objectAtIndex:[[self.navigationController viewControllers] count]-2];
        [vc reFreshDataFromServer];
        [vc.tbView.parallaxView.imageView setImage:[self loadImage]];
    }
    [self.navigationController popViewControllerAnimated:YES];
    [self.naviTitle setText:@""];
    self.naviTitle = nil;
}

-(void)rightButtonClicked{
    self.actionSheet = [[JLActionSheet alloc]initWithTitle:@""
                                                  delegate:self
                                         cancelButtonTitle:@"取消"
                                         otherButtonTitles:@[@"加入我的最愛 +",@"取消我的最愛 -",@"導航"]];
    
    [self.actionSheet allowTapToDismiss:YES];
    [self.actionSheet setStyle:JLSTYLE_STEEL];
    [self.actionSheet showOnViewController:self];
}


-(void)goLocation:(double)lat andLon:(double)lon withName:(NSString*)name{
    
    MKCoordinateRegion newRegion;
    newRegion.center.latitude=lat;
    newRegion.center.longitude=lon;
    newRegion.span.latitudeDelta=0.01;
    newRegion.span.longitudeDelta=0.01;

    [self.mapView setRegion:newRegion animated:NO];
    
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = lat;
    coordinate.longitude = lon;
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate:coordinate];
    [annotation setTitle:name];
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView addAnnotation:annotation];
    
    self.naviTitle = [[UILabel alloc]initWithFrame:CGRectMake(80,6,160,32)];
    self.naviTitle.text = name;
    self.naviTitle.font = [UIFont fontWithName:@"STHeitiSC-Light" size:17.];
    self.naviTitle.textColor = [UIColor darkGrayColor];
    self.naviTitle.textAlignment = NSTextAlignmentCenter;
    [self.navigationController.navigationBar addSubview:self.naviTitle];
}

-(void)setTitleName:(NSString*)name{
    
    self.naviTitle = [[UILabel alloc]initWithFrame:CGRectMake(80,6,160,32)];
    self.naviTitle.text = name;
    self.naviTitle.font = [UIFont fontWithName:@"STHeitiSC-Light" size:17.];
    self.naviTitle.textColor = [UIColor darkGrayColor];
    self.naviTitle.textAlignment = NSTextAlignmentCenter;
    self.naviTitle.backgroundColor = [UIColor blackColor];
    [self.navigationController.navigationBar addSubview:self.naviTitle];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)routeCurrentToLocation:(double)lat andLon:(double)lon{
    
    CLLocationCoordinate2D location2;
    location2.latitude = lat;
    location2.longitude = lon;
    
    MKMapItem *curItem = [MKMapItem mapItemForCurrentLocation];
    MKPlacemark *annotation = [[MKPlacemark alloc]initWithCoordinate:location2 addressDictionary:nil];
    MKMapItem *toItem = [[MKMapItem alloc]initWithPlacemark:annotation];
    
    NSArray *array = [[NSArray alloc] initWithObjects:curItem,toItem,nil];
    NSDictionary *dicOption = @{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking,
                                MKLaunchOptionsShowsTrafficKey:[NSNumber numberWithBool:YES] };
    [MKMapItem openMapsWithItems:array launchOptions:dicOption];
}



-(UIImage*)loadImageByLocation:(NSString*)lat andLon:(NSString*)lon withFinishBlock:(void (^)(NSData *imageData))finish{
    
    NSLog(@"%@ %@",lat,lon);
    NSString *stringURL = @"http://maps.googleapis.com/maps/api/streetview?size=600x300&location=ooooo%20xxxxx&fov=120&heading=235&pitch=10&sensor=false";
    stringURL = [stringURL stringByReplacingOccurrencesOfString:@"ooooo" withString:lat];
    stringURL = [stringURL stringByReplacingOccurrencesOfString:@"xxxxx" withString:lon];
    stringURL = [stringURL stringByReplacingOccurrencesOfString:@"235" withString:[NSString stringWithFormat:@"%d",rand()%360+1]];
    
    [WebServiceOperation processImageDataWithURLString:stringURL andBlock:^(NSData *imageData) {
        if (self.view.window) {
            finish(imageData);
            [self saveImageByData:imageData];
        }
    }];
    return nil;
}



- (void) actionSheet:(JLActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{

    switch (buttonIndex) {
        case 0:
            
            NSLog(@"0");
            break;
        case 1:
            NSLog(@"Route");
            [self routeCurrentToLocation:[self.currentSite.lat doubleValue] andLon:[self.currentSite.lng doubleValue]];
            
            break;
        case 2:
            NSLog(@"取消我的最愛");
            [[[DataManager shareInstance] favoriteSiteArray] removeAllObjects];
            if (1) {
                
                NSMutableDictionary *favoriteSites = [[DataManager shareInstance] readFavoriteSites];
                [favoriteSites removeObjectForKey:self.currentSite.name];
                [[DataManager shareInstance]writeNewFavoriteSites:favoriteSites];
            }
            break;
            
        case 3:
            NSLog(@"Favorite");
            //[[[DataManager shareInstance] favoriteSiteArray] addObject:self.currentSite];
            if (1) {
                
                NSMutableDictionary *favoriteSites = [[DataManager shareInstance] readFavoriteSites];
                [favoriteSites setObject:@1 forKey:self.currentSite.name];
                [[DataManager shareInstance]writeNewFavoriteSites:favoriteSites];
            }
            
            break;

        default:
            break;
    }
    
}
- (void) actionSheet:(JLActionSheet*)actionSheet didDismissButtonAtIndex:(NSInteger)buttonIndex{

}
- (IBAction)btnToNextSiteClicked:(id)sender {
    
    MapViewController *mcv = [self.storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
    [mcv changeStartName:[NSString stringWithFormat:@"%@",self.currentSite.name]];    
    [self.navigationController pushViewController:mcv animated:YES];
}

-(UIImage*)captureScreen{
    
    CGSize overallSize = self.scrView.contentSize;
    UIGraphicsBeginImageContext(self.scrView.contentSize);
    // Save the current bounds
    CGRect tmp = self.scrView.bounds;
    self.scrView.bounds = CGRectMake(0, 0, overallSize.width, overallSize.height);
    [self.scrView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // Restore the bounds
    self.scrView.bounds = tmp;
    return viewImage;
}

- (IBAction)btnFacebookClicked:(id)sender {
    
    [self presentViewController:[SocialSharing facebookSharing:@"Let's go bike !" andImage:[self captureScreen]] animated:YES completion:Nil];

}

- (IBAction)btnTweeterClicked:(id)sender {
    [self presentViewController:[SocialSharing tweeterSharing:@"Let's go bike !" andImage:[self captureScreen]] animated:YES completion:Nil];
}

- (IBAction)btnStreetViewClicked:(id)sender {
    
    StreetViewController *svc = [self.storyboard instantiateViewControllerWithIdentifier:@"StreetViewController"];
    [svc setSite:self.currentSite];
    [self.navigationController pushViewController:svc animated:YES];
    
}

@end
