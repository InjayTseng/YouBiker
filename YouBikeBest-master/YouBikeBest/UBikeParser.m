//
//  UBikeParser.m
//  YouBikeBest
//
//  Created by injay on 13/5/7.
//  Copyright (c) 2013年 injay. All rights reserved.
//

#import "UBikeParser.h"
#import "DataManager.h"
#import "GDataXMLNode.h"
#import "Site.h"

@implementation UBikeParser

+ (void)startXMLSiteParsing{
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"log" ofType:@"xml"];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:[NSData dataWithContentsOfFile:path] encoding:NSUTF8StringEncoding  error:NULL];
    if (doc) {
        NSError *error;
        //NSArray *employees = [doc nodesForXPath:@"//id" error:&error];
        //NSLog(@"Root %@",[doc rootElement]);
        if (error) {
            NSLog(@"%@",error);
        }
        NSArray *BELocationArray = [doc.rootElement elementsForName:@"BELocation"];
        //NSLog(@"%@",BELocationArray);
        for (GDataXMLElement *site in BELocationArray) {
            
            Site *UBikeSite = [[Site alloc]init];
            // Name
            NSArray *names = [site elementsForName:@"name"];
            if (names.count > 0) {
                GDataXMLElement *firstName = (GDataXMLElement *) [names objectAtIndex:0];
                NSLog(@"Name: %@",[firstName stringValue]);
                [UBikeSite setName:[firstName stringValue]];
            } else continue;
            
            // lat
            NSArray *lat = [site elementsForName:@"lat"];
            if (lat.count > 0) {
                GDataXMLElement *firstName = (GDataXMLElement *) [lat objectAtIndex:0];
                NSLog(@"lat: %@",[firstName stringValue]);
                [UBikeSite setLat:[firstName stringValue]];
            } else continue;
            
            // lng
            NSArray *lng = [site elementsForName:@"lng"];
            if (lng.count > 0) {
                GDataXMLElement *firstName = (GDataXMLElement *) [lng objectAtIndex:0];
                NSLog(@"lng: %@",[firstName stringValue]);
                [UBikeSite setLng:[firstName stringValue]];
            } else continue;
            
            // capacity
            NSArray *capacity = [site elementsForName:@"capacity"];
            if (capacity.count > 0) {
                GDataXMLElement *firstName = (GDataXMLElement *) [capacity objectAtIndex:0];
                NSLog(@"capacity: %@",[firstName stringValue]);
                [UBikeSite setCapacity:[firstName stringValue]];
            } else continue;
            
            // availBike
            NSArray *availBike = [site elementsForName:@"availBike"];
            if (availBike.count > 0) {
                GDataXMLElement *firstName = (GDataXMLElement *) [availBike objectAtIndex:0];
                NSLog(@"availBike: %@",[firstName stringValue]);
                [UBikeSite setAvailBike:[firstName stringValue]];
            } else continue;
            
            // address
            NSArray *address = [site elementsForName:@"address"];
            if (address.count > 0) {
                GDataXMLElement *firstName = (GDataXMLElement *) [address objectAtIndex:0];
                NSLog(@"address: %@",[firstName stringValue]);
                [UBikeSite setAddress:[firstName stringValue]];
            } else continue;
            
            [[[DataManager shareInstance]siteArray] addObject:UBikeSite];
            //[[[DataManager shareInstance] siteArray] addObject:UBikeSite];
        }
        
    }else{
        NSLog(@"File is not exist.");
    }
}


@end
