//
//  FinalProjectTableViewController.m
//  Final project
//
//  Created by Jacob Cohen on 11/29/10.
//  Copyright 2010 Milken Community Jewish High School. All rights reserved.
//

#import "FinalProjectTableViewController.h"


@implementation FinalProjectTableViewController

- (void) loadClasses {
NSURL *milkenSite;
milkenSite = [[NSURL alloc]initWithString:@"http://www.milkenschool.org/usfaculty/"];
NSURLRequest *request = [NSURLRequest requestWithURL:milkenSite
										 cachePolicy:NSURLRequestReloadIgnoringCacheData
									 timeoutInterval:30];

if (connectionInProgress)
{
	[connectionInProgress cancel];
	[connectionInProgress release];
}

milkenSiteData = [[NSMutableData alloc] init];
connectionInProgress = [[NSURLConnection alloc] initWithRequest:request
													   delegate:self
											   startImmediately:YES];
NSLog(@"%@", milkenSite);
	
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[milkenSiteData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
	{
		NSError *error = NULL;
		NSString *htmlCheck = [[[NSString alloc] initWithData:milkenSiteData encoding:NSUTF8StringEncoding] autorelease];
		NSLog(@"htmlCheck = %@", htmlCheck);
		
		NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:@"httml://[^\"']"
																   options:NSMatchingWithTransparentBounds
																	 error:&error];
		NSTextCheckingResult *regexResult = [[NSCheckingResult alloc]initWithC]
		[regex enumerateMatchesInString:htmlCheck
								options:NSMatchingWithTransparentBounds
								  range:NSMakeRange(0, [htmlCheck length])
							 usingBlock:
				
	}

	


@end
