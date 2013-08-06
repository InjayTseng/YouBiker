//
//  SettingsDetailViewController.m
//  YouBikeBest
//
//  Created by injay on 13/5/15.
//  Copyright (c) 2013年 injay. All rights reserved.
//

#import "SettingsDetailViewController.h"
#import "DataManager.h"
#import "JLActionSheet.h"

@interface SettingsDetailViewController ()<JLActionSheetDelegate>
@property (nonatomic, strong) JLActionSheet* actionSheet;
@end

@implementation SettingsDetailViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    
    [self.btnColor1 setTag:1];
    [self.btnColor2 setTag:2];
    [self.btnColor3 setTag:3];
    [self.btnColor4 setTag:4];
    
    [self.btnColor1 addTarget:self
                       action:@selector(changeColor:)
             forControlEvents:UIControlEventTouchUpInside];
    [self.btnColor2 addTarget:self
                       action:@selector(changeColor:)
             forControlEvents:UIControlEventTouchUpInside];
    [self.btnColor3 addTarget:self
                       action:@selector(changeColor:)
             forControlEvents:UIControlEventTouchUpInside];
    [self.btnColor4 addTarget:self
                       action:@selector(changeColor:)
             forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)loadcolor:(int)x{
    
    switch (x) {
        case 1:
            //lightBlue
            [[DataManager shareInstance] setFavoriteColor:[UIColor colorWithRed:79./255. green:154./255. blue:234./255. alpha:1.]];
            [self moveIndicator:self.btnColor1.frame.origin.x];
            break;
        case 2:
            //purple
            [[DataManager shareInstance] setFavoriteColor:[UIColor colorWithRed:155./255. green:82./255. blue:170./255. alpha:1.]];
            [self moveIndicator:self.btnColor2.frame.origin.x];
            break;
        case 3:
            //purpleBlue
            [[DataManager shareInstance] setFavoriteColor:[UIColor colorWithRed:95./255. green:85./255. blue:170./255. alpha:1.]];
            [self moveIndicator:self.btnColor3.frame.origin.x];
            break;
        case 4:
            //red
            [[DataManager shareInstance] setFavoriteColor:[UIColor colorWithRed:255./255. green:60./255. blue:74./255. alpha:1.]];
            [self moveIndicator:self.btnColor4.frame.origin.x];
            break;
            
            
        default:
            break;
    }
}


-(void)changeColor:(id)sender{
    
    UIButton *pressedButton = sender;
    switch (pressedButton.tag) {
        case 1:
            //lightBlue
            [[DataManager shareInstance] setFavoriteColor:[UIColor colorWithRed:79./255. green:154./255. blue:234./255. alpha:1.]];
            [[DataManager shareInstance] writeNewFavoriteColor:@"lightBlue"];
            break;
        case 2:
            //purple
            [[DataManager shareInstance] setFavoriteColor:[UIColor colorWithRed:155./255. green:82./255. blue:170./255. alpha:1.]];
            [[DataManager shareInstance] writeNewFavoriteColor:@"purple"];
            break;
        case 3:
            //purpleBlue
            [[DataManager shareInstance] setFavoriteColor:[UIColor colorWithRed:95./255. green:85./255. blue:170./255. alpha:1.]];
            [[DataManager shareInstance] writeNewFavoriteColor:@"purpleBlue"];
            break;
        case 4:
            //red
            [[DataManager shareInstance] setFavoriteColor:[UIColor colorWithRed:255./255. green:60./255. blue:74./255. alpha:1.]];
            [[DataManager shareInstance] writeNewFavoriteColor:@"red"];
            break;
            
            
        default:
            break;
    }
    //NSLog(@"move to %f",pressedButton.frame.origin.x);
    [self moveIndicator:pressedButton.frame.origin.x];
}

-(void)moveIndicator:(CGFloat)x{
    
    CGRect frame = self.vwIndicator.frame;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    [self.vwIndicator setFrame:CGRectMake(x,frame.origin.y,frame.size.width,frame.size.height)];
    [UIView commitAnimations];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
 */

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void) actionSheet:(JLActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    switch (buttonIndex) {
        case 0:
            NSLog(@"0");
            break;
        case 1:
            NSLog(@"清除我的最愛");
            [[[DataManager shareInstance] favoriteSiteArray] removeAllObjects];
            if (1) {

                NSMutableDictionary *favoriteSites = [NSMutableDictionary dictionaryWithCapacity:0];
                [[DataManager shareInstance]writeNewFavoriteSites:favoriteSites];
            }
            break;

        default:
            break;
    }
    
}
- (void) actionSheet:(JLActionSheet*)actionSheet didDismissButtonAtIndex:(NSInteger)buttonIndex{
    
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.tag == 999) {

        self.actionSheet = [[JLActionSheet alloc]initWithTitle:@""
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@[@"清除我的最愛 -"]];
        
        [self.actionSheet allowTapToDismiss:YES];
        [self.actionSheet setStyle:JLSTYLE_SUPERCLEAN];
        [self.actionSheet showOnViewController:self];
            
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
