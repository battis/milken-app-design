//
//  Copyright Milk N' Cookies App Design All rights reserved.
//


#import "SplashScreenViewController.h"

@implementation SplashScreenViewController

#pragma mark -
#pragma mark Memory Management

- (id)init {
	[super initWithNibName:@"SplashScreenView" bundle:nil];
	[[self navigationItem] setTitle:@"Homework Checker"];
	return self;
}

- (void)dealloc {
    [super dealloc];
}

#pragma mark -
#pragma mark View Controller

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	self.navigationItem.hidesBackButton = YES;
	
}

- (void) viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}




@end
