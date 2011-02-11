//
//  SplashScreenViewController.m
//  Homework Checker
//
//  Created by (11) Aaron Daniel on 2/9/11.
//  Copyright 2011 Milken Community High School. All rights reserved.
//

#import "SplashScreenViewController.h"

@synthesize activityIndicator;

@implementation SplashScreenViewController

- (id)init {
	[super initWithNibName:@"SplashScreenView" bundle:nil];
	[[self navigationItem] setTitle:@"Homework Checker"];
	[self setActivityIndicator:[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]];
	[activityIndicator setCenter:CGPointMake([self view].frame.size.width/2,self.view.frame.size.height/2)];
	
	[self.view addSubview:activityIndicator];
	return self;
	
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	self.navigationItem.hidesBackButton = YES;
	[activityIndicator startAnimating];
	
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


- (void)dealloc {
    [super dealloc];
}


@end
