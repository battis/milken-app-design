//
//  Copyright Milken Community High School All rights reserved.
//  Based on the "Homepwer" application created by bhardy.
//

#import "DepartmentViewController.h"
#import "Department.h"
#import "TeacherViewController.h"
#import "Parser.h"


@implementation DepartmentViewController

@synthesize teachers;
@synthesize departments;
@synthesize activityIndicator;

- (id)init {
	[super initWithStyle:UITableViewStyleGrouped];
	// Activate/declare parser for future use (does not begin parsing)
	parser = [[Parser alloc] init];
	[parser setDelegate:self];
	
	
	// Set the title of the nav bar to Departments when DepartmentViewController
	// is on top of the stack
	[[self navigationItem] setTitle:@"Departments"];
	
	[self setActivityIndicator:[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]];
	[activityIndicator setCenter:CGPointMake([self view].frame.size.width/2,self.view.frame.size.height/2)];
	
	[self.view addSubview:activityIndicator];
	
	return self;
}

//Brings up the view on which the user interacts with the application.
- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
}
- (void)viewDidLoad;
//Start the activity indicator and tell the parser to parse the departments web page and give out the array.
{
	[activityIndicator startAnimating];
	[parser parseDepartments];
	
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


// Tells the table view how many cells (number of rows) it will need to display (# of departments)
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	int numberOfRows = [departments count];
	
	
	return numberOfRows;
}

// Dictates the ppearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	// Check for a reusable cell first, use that if it exists 
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"]; 
	if (!cell)
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"] autorelease];	
	
	// If the table view is filling a row with a possession in it, do as normal 
	if ([indexPath row] < [departments count])
		[[cell textLabel] setText:[[departments objectAtIndex:[indexPath row]] description]];
	
	
	return cell;
}


- (void)tableView:(UITableView *)aTableView 
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	// Do I need to create the instance of TeacherViewController?
	if (!teacherViewController) {
		teacherViewController = [[TeacherViewController alloc] init];
	}
	
	[teacherViewController setDepartment:[departments objectAtIndex:[indexPath row]]];
	
	// Push it onto the top of the navigation controller's stack
	[[self navigationController] pushViewController:teacherViewController 
										   animated:YES];
}

//deallocate/release the following from memory
- (void)dealloc {
	[teacherViewController release];
	[departments release];
    [super dealloc];
}

#pragma mark -
#pragma mark ParserDelegate

//Tells the app what to do when the parser finishes parsing
-(void)parser:(Parser *) theParser didFinishParsingDepartments:(NSMutableArray *) theDepartments
{
	[self setDepartments:theDepartments];
	//load data onto the data table
	[[self tableView] reloadData];
	//stop activity indicator
	[activityIndicator stopAnimating];
	
}

-(void)parser:(Parser *) theParser didFinishParsingCourses:(Teacher *) theTeacher
{
	//realease the parser from memory
	[parser release];
	
}


@end

