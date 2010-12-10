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
		NSString *mathString = @"Mathematics";
		NSString *englishString = @"English";
		NSLog(@"htmlCheck = %@", htmlCheck);
		
		NSRange mathStringRange = [htmlCheck rangeOfString:mathString];
		NSRange englishStringRange = [htmlCheck rangeOfString:englishString];
		
		NSLog(@"location: %d, length: %d", mathStringRange.location, mathStringRange.length);
		
		
		int mathLocation = mathStringRange.location;
		//int mathLastLocation = mathStringRange.length;
		
		int englishLocation = englishStringRange.location;
		//int englishLastLocation = englishStringRange.length;
		
		int counter = 0;
		
		for (int i=0; [htmlCheck characterAtIndex:englishLocation-i] == [htmlCheck characterAtIndex:mathLocation-i]; i++){
			counter = i;
			NSLog(@"for loop");
		}
		
		NSLog(@"%d",counter);
		
		NSRange leftRange = NSMakeRange(englishLocation-counter, englishLocation-1);
		
		NSString *leftString = [htmlCheck substringWithRange:leftRange]	;	
		NSLog(@"the string before english is: ");
		
		
		
		
		/*NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:@"<strong>[^<]*"
																		  options:0
																			error:&error];
		
		NSArray *matches = [regex matchesInString:htmlCheck 
										  options:0
											range:NSMakeRange(0,[htmlCheck length])];
		NSLog(@"%@", matches);
		
		for (NSTextCheckingResult *match in matches){
			NSLog(@"%@", [htmlCheck substringWithRange:[match range]]);
			
		}*/
		
	/*	NSRegularExpression *regexSecondPass = [[NSRegularExpression alloc] initWithPattern:@".[^web]*"
																		  options:0
																			error:&error];
		
		matches = [regexSecondPass matchesInString:htmlCheck 
										  options:0
											range:NSMakeRange(0,[htmlCheck length])];
		
		for (NSTextCheckingResult *match in matches){
			NSLog(@"%@", [htmlCheck substringWithRange:[match range]]);
		}*/
		
		
		

		
	}

	


@end
