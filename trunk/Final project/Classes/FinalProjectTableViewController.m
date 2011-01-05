//
//  FinalProjectTableViewController.m
//  Final project
//
//  Created by Jacob Cohen on 11/29/10.
//  Copyright 2010 Milken Community Jewish High School. All rights reserved.
//

#import "FinalProjectTableViewController.h"
#import "classes/models/Department.h"


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
		
		//use department names we already know to deduce the regular expression for finding the departments
		NSString *mathString = @"Mathematics";
		NSString *englishString = @"English";
		
		
		NSRange mathStringRange = [htmlCheck rangeOfString:mathString];
		NSRange englishStringRange = [htmlCheck rangeOfString:englishString];
		
		NSLog(@"location: %d, length: %d", mathStringRange.location, mathStringRange.length);
		
		
		int mathLocation = mathStringRange.location;
		int mathLength = mathStringRange.length;
		
		int englishLocation = englishStringRange.location;
		int englishLength = englishStringRange.length;
		
		int counter = 0;
		//run through each letter to the left of the department as long as the characters are equal
		for (int i=1; [htmlCheck characterAtIndex:englishLocation-i] == [htmlCheck characterAtIndex:mathLocation-i]; i++){
			counter = i;
		}
		
		NSLog(@"%d",counter);
		
		NSLog(@"we want a range from %d to %d", englishLocation-counter, englishLocation-1);
		
		NSRange leftRange = NSMakeRange(englishLocation-counter, counter);
		
		NSString *leftString = [htmlCheck substringWithRange:leftRange]	;	
		NSLog(@"the string before english is: %@", leftString);
	
		counter = 0;
		
		//run through each letter to the right of the department as long as the characters are equal
		for(int i=1; [htmlCheck characterAtIndex:englishLocation+englishLength+i] == [htmlCheck characterAtIndex:mathLocation+mathLength+i];i++){
			counter = i;
		}
		
		NSLog(@"%d",counter);

		NSRange rightRange = NSMakeRange(englishLocation+englishLength, counter);
		
		NSString *rightString = [htmlCheck substringWithRange:rightRange]	;

			NSLog(@"the string after english is: %@", rightString);
		
		//create the string for the regular expression to look for departments between leftString and rightString
		NSString *regexString= [[NSString alloc] initWithFormat:@"%@([\\w -]*[^ ])( */.*)* *%@", leftString, rightString];
		
		//create the regular expression
		NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:regexString
																		  options:0
																			error:&error];
		//run the regular expression and place the results into matches
		NSArray *matches = [regex matchesInString:htmlCheck 
										  options:0
											range:NSMakeRange(0,[htmlCheck length])];
		NSLog(@"%@", matches);
		//run through the array to get the departments
		for (int i = 0; i < ([matches count]-1); i++){
			NSString *departmentName = [htmlCheck substringWithRange:[[matches objectAtIndex:i] rangeAtIndex:1]];
			NSRange departmentNameRange = [[matches objectAtIndex:i] rangeAtIndex:1];
			NSRange nextDepartmentNameRange = [[matches objectAtIndex:i+1] rangeAtIndex:1];
			
			NSRange departmentRange = NSMakeRange(departmentNameRange.location, departmentNameRange.location - nextDepartmentNameRange.location);
			
			Department *currentDepartment = [[Department alloc] initWithName:departmentName];
			
			[departments addObject:currentDepartment];
			
			NSLog(@"%d", departmentRange.location);
			
			
		}
		
		
		
		
		//find teacher names from their email addresses by looking for @mchschool.org in the html
		
		NSString *emailFormat =@"@milkenschool.org";
		NSRange emailFormatRange = [htmlCheck rangeOfString:emailFormat];
		
		NSLog(@"range is: %d",emailFormatRange.location);
		counter = 0;
		
		for(int i=1; [htmlCheck characterAtIndex:emailFormatRange.location-i] != ':'; i++){
			counter = i;
		}
		
		regexString= @"(\\w)(\\w+)\\d*@milkenschool.org";
		
		//create the regular expression
		
		NSRegularExpression *regexTeachers = [[NSRegularExpression alloc] initWithPattern:regexString
																		  options:0
																			error:&error];
		
		
		NSArray *matchesTeachers = [regexTeachers matchesInString:htmlCheck 
										  options:0
											range:NSMakeRange(0,[htmlCheck length])];
	
		//run through the array to get the departments
		for (NSTextCheckingResult *matchTeachers in matchesTeachers){
		 NSString *lastName = [htmlCheck substringWithRange:[matchTeachers rangeAtIndex:2]];
			NSString *firstInitial = [htmlCheck substringWithRange:[matchTeachers rangeAtIndex:1]];
			NSString *teacherName = [[NSString alloc]initWithFormat:@"name:%@. %@", [firstInitial capitalizedString], [lastName capitalizedString]];
			NSRange teacherRange = [htmlCheck rangeOfString:lastName];
			
		}
		
		NSLog(@"%@", [htmlCheck substringWithRange:NSMakeRange(emailFormatRange.location-counter, counter)]);
		
		//Use the regular expression "(\w)(\w*)\d*@milkenschool.org" to find teacher names and first initial.
		
		/*to do list: 1) load ranges into departments
						2) find teacher names and put them into their 
						   3) corresponding departments based on their ranges*/
							 
		
		
	}

	


@end
