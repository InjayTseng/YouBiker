//
//  ViewController.h
//  YouBikeBest
//
//  Created by injay on 13/5/7.
//  Copyright (c) 2013年 injay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "ContentViewBasicController.h"
#import "UIScrollView+APParallaxHeader.h"
@interface ViewController : ContentViewBasicController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>{

}

@property (nonatomic,strong) IBOutlet UITableView *tbView;
@property (nonatomic,strong) UIRefreshControl *refreshControl;
@property (nonatomic,strong) UIView *headerView;
@property (strong, nonatomic) UILabel *naviTitle;
-(void)reFreshDataFromServer;

@end
