//
//  SiteCell.m
//  YouBikeBest
//
//  Created by injay on 13/5/9.
//  Copyright (c) 2013年 injay. All rights reserved.
//

#import "SiteCell.h"

@implementation SiteCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setName:(NSString *)name{
    [self.lbName setText:name];
}

-(void)setCanRent:(NSString *)canRent{

    [self.lbCanRent setText:canRent];
}

-(void)setCanPark:(NSString *)canPark{

    [self.lbCanPark setText:canPark];
}


@end
