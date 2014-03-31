//
//  PopoverViewController.m
//  SimpleSample
//
//  Created by Matthew Prockup on 10/7/13.
//  Copyright (c) 2013 Matthew Prockup. All rights reserved.
//

#import "PopoverViewController.h"

@interface PopoverViewController ()

@end

@implementation PopoverViewController

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    NSString* resoucePath = [[NSBundle mainBundle] resourcePath];
    NSArray* directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:resoucePath error:NULL];
    fullPaths = [[NSMutableArray alloc] init];
    fileNames = [[NSMutableArray alloc] init];
    int count = 0;
    for(int i = 0; i< [directoryContent count]; i++)
    {
        //NSLog(@"%d : %@/%@",i,resoucePath,[directoryContent objectAtIndex:i]);
        NSString* fp = [[NSString alloc] initWithFormat:@"%@/%@",resoucePath,[directoryContent objectAtIndex:i]];
        NSString* filename = [[NSString alloc] initWithString:[directoryContent objectAtIndex:i]];
        
        NSArray* componentsJawn = [filename componentsSeparatedByString:@"."];
        NSString* suffix = [componentsJawn objectAtIndex:([componentsJawn count]-1)];
        
        if([suffix compare:@"wav"] == 0)
        {
            count = count+1;
            NSLog(@"%d : %@/%@",count,resoucePath,[directoryContent objectAtIndex:i]);
            [fullPaths addObject:fp];
            [fileNames addObject:filename];
        }
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [fullPaths count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    
    // Configure the cell...
    cell.textLabel.text=[NSString stringWithFormat:@"%@",[fileNames objectAtIndex:indexPath.row]];
    
   
    return cell;
}

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

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    NSLog(@"Selected: %@", [fileNames objectAtIndex:[indexPath row]]);
    
}

@end
