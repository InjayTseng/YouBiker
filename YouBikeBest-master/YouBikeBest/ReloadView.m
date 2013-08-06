//
//  ReloadView.m
//  YouBikeBest
//
//  Created by injay on 13/5/23.
//  Copyright (c) 2013年 injay. All rights reserved.
//

#import "ReloadView.h"

@implementation ReloadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self.activity setHidesWhenStopped:YES];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
