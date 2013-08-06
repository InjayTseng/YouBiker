//
//  DTTimer.m
//  YouBikeBest
//
//  Created by injay on 13/6/4.
//  Copyright (c) 2013年 injay. All rights reserved.
//

#import "DTTimer.h"

@implementation DTTimer

-(id)init{

    if (self = [super init]) {
    
        ss=0;
        mm=0;
        hh=0;
    }
    return self;
}
-(void)start{
    
    if (![self.timer isValid]) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval: 1.
                                                      target: self
                                                    selector: @selector(startCounting)
                                                    userInfo: nil
                                                     repeats: YES];
    }
}

-(void)stop{

    [self.timer invalidate];
}

-(void)clear{

    ss=0;
    mm=0;
    hh=0;
    
}

-(void)startCounting{
    if (++ss >=60 ) {
        ss=0;
        ++mm;
        
        if (mm >= 60) {
            
            mm=0;
            ++hh;
            if (hh >= 99) {
            
                hh=0;
                
                
            }
        }
    }
}

-(BOOL)isCounting{

    return [self.timer isValid];
}

-(NSString*)currentTime{
    
    return [NSString stringWithFormat:@"%02d:%02d:%02d",hh,mm,ss];

}


@end
