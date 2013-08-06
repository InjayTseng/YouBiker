//
//  DataManager.h
//  ClientTemplate
//
//  Created by injay on 13/4/23.
//  Copyright (c) 2013年 injay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@class DTTimer;
@class Site;

@interface DataManager : NSObject <CLLocationManagerDelegate>{
    
    //Data
    NSMutableArray *siteArray;
    NSMutableArray *favoriteSiteArray;
    NSMutableDictionary *favoriteSiteDictionary;
    
    //Config
    UIColor *favoriteColor;
    BOOL isGPSON;
    
}

@property (nonatomic,retain) NSMutableArray *siteArray;
@property (nonatomic,retain) NSMutableArray *favoriteSiteArray;
@property (nonatomic,retain) NSMutableDictionary *favoriteSiteDictionary;
@property (nonatomic,retain) UIColor *favoriteColor;
@property (nonatomic,retain) CLLocationManager *locationManager;
@property (nonatomic,readwrite) BOOL isGPSON;
@property (nonatomic,retain) DTTimer *timer;

+ (DataManager *) shareInstance;
- (Site*)searchSiteByTitle:(NSString*)siteTitle;
-(void)calculateDistanceAndSort;
- (CLLocationCoordinate2D)getCurrentLocationNow;
-(void)setGPS:(BOOL)onOff;

-(NSMutableDictionary*)readFavoriteSites;
- (void)writeNewFavoriteSites:(NSMutableDictionary*)sites;

-(NSMutableDictionary*)readFavoriteColor;
- (void)writeNewFavoriteColor:(NSString*)colorName;
    
@end


