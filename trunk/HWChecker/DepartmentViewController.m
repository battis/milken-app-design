//
//  ItemsViewController.m
//  Homepwner
//
//  Created by bhardy on 7/30/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import "DepartmentViewController.h"
#import "Department.h"
#import "TeacherViewController.h"

@implementation DepartmentViewController

- (id)init {
	[super initWithStyle:UITableViewStyleGrouped];
	
	// Create an array of 10 departments
	departments = [[NSMutableArray alloc] init];
	for (int i = 0; i < 10; i++) {
		[departments addObject:[Department randomDepartment]];
	}
	
	// Set the nav bar to have the back button when 
	// departmentViewController is on top of the stack
	//[[self navigationItem] setBackBarButtonItem:[[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil]];
	
	// Set the title of the nav bar to Departments when DepartmentViewController
	// is on top of the stack
	[[self navigationItem] setTitle:@"Departments"];
	
	return self;
}


- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[[self tableView] reloadData];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	int numberOfRows = [departments count];
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
	if ([indexPath row] < [departments count])
		[[cell textLabel] setText:[[departments objectAtIndex:[indexPath row]] description]];
	else // Otherwise, if we are editing we have one extra row - place this text in that row
		[[cell textLabel] setText:@"Add New Item..."];
	
	return cell;
}


- (void)tableView:(UITableView *)aTableView 
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	// Do I need to create the instance of TeacherDetailController?
	if (!teacherViewController) {
		teacherViewController = [[TeacherViewController alloc] init];
	}
	
	[teacherViewController setTeachers:[[departments objectAtIndex:[indexPath row]] teachers]];
		
	// Push it onto the top of the navigation controller's stack
	[[self navigationController] pushViewController:teacherViewController 
										   animated:YES];
}



- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView 
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath 
{		
	if ([self isEditing] && [indexPath row] == [departments count]) {
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
		[departments removeObjectAtIndex:[indexPath row]];
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
	Department * p = [departments objectAtIndex:[fromIndexPath row]];
	
	// Retain it... (retain count = 2, 1 for scope of this method, 1 for being inside array)
	[p retain];
	
	// Remove p from our array, it is automatically sent release (retain count of p = 1)
	[departments removeObjectAtIndex:[fromIndexPath row]];
	
	// Re-insert p into array at new location, it is automatically retained (retain count of p = 2)
	[departments insertObject:p atIndex:[toIndexPath row]];
	
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
		NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[departments count] 
													inSection:0];
		[[self tableView] insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
								withRowAnimation:UITableViewRowAnimationLeft];	
	} else {
		// If leaving edit mode, we remove last row from table view
		NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[departments count] 
													inSection:0];
		[[self tableView] deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] 
								withRowAnimation:UITableViewRowAnimationFade];
	}
}

- (BOOL)tableView:(UITableView *)tableView 
canMoveRowAtIndexPath:(NSIndexPath *)indexPath 
{
	// Only allow rows showing possessions to move
	if ([indexPath row] < [departments count])
		return YES;
	return NO;
}

- (NSIndexPath *)tableView:(UITableView *)tableView 
targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath 
	   toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
	if ([proposedDestinationIndexPath row] < [departments count]) {
		// If we are moving to a row that currently is showing a possession,
		// then we return the row the user wanted to move to
		return proposedDestinationIndexPath;
	}
	// Execution gets here if we are trying to move a row to underneath the "Add New Item..."
	// row, have the moving row go one row above it instead.
	NSIndexPath *betterIndexPath = [NSIndexPath indexPathForRow:[departments count] - 1 
													  inSection:0];
	return betterIndexPath;
}


- (void)dealloc {
	[teacherViewController release];
	[departments release];
    [super dealloc];
}


@end

