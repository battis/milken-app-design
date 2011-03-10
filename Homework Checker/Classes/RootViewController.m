//
//  RootViewController.m
//  Homework Checker v2
//
//  Created by Seth Battis on 3/5/11.
//  Copyright 2011 Milken Community High School. All rights reserved.
//

#import "RootViewController.h"
#import "SplashScreenViewController.h"
#import "Department.h";

#define SPLASH_SCREEN_DELAY 3 // seconds

@implementation RootViewController

@synthesize parser;
@synthesize departments;
@synthesize teacherView;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	// set title
	[self.navigationItem setTitle:@"Departments"];

	/* show splash screen */
	SplashScreenViewController *splash = [[SplashScreenViewController alloc] init];
	[[self navigationController] pushViewController:splash
										   animated:NO];
	[splash release];
	[NSTimer scheduledTimerWithTimeInterval:SPLASH_SCREEN_DELAY
									 target:self
								   selector:@selector(closeSplashScreen:)
								   userInfo:nil
									repeats:NO];

	/* if no departments, parse them */
	parser = [[Parser alloc] init];
	[parser setDelegate:self];
	parsing = YES;
	[parser parseDepartments];
}

/*
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
	[[self tableView] reloadData];
}
*/

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */


#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self departments] count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	// Configure the cell.
	if ([indexPath row] < [departments count])
		[[cell textLabel] setText:[[departments objectAtIndex:[indexPath row]] description]];

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
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	// Do I need to create the instance of TeacherViewController?
	if (!teacherView) {
		[self setTeacherView:[[TeacherViewController alloc] init]];
	}
	
	[teacherView setDepartment:[departments objectAtIndex:[indexPath row]]];
	
	// Push it onto the top of the navigation controller's stack
	[[self navigationController] pushViewController:teacherView 
										   animated:YES];
}

#pragma mark -
#pragma mark Parser Delegate

-(void)parser:(Parser *) theParser didFinishParsingDepartments:(NSMutableArray *) theDepartments
{
	parsing = NO;
	[self setDepartments:theDepartments];
	[[self tableView] reloadData];
}

-(void)parser:(Parser *) theParser didFinishParsingCourses:(Teacher *) theTeacher
{
	NSLog(@"The root view controller received a didFinishParsingCourses callback. This is an error.");
}

#pragma mark -
#pragma mark Timer Callbacks

- (void)closeSplashScreen:(NSTimer *)timer
{
	if (parsing)
	{
		[NSTimer scheduledTimerWithTimeInterval:0.1
										 target:self
									   selector:@selector(closeSplashScreen:)
									   userInfo:nil
										repeats:NO];
	}
	else
	{
		[[self navigationController] popToViewController:self animated:YES];
	}
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc
{
    [super dealloc];
}

@end

