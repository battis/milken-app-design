//
//  Copyright Milken Community High School All rights reserved.
//  Based on the "Homepwer" application created by bhardy.
//


#import "AssignmentViewController.h"


@implementation AssignmentViewController

@synthesize course, webView;

- (id)init {
	[super initWithNibName:@"AssignmentView" bundle:nil];
	return self;
}


- (void)viewDidLoad
{
	[webView setDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated
{
	//URL Request Object
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:[course assignmentPage]];
	
	//Set title to the current course
	NSString *courseName = [[NSString alloc] initWithFormat:@"%@", [course name]];
	[[self navigationItem] setTitle:courseName];
	[courseName release];
	//Load the request in the UIWebView.
	[webView loadRequest:requestObj];
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

}


#pragma mark Table view methods

-(void)webViewDidFinishLoad: (UIWebView *)webView
{
	//Stop Animating the Activity indicator when the webView finishes loading
	[activityIndicator stopAnimating];
}

#pragma mark -
#pragma mark WebView
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
	//If a link is clicked from the AssignmentViewController, open it in the appropriate application 
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        [[UIApplication sharedApplication] openURL:request.URL];
        return NO;
    }
return YES;
}





- (void)dealloc 
{
    [super dealloc];
}


@end

