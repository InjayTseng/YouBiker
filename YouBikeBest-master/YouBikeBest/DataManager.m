//
//  DataManager.m
//  ClientTemplate
//
//  Created by injay on 13/4/23.
//  Copyright (c) 2013年 injay. All rights reserved.
//

#import "DataManager.h"
#import "Site.h"
#import <CoreLocation/CoreLocation.h>
#import "DTTimer.h"
@implementation DataManager
@synthesize siteArray,favoriteSiteArray,favoriteColor,locationManager,isGPSON,timer,favoriteSiteDictionary;
+ (DataManager *) shareInstance
{
    // Persistent instance.
    static DataManager *_default = nil;

    // Small optimization to avoid wasting time after the
    // singleton being initialized.
    if (_default != nil)
    {
        return _default;
    }
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
    // Allocates once with Grand Central Dispatch (GCD) routine.
    // It's thread safe.
    static dispatch_once_t safer;
    dispatch_once(&safer, ^(void)
                  {
                      _default = [[DataManager alloc] init];
                      // private initialization goes here.
                  });
#else
    // Allocates once using the old approach, it's slower.
    // It's thread safe.
    @synchronized([DataManager class])
    {
        // The synchronized instruction will make sure,
        // that only one thread will access this point at a time.
        if (_default == nil)
        {
            _default = [[MySingleton alloc] init];
        
            // private initialization goes here.
        }
    }
#endif
    return _default;
}

- (id)init {
    if (self = [super init]) {
        siteArray = [[NSMutableArray alloc]init];
        favoriteSiteArray = [[NSMutableArray alloc]init];
        favoriteColor = [UIColor colorWithRed:75./255. green:137./255. blue:255./208. alpha:1.0];
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters; // 100 m
        [self.locationManager startUpdatingLocation];
        isGPSON = TRUE;
        timer = [[DTTimer alloc]init];
    }
    return self;
}



-(Site*)searchSiteByTitle:(NSString*)siteTitle{

    for (Site *site1 in self.siteArray){
//        NSLog(@"%@ vs %@",siteTitle,site1.name);
        if ([site1.name isEqualToString:siteTitle]) {
            return site1;
        }
    }
    return nil;
}

- (CLLocationCoordinate2D)getCurrentLocationNow{
    
    CLLocationCoordinate2D now_pos =CLLocationCoordinate2DMake(self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude);

    return now_pos;
}


-(void)calculateDistanceAndSort{

    CLLocationCoordinate2D now_loc = [self getCurrentLocationNow];
    for (Site *site1 in self.siteArray){
    
        site1.distance = [self distanceBetween:now_loc andLoc2:CLLocationCoordinate2DMake([site1.lat doubleValue], [site1.lng doubleValue])];
                
    }
    NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"distance" ascending:YES];
    [self.siteArray sortUsingDescriptors:[NSArray arrayWithObject:sort]];
}


-(double)distanceBetween:(CLLocationCoordinate2D)loc1 andLoc2:(CLLocationCoordinate2D)loc2{

    double x = loc1.latitude - loc2.latitude;
    double y = loc1.longitude - loc2.longitude;
    double distance = x*x + y*y;
    return distance;
}

-(void)setGPS:(BOOL)onOff{


    isGPSON = onOff;
    if (onOff==TRUE) {
        
    }else{
        [self.locationManager stopUpdatingLocation];
        [self.locationManager stopUpdatingHeading];
    }
    
}




-(NSMutableDictionary*)readFavoriteSites{
    
	NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
	// get documents path
	NSString *documentsPath = [paths objectAtIndex:0];
	// get the path to our Data/plist file
	NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"favoriteList.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
	{
		// if not in documents, get property list from main bundle
		plistPath = [[NSBundle mainBundle] pathForResource:@"DefaultList" ofType:@"plist"];
        NSMutableDictionary *tmp = [[NSMutableDictionary alloc]initWithCapacity:0];
        return tmp;
	}
    
	// read property list into memory as an NSData object
	NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSLog(@"Read Plist file in at %@",plistPath);
	NSString *errorDesc = nil;
	NSPropertyListFormat format;
	NSMutableDictionary *temp = (NSMutableDictionary *)[NSPropertyListSerialization propertyListFromData:plistXML mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&format errorDescription:&errorDesc];
    // check to see if Data.plist exists in documents
    NSLog(@"Content %@",temp);
	if (!temp)
	{
		NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
	}
    return temp;
}



- (void)writeNewFavoriteSites:(NSMutableDictionary*)sites
{
	// get paths from root direcory
	NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
	// get documents path
	NSString *documentsPath = [paths objectAtIndex:0];
	// get the path to our Data/plist file
	NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"favoriteList.plist"];
    
    // Update Data =============================================================================================
    
    
    NSDictionary *writeInData = [[NSDictionary alloc]initWithDictionary:sites];
    //==========================================================================================================
    
	NSString *error = nil;
	// create NSData from dictionary
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:writeInData format:NSPropertyListXMLFormat_v1_0 errorDescription:&error];
	
    // check is plistData exists
	if(plistData)
	{
        // write plistData to our Data.plist file
        [plistData writeToFile:plistPath atomically:YES];
        NSLog(@"Write Update list in %@",plistPath);
    }
    else
	{
        NSLog(@"Error in saveData: %@", error);
    }
}


-(NSMutableDictionary*)readFavoriteColor{
    
	NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
	// get documents path
	NSString *documentsPath = [paths objectAtIndex:0];
	// get the path to our Data/plist file
	NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"favoriteColor.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
	{
		// if not in documents, get property list from main bundle
		plistPath = [[NSBundle mainBundle] pathForResource:@"DefaultList" ofType:@"plist"];
        NSMutableDictionary *tmp = [[NSMutableDictionary alloc]initWithCapacity:0];
        return tmp;
	}
    
	// read property list into memory as an NSData object
	NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSLog(@"Read Plist file in at %@",plistPath);
	NSString *errorDesc = nil;
	NSPropertyListFormat format;
	NSMutableDictionary *temp = (NSMutableDictionary *)[NSPropertyListSerialization propertyListFromData:plistXML mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&format errorDescription:&errorDesc];
    // check to see if Data.plist exists in documents
    NSLog(@"Content %@",temp);
	if (!temp)
	{
		NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
	}
    return temp;
}

- (void)writeNewFavoriteColor:(NSString*)colorName
{
	// get paths from root direcory
	NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
	// get documents path
	NSString *documentsPath = [paths objectAtIndex:0];
	// get the path to our Data/plist file
	NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"favoriteColor.plist"];
  
    NSMutableDictionary *color = [[NSMutableDictionary alloc]init];
    [color setObject:@1 forKey:colorName];
    // Update Data =============================================================================================
    NSDictionary *writeInData = [[NSDictionary alloc]initWithDictionary:color];
    //==========================================================================================================
    
	NSString *error = nil;
	// create NSData from dictionary
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:writeInData format:NSPropertyListXMLFormat_v1_0 errorDescription:&error];
	
    // check is plistData exists
	if(plistData)
	{
        // write plistData to our Data.plist file
        [plistData writeToFile:plistPath atomically:YES];
        NSLog(@"Write Update list in %@",plistPath);
    }
    else
	{
        NSLog(@"Error in saveData: %@", error);
    }
}
@end
