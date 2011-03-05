//
//  Copyright Milken Community High School All rights reserved.
//  Based on the "Homepwer" application created by bhardy.
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

}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

// Dictates the number of rows in the table view (# of teachers)
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	int numberOfRows = [[department teachers] count];
	return numberOfRows;
}

// Dictates the appearance of table view cells.
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
	//Do I need to create the instance of CourseViewController?
	if (!courseViewController) {
		courseViewController = [[CourseViewController alloc] init];
	}
	
	[courseViewController setTeacher:[[department teachers] objectAtIndex: [indexPath row]]];
	
	// Push it onto the top of the navigation controller's stack
	[[self navigationController] pushViewController:courseViewController 
										   animated:YES];
}


- (void)dealloc {

	[department release];
    [super dealloc];
}


@end

