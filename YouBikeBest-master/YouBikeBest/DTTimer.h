//
//  DTTimer.h
//  YouBikeBest
//
//  Created by injay on 13/6/4.
//  Copyright (c) 2013年 injay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTTimer : NSObject {

    int ss;
    int mm;
    int hh;
    
}

@property(nonatomic,strong) NSTimer *timer;

-(void)start;
-(void)stop;
-(void)clear;
-(BOOL)isCounting;

-(NSString*)currentTime;
@end
