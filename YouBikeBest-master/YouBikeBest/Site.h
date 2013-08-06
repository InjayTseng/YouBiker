//
//  Site.h
//  YouBikeBest
//
//  Created by injay on 13/5/7.
//  Copyright (c) 2013年 injay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Site : NSObject

@property (nonatomic,strong) NSString* ID;
@property (nonatomic,strong) NSString* name;
@property (nonatomic,strong) NSString* lat;
@property (nonatomic,strong) NSString* lng;
@property (nonatomic,strong) NSString* capacity;
@property (nonatomic,strong) NSString* availBike;
@property (nonatomic,strong) NSString* address;
@property (nonatomic,readwrite) double distance;



@end
