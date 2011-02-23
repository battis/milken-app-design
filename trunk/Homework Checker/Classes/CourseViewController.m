//
//  Copyright Milken Community High School All rights reserved.
//  Based on the "Homepwer" application created by bhardy.
//


#import "CourseViewController.h"
#import "Course.h"
#import "AssignmentViewController.h"
#import "Parser.h"

@implementation CourseViewController

@synthesize activityIndicator; webView;

- (id)init {
	[super initWithStyle:UITableViewStyleGrouped];
	parser = [[Parser alloc] init];
	[parser setDelegate:self];
	needToParseTeacher = NO;
	//Do NOT parse the teachers as they have already been parsed for the DepartmentViewController
	
	
	[self setActivityIndicator:[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]];
	[activityIndicator setCenter:CGPointMake([self view].frame.size.width/2,self.view.frame.size.height/2)];
	
	[self.view addSubview:activityIndicator];
	return self;
	
	if (webView) {
		[webView release];
}


- (void)viewWillAppear:(BOOL)animated
//Parse the teacher's courses and show/animate the activity indicator
{
	[super viewWillAppear:animated];
	[[self navigationItem] setTitle:[teacher name]];
	[[self tableView] reloadData];
	if (needToParseTeacher)
	{
		needToParseTeacher = NO;
		[activityIndicator startAnimating];
		[parser parseCourses:teacher];
	}
}

- (void)viewDidLoad;
{
	
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

// Dictates number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	int numberOfRows = [[teacher courses] count];

	
	return numberOfRows;
}

// Dictates appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	// Check for a reusable cell first, use that if it exists 
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"]; 
	if (!cell)
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"] autorelease];	
	
	// If the table view is filling a row with a possession in it, do as normal 
	if ([indexPath row] < [[teacher courses] count])
		[[cell textLabel] setText:[[[teacher courses] objectAtIndex:[indexPath row]] description]];
	
	
	return cell;
}

-(id)setTeacher:(Teacher *) theTeacher
{
	[teacher autorelease];
	teacher = [theTeacher retain];
	if ([[teacher courses] count] == 0)
	{
		needToParseTeacher = YES;
	}
	return teacher;
}



- (void)tableView:(UITableView *)aTableView 
didSelectRowAtIndexPath:(NSIndexPath *)indexPath

//Do I need to create an instance of assignmentviewcontroller?
{		
	if(!assignmentViewController)
	{
		assignmentViewController = [[AssignmentViewController alloc] init];
	}
	[assignmentViewController setCourse:[[teacher courses] objectAtIndex:[indexPath row]]];
	[[self navigationController] pushViewController:assignmentViewController animated:YES];
}


- (void)dealloc {
	[parser release];
    [super dealloc];
}

#pragma mark ParserDelegate

//Tells the app what to do when the parser finishes parsing 
-(void)parser:(Parser *) theParser didFinishParsingCourses:(Teacher *) theTeacher
{
	//NSLog(@"CourseViewController received the following courses:\n%@", [theTeacher courses]);
	[teacher autorelease];
	teacher = [theTeacher retain];
	[activityIndicator stopAnimating];
	[[self tableView] reloadData];
	
}
//Tells the parser when it is done parsing departments and what to do (NSMutableArray)
-(void)parser:(Parser *)theParser didFinishParsingDepartments:(NSMutableArray *) theDepartments
{}

@end

