//
//  ItemsViewController.m
//  Homepwner
//
//  Created by bhardy on 7/30/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import "AssignmentViewController.h"


@implementation AssignmentViewController

@synthesize course, webView;

- (id)init {
	[super initWithNibName:@"AssignmentView" bundle:nil];
	
	// Set the nav bar to have the back button when 
	// TeacherViewController is on top of the stack
	//[[self navigationItem] setBackBarButtonItem:[[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil]];
	
	// Set the title of the nav bar to Teachers when TeacherViewController
	// is on top of the stack
	
	// TODO change this to the name of the course
	
	[[self navigationItem] setTitle:@"Assignments"];
	
	return self;
}


- (void)viewDidLoad
{
	//URL Request Object
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:[course assignmentPage]];
	
	//Load the request in the UIWebView.
	[webView loadRequest:requestObj];
	[webView setDelegate:self];
	
	// Override point for customization after app launch
	//[AssignmentView makeKeyAndVisible];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	//[[self tableView] reloadData];
}
- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods
/*
 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 return 1;
 }
 
 // Customize the number of rows in the table view.
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 int numberOfRows = [teachers count];
 // If we are editing, we will have one more row than we have possessions
 if ([self isEditing])
 numberOfRows++;
 
 return numberOfRows;
 }
 
 // Customize the appearance of table view cells.
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
 // Check for a reusable cell first, use that if it exists 
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"]; 
 if (!cell)
 cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"] autorelease];	
 
 // If the table view is filling a row with a possession in it, do as normal 
 if ([indexPath row] < [teachers count])
 [[cell textLabel] setText:[[teachers objectAtIndex:[indexPath row]] description]];
 else // Otherwise, if we are editing we have one extra row - place this text in that row
 [[cell textLabel] setText:@"Add New Item..."];
 
 return cell;
 }
 
 
 - (void)tableView:(UITableView *)aTableView 
 didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
 //Do I need to create the instance of CourseDetailController?
 if (!courseViewController) {
 courseViewController = [[CourseViewController alloc] init];
 }
 
 [courseViewController setCourses:[[teachers objectAtIndex: [indexPath row]] courses]];
 
 // Push it onto the top of the navigation controller's stack
 [[self navigationController] pushViewController:courseViewController 
 animated:YES];
 }
 
 
 
 - (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView 
 editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath 
 {		
 if ([self isEditing] && [indexPath row] == [teachers count]) {
 // During editing...
 // The last row during editing will show an insert style button
 return UITableViewCellEditingStyleInsert;
 }
 return UITableViewCellEditingStyleDelete;
 }
 
 - (void)tableView:(UITableView *)tableView 
 commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
 forRowAtIndexPath:(NSIndexPath *)indexPath 
 {
 // If the table view is asking to commit a delete command...
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // We remove the row being deleted from the possessions array
 [teachers removeObjectAtIndex:[indexPath row]];
 // We also remove that row from the table view with an animation
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] 
 withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 
 }
 }
 
 - (void)tableView:(UITableView *)tableView 
 moveRowAtIndexPath:(NSIndexPath *)fromIndexPath 
 toIndexPath:(NSIndexPath *)toIndexPath 
 {
 // Get pointer to object being moved
 Teacher * p = [teachers objectAtIndex:[fromIndexPath row]];
 
 // Retain it... (retain count = 2, 1 for scope of this method, 1 for being inside array)
 [p retain];
 
 // Remove p from our array, it is automatically sent release (retain count of p = 1)
 [teachers removeObjectAtIndex:[fromIndexPath row]];
 
 // Re-insert p into array at new location, it is automatically retained (retain count of p = 2)
 [teachers insertObject:p atIndex:[toIndexPath row]];
 
 // Release p (retain count = 1, only owner is now array)
 [p release];
 }
 
 - (void)setEditing:(BOOL)flag animated:(BOOL)animated
 {
 // Always call super implementation of this method, it needs to do some work
 [super setEditing:flag animated:animated];
 // We need to insert/remove a new row in to table view to say "Add New Item..."
 if (flag) {
 // If entering edit mode, we add another row to our table view
 NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[teachers count] 
 inSection:0];
 [[self tableView] insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
 withRowAnimation:UITableViewRowAnimationLeft];	
 } else {
 // If leaving edit mode, we remove last row from table view
 NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[teachers count] 
 inSection:0];
 [[self tableView] deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] 
 withRowAnimation:UITableViewRowAnimationFade];
 }
 }
 
 - (BOOL)tableView:(UITableView *)tableView 
 canMoveRowAtIndexPath:(NSIndexPath *)indexPath 
 {
 // Only allow rows showing possessions to move
 if ([indexPath row] < [teachers count])
 return YES;
 return NO;
 }
 
 - (NSIndexPath *)tableView:(UITableView *)tableView 
 targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath 
 toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
 {
 if ([proposedDestinationIndexPath row] < [teachers count]) {
 // If we are moving to a row that currently is showing a possession,
 // then we return the row the user wanted to move to
 return proposedDestinationIndexPath;
 }
 // Execution gets here if we are trying to move a row to underneath the "Add New Item..."
 // row, have the moving row go one row above it instead.
 NSIndexPath *betterIndexPath = [NSIndexPath indexPathForRow:[teachers count] - 1 
 inSection:0];
 return betterIndexPath;
 }
 */

#pragma mark -
#pragma mark WebView
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
	NSLog(@"shouldStartLoadWithRequest");
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        [[UIApplication sharedApplication] openURL:request.URL];
        return NO;
    }
    return YES;
}





- (void)dealloc {
	//[detailViewController release];
	//[teachers release];
    [super dealloc];
}


@end

