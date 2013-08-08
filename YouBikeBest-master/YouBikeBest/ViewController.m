//
//  ViewController.m
//  YouBikeBest
//
//  Created by injay on 13/5/7.
//  Copyright (c) 2013年 injay. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "GDataXMLNode.h"
#import "DataManager.h"
#import "Site.h"
#import "SiteCell.h"
#import "UBikeParser.h"
#import "WebServiceOperation.h"
#import "UBikeWebParser.h"
#import "ReloadView.h"
#import "DTBasics.h"
#import "SVProgressHUD.h"
#import "MapViewController.h"
#import "UIScrollView+APParallaxHeader.h"
#import "MapSiteViewController.h"

@interface ViewController ()

@property (nonatomic,readwrite) BOOL isShowReload;
@property (nonatomic,strong) ReloadView *reloadView;
@end

@implementation ViewController


-(BOOL)shouldAutorotate{
    return NO;
}

-(void)modalToMap{

   


    UIImage* image3 = [UIImage imageNamed:@"listIcon.png"];
    CGRect frameimg = CGRectMake(100, 100,40, 24);
    

    


    MapSiteViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MapSiteViewController"];
    

    
    [vc setSelectBlock: ^(Site* site){
        
        DetailViewController *dv = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
        [dv setTitleName:site.name];
        [dv.lbCanRent setText:site.availBike];
        [dv.lbCanPark setText:site.capacity];
        [dv setCurrentSite:site];
        [dv goLocation:[site.lat doubleValue] andLon:[site.lng doubleValue] withName:site.name];
        [self.navigationController pushViewController:dv animated:YES];
    
    }];
    
    UINavigationController * navc = [[UINavigationController alloc] initWithRootViewController:vc];
    
    
    [navc setModalPresentationStyle:UIModalPresentationFullScreen];
    
    [navc setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    

    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setBackgroundImage:image3 forState:UIControlStateNormal];
    [someButton addTarget:vc action:@selector(dismissModalViewControllerAnimated:)
         forControlEvents:UIControlEventTouchUpInside];
    [someButton setShowsTouchWhenHighlighted:YES];
    UIBarButtonItem *mailbutton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    [vc.navigationItem setRightBarButtonItem:mailbutton];

    [self presentViewController:navc animated:YES completion:nil];
    
    

    
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    
    UIImage* image3 = [UIImage imageNamed:@"map2.png"];
    CGRect frameimg = CGRectMake(100, 100,40, 24);
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setBackgroundImage:image3 forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(modalToMap)
         forControlEvents:UIControlEventTouchUpInside];
    [someButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *mailbutton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    self.navigationItem.rightBarButtonItem=mailbutton;
    
    [self setCustomTitleAs:@"Youbike"];
    
    [self initFavoriteColor];
    self.trackedViewName = @"YouBikeList";
    self.isShowReload = FALSE;
    
    //Data source
    DataManager *global = [DataManager shareInstance];
    global.siteArray = [[NSMutableArray alloc]init];
    
    [self reFreshDataFromServer];
    [self.tbView addParallaxWithImage:[UIImage imageNamed:@"trees.png"] andHeight:160.+35.];
    
    NSArray* reloadNibViews = [[NSBundle mainBundle] loadNibNamed:@"ReloadView"
                                                      owner:self
                                                    options:nil];
    
    ReloadView* reloadView = [ reloadNibViews objectAtIndex:0];
    [reloadView.activity setHidesWhenStopped:YES];
    [self setReloadView:reloadView];
    
    NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:@"HeaderView"
                                                      owner:self
                                                    options:nil];
    
    UIView* myView = [ nibViews objectAtIndex:0];
    self.headerView = myView;
    
    self.headerView.backgroundColor = [UIColor blackColor];
    self.headerView.alpha = 0.8;
    [self.headerView setFrame:CGRectMake(0, 160., self.headerView.frame.size.width, self.headerView.frame.size.height)];
    [self.reloadView setFrame:CGRectMake(0, -self.reloadView.frame.size.height, self.reloadView.frame.size.width, self.reloadView.frame.size.height)];
    
    [self.view addSubview:self.headerView];
    //[self.view addSubview:self.reloadView];
    [self addGestureRecognizerOn:self.tbView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (self.tbView.parallaxView.frame.size.height<35) {
        
        CGRect newPosition = CGRectMake(0,0, self.headerView.frame.size.width, self.headerView.frame.size.height);
        [self.headerView setFrame:newPosition];
        
    }else{
        CGRect newPosition = CGRectMake(self.headerView.frame.origin.x,self.tbView.parallaxView.frame.size.height-35., self.headerView.frame.size.width, self.headerView.frame.size.height);
        [self.headerView setFrame:newPosition];
    }
    
    float height = self.tbView.parallaxView.frame.size.height - 196.;
    //到43卡住
    if (height<43 & self.isShowReload==FALSE) {
        
        //跟著上
        [self.reloadView setFrame:CGRectMake(0, height-40, self.reloadView.frame.size.width, self.reloadView.frame.size.height)];
    }
    

}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    //NSLog(@"%f+5",self.reloadView.frame.origin.y);
    
    //放掉時大於5
    if (self.reloadView.frame.origin.y +5 > 0) {
        
        //Reload
        [self reFreshDataFromServer];
    }
}

-(void)reFreshDataFromServer{
    
    [SVProgressHUD showWithStatus:@"同步中" maskType:SVProgressHUDMaskTypeNone];
    dispatch_queue_t fetchQ = dispatch_queue_create("Refreshing", NULL);
    dispatch_async(fetchQ, ^{
        [UBikeWebParser startParsing:^{
            [SVProgressHUD dismiss];
            [SVProgressHUD showSuccessWithStatus:@"已同步"];
            
            if ([[DataManager shareInstance] isGPSON])
            [[DataManager shareInstance] calculateDistanceAndSort];
            
            [self createFavoriteArray];
            [self deleteFavoriteInArray];
            NSLog(@"reload Data.");
            [self.tbView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
            
        }];
    });
}

-(void)deleteFavoriteInArray{

    for (Site *site1 in [[DataManager shareInstance] favoriteSiteArray] ){
        for (Site *site2 in [[DataManager shareInstance] siteArray]){
            if ([site1.name isEqualToString:site2.name]) {
                
            }
        }
    }
    
}


-(BOOL)createFavoriteArray{

    NSMutableDictionary *favoriteSites  = [[DataManager shareInstance] readFavoriteSites];
    [[[DataManager shareInstance] favoriteSiteArray] removeAllObjects];
    for (NSString* key in favoriteSites){
        NSLog(@"Favorite %@",key);
        for (Site *site1 in [[DataManager shareInstance] siteArray]){
            if ([site1.name isEqualToString:key]) {
                [[[DataManager shareInstance] favoriteSiteArray] addObject:site1];
            }
        }
    }

    return FALSE;
}


-(void)viewWillAppear:(BOOL)animated{
//    self.naviTitle = [[UILabel alloc]initWithFrame:CGRectMake(110,6,100,32)];
//    self.naviTitle.text = @"YouBike";
//    self.naviTitle.font = [UIFont fontWithName:@"STHeitiSC-Light" size:22.];
//    self.naviTitle.textColor = [UIColor darkGrayColor];
//    self.naviTitle.backgroundColor = [UIColor clearColor];
//    [self.navigationController.navigationBar addSubview:self.naviTitle];
//    [self.tbView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{


    [self.naviTitle setText:@""];
}

#pragma mark - Table View


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([[[DataManager shareInstance] favoriteSiteArray ]count]>0) {
        return 2;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([[[DataManager shareInstance] favoriteSiteArray ]count]>0 && section==0) {
        return [[[DataManager shareInstance] favoriteSiteArray ]count];
    }
    
    return [[[DataManager shareInstance]siteArray] count];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([[[DataManager shareInstance] favoriteSiteArray ]count]>0 && indexPath.section==0) {
        SiteCell *siteCell = (SiteCell*)cell;
        siteCell.backgroundColor = [[DataManager shareInstance] favoriteColor];
        siteCell.lbCanRent.textColor = [UIColor whiteColor];
        siteCell.lbCanPark.textColor = [UIColor whiteColor];
        siteCell.lbName.textColor = [UIColor whiteColor];
        
    }
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([[[DataManager shareInstance] favoriteSiteArray ]count]>0 && indexPath.section==0) {
        return 70.;
    }
    
    return 50.;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([[[DataManager shareInstance] favoriteSiteArray ]count]>0 && indexPath.section==0) {
        SiteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BDCustomCell"];
        if (cell == nil) {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"SiteCell" owner:self options:nil];
            cell = [topLevelObjects objectAtIndex:0];
        }
        Site *site = [[[DataManager shareInstance]favoriteSiteArray] objectAtIndex:indexPath.row];
        [cell setName:site.name];
        [cell setCanRent:site.availBike];
        [cell setCanPark:site.capacity];
        [cell setBackgroundColor:[UIColor lightGrayColor]];
        
        return cell;
    }
    
    SiteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BDCustomCell"];
    if (cell == nil) {
        // Load the top-level objects from the custom cell XIB.
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"SiteCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    Site *site;
    if ([[[DataManager shareInstance]siteArray] count] > indexPath.row ) {
        site = [[[DataManager shareInstance]siteArray] objectAtIndex:indexPath.row];
        [cell setName:site.name];
        [cell setCanRent:site.availBike];
        [cell setCanPark:site.capacity];
    }
    

    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if (indexPath.row%2==0) {
//        [self.tbView.parallaxView.imageView setImage:[UIImage imageNamed:@"roadScene.jpg"]];
//    }else if (indexPath.row%2==1){
//        [self.tbView.parallaxView.imageView setImage:[UIImage imageNamed:@"riddingBike.jpg"]];
//    }
    
   
    
    NSMutableArray *favorite  =[[DataManager shareInstance] favoriteSiteArray];
    NSLog(@"%d / %d",indexPath.row,[favorite count]);
    if ([[[DataManager shareInstance] favoriteSiteArray ]count]>0 && indexPath.section==0) {
        //is favorite
        Site *site = [[[DataManager shareInstance] favoriteSiteArray] objectAtIndex:indexPath.row];
        DetailViewController *dv = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
        [dv setTitleName:site.name];
        [dv.lbCanRent setText:site.availBike];
        [dv.lbCanPark setText:site.capacity];
        [dv setCurrentSite:site];
        [dv goLocation:[site.lat doubleValue] andLon:[site.lng doubleValue] withName:site.name];
        [self.navigationController pushViewController:dv animated:YES];
        
    }else{
        
        
        Site *site = [[[DataManager shareInstance]siteArray] objectAtIndex:indexPath.row];
        //[self.tbView.parallaxView.imageView setImage:[self loadImageByLocation:site.lat andLon:site.lng]];
        DetailViewController *dv = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
        [dv setTitleName:site.name];
        [dv.lbCanRent setText:site.availBike];
        [dv.lbCanPark setText:site.capacity];
        [dv setCurrentSite:site];
        [dv goLocation:[site.lat doubleValue] andLon:[site.lng doubleValue] withName:site.name];
        [self.navigationController pushViewController:dv animated:YES];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    if ([[[DataManager shareInstance] favoriteSiteArray ]count]>0 && indexPath.section==0) {
        return YES;
    }
    return NO;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[[DataManager shareInstance] favoriteSiteArray] removeObjectAtIndex:indexPath.row];
    }
    [tableView reloadData];
}


-(void)initFavoriteColor{
    NSMutableDictionary *colorName = [[DataManager shareInstance] readFavoriteColor];
    NSLog(@"%@",colorName);
    
    for (NSString *key in colorName){
        if ([key isEqualToString:@"lightBlue"]) {
            [self loadcolor:1];
        }
        else if ([key isEqualToString:@"purple"]) {
            [self loadcolor:2];
        }
        else if ([key isEqualToString:@"purpleBlue"]) {
            [self loadcolor:3];
        }
        else if ([key isEqualToString:@"red"]) {
            [self loadcolor:4];
        }
    }
}

-(void)loadcolor:(int)x{
    
    switch (x) {
        case 1:
            //lightBlue
            [[DataManager shareInstance] setFavoriteColor:[UIColor colorWithRed:79./255. green:154./255. blue:234./255. alpha:1.]];
            break;
        case 2:
            //purple
            [[DataManager shareInstance] setFavoriteColor:[UIColor colorWithRed:155./255. green:82./255. blue:170./255. alpha:1.]];
            break;
        case 3:
            //purpleBlue
            [[DataManager shareInstance] setFavoriteColor:[UIColor colorWithRed:95./255. green:85./255. blue:170./255. alpha:1.]];
            break;
        case 4:
            //red
            [[DataManager shareInstance] setFavoriteColor:[UIColor colorWithRed:255./255. green:60./255. blue:74./255. alpha:1.]];
            break;
            
            
        default:
            break;
    }
}

@end
