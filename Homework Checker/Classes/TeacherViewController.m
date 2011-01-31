//
//  ItemsViewController.m
//  Homepwner
//
//  Created by bhardy on 7/30/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import "TeacherViewController.h"
#import "Teacher.h"
#import "AssignmentViewController.h"
#import "CourseViewController.h"

@implementation TeacherViewController

@synthesize department;

- (id)init {
	[super initWithStyle:UITableViewStyleGrouped];
	return self;
}


- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[[self navigationItem] setTitle:[department name]];
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
	int numberOfRows = [[department teachers] count];
	return numberOfRows;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	// Check for a reusable cell first, use that if it exists 
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"]; 
	if (!cell)
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"] autorelease];	
	
	// If the table view is filling a row with a possession in it, do as normal 
	if ([indexPath row] < [[department teachers] count])
		[[cell textLabel] setText:[[[department teachers] objectAtIndex:[indexPath row]] description]];
	
	
	return cell;
}


- (void)tableView:(UITableView *)aTableView 
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	//Do I need to create the instance of CourseDetailController?
	if (!courseViewController) {
		courseViewController = [[CourseViewController alloc] init];
	}
	
	[courseViewController setTeacher:[[department teachers] objectAtIndex: [indexPath row]]];
	
	// Push it onto the top of the navigation controller's stack
	[[self navigationController] pushViewController:courseViewController 
										   animated:YES];
}


- (void)dealloc {
	//[detailViewController release];
	[department release];
    [super dealloc];
}


@end

