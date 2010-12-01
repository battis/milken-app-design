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
		NSString *htmlCheck = [[[NSString alloc] initWithData:milkenSiteData encoding:NSUTF8StringEncoding] autorelease];
		NSLog(@"htmlCheck = %@", htmlCheck);
		
		NSXMLParser *parser = [[NSXMLParser alloc] initWithData:milkenSiteData];
		[parser setDelegate:self];
		[parser parse];
		[parser release];
		NSLog(@"%@", classes);
	}

- (void)parser:(NSXMLParser *)parser
foundCharacters:(NSString *)string
{
	[titleString appendString:string];
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
	if ([elementName isEqual:@"tbody"])
	{
		NSLog(@"found table");
	}
	
	if ([elementName isEqual:@"tr"])
	{
		NSLog(@"%@", elementName);
		waitingForEntryTitle = NO;
	}
	
	if ([elementName isEqual:@"td"]){
		NSLog(@"ended a song entry");
	}
}
	


@end
