//
//  FinalProjectTableViewController.m
//  Final project
//
//  Created by Jacob Cohen on 11/29/10.
//  Copyright 2010 Milken Community Jewish High School. All rights reserved.
//

#import "Parser.h"
#import "Department.h"
#import "Teacher.h"


@implementation Parser

@synthesize departments, teachers, delegate;

- (id)init {
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
	return self;
	
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
	//I changed englishString to Athletics because Athletics was abnormal and had to be accounted for.
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
		if(counter == 17){
			break;}
	}
	
	NSLog(@"left counter is %d",counter);
	
	NSLog(@"we want a range from %d to %d", englishLocation-counter, englishLocation-1);
	
	NSRange leftRange = NSMakeRange(englishLocation-counter, counter);
	
	NSString *leftString = [htmlCheck substringWithRange:leftRange]	;	
	
	
	counter = 0;
	
	//run through each letter to the right of the department as long as the characters are equal
	for(int i=1; [htmlCheck characterAtIndex:englishLocation+englishLength+i] == [htmlCheck characterAtIndex:mathLocation+mathLength+i];i++){
		counter = i;
		if(counter == 16){
			break;}
		
	}
	
	NSLog(@"right counter is %d",counter);
	
	NSRange rightRange = NSMakeRange(englishLocation+englishLength, counter);
	
	NSString *rightString = [htmlCheck substringWithRange:rightRange];
	
	
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
	//NSLog(@"%@", matches);
	//run through the array to get the departments
	departments = [[NSMutableArray alloc] init];
	
	for (int i = 0; i < ([matches count]-1); i++){
		NSString *departmentName = [htmlCheck substringWithRange:[[matches objectAtIndex:i] rangeAtIndex:1]];
		NSRange departmentNameRange = [[matches objectAtIndex:i] rangeAtIndex:1];
		NSRange nextDepartmentNameRange = [[matches objectAtIndex:i+1] rangeAtIndex:1];
		
		NSRange departmentRange = NSMakeRange(departmentNameRange.location, nextDepartmentNameRange.location-departmentNameRange.location);
		
		Department *currentDepartment = [[Department alloc] initWithName:departmentName range:departmentRange];
		
		[departments addObject:currentDepartment];
		
		//NSLog(@"%@", departmentName);
		
		
	}
	
	
	for(int i=0;i< [departments count]; i++){
		NSLog(@"Department: %@ with range %d", [[departments objectAtIndex:i] name], [[departments objectAtIndex:i] range].location);
		
	}
	
	//find teacher names from their email addresses by looking for @mchschool.org in the html
	
	NSString *emailFormat =@"@milkenschool.org";
	NSRange emailFormatRange = [htmlCheck rangeOfString:emailFormat];
	
	NSLog(@"range is: %d",emailFormatRange.location);
	counter = 0;
	
	for(int i=1; [htmlCheck characterAtIndex:emailFormatRange.location-i] != ':'; i++){
		counter = i;
	}
	

	regexString = @"(\\w)(\\w+)\\d*@milkenschool.org";
	
	//create the regular expression
	
	NSRegularExpression *regexTeachersEmail = [[NSRegularExpression alloc] initWithPattern:regexString
																			  options:NSRegularExpressionCaseInsensitive
																	          error:&error];
	[regexString release];
	
	NSArray *matchesTeachers = [regexTeachersEmail matchesInString:htmlCheck 
													  options:0
														range:NSMakeRange(0,[htmlCheck length])];
	
	teachers = [[NSMutableArray alloc] init];
	NSString *fullName;
	
	//run through the array to get the departments
	for (NSTextCheckingResult *matchTeachers in matchesTeachers){
		NSString *lastName = [htmlCheck substringWithRange:[matchTeachers rangeAtIndex:2]];
		NSString *firstInitial = [htmlCheck substringWithRange:[matchTeachers rangeAtIndex:1]];
		NSString *teacherName = [[NSString alloc]initWithFormat:@"name:%@. %@", [firstInitial capitalizedString], [lastName capitalizedString]];
		NSRange teacherRange = [htmlCheck rangeOfString:lastName];
		NSString *fullName = [[NSString alloc]init];
		
		NSString *regexString = [NSString stringWithFormat:@"<td[^>]*>(%@.+%@.*)</td>", firstInitial, lastName];
		
		NSLog(@"%@", regexString);
		
		
		
		NSRegularExpression *regexTeachersEmail = [[NSRegularExpression alloc] initWithPattern:regexString
																					   options:NSRegularExpressionCaseInsensitive
																						error:&error];
								  
		NSArray *matchesTeachersNames = [regexTeachersEmail matchesInString:htmlCheck 
															   options:0
																	  range:NSMakeRange(0, htmlCheck.length)];
										 
										//replace regular expression range with this one 
										 //NSMakeRange(teacherRange.location-200, 200+teacherRange.length)];
										 
		NSLog(@"WRAH!!!%@",matchesTeachersNames);
		for (NSTextCheckingResult *matchTeachersNames in matchesTeachersNames){
			
		fullName = [htmlCheck substringWithRange:[matchTeachersNames rangeAtIndex:1]];
			NSLog(@"REGULAR EXPRESSION FOUND %@", fullName);
}
		Teacher *currentTeacher = [[Teacher alloc] initWithName:fullName];
		[teachers addObject:currentTeacher];
									
		
		for (int i=0; i<[departments count]; i++) {
			if (teacherRange.location>[[departments objectAtIndex:i] range].location && teacherRange.location<[[departments objectAtIndex:i]range].length+[[departments objectAtIndex:i] range].location) {
				NSLog(@"found one %@ in %@",teacherName, [[departments objectAtIndex:i] name]);
				[currentTeacher setDepartment:[departments objectAtIndex:i]];
				[[departments objectAtIndex:i] addTeacher:currentTeacher];
				break;
			}
			NSLog(@"%@ with range %d is not in %@ with range from %d to %d", teacherName,teacherRange.location,[[departments objectAtIndex:i] name],[[departments objectAtIndex:i]range].location ,[[departments objectAtIndex:i]range].length+[[departments objectAtIndex:i] range].location);
		}
		
	}
	
	NSLog(@"Teachers:");
	for (int i=0; i<[departments count]; i++) {
		
		NSLog(@"teachers in %@: %@", [[departments objectAtIndex:i] name], [[departments objectAtIndex:i] teachers]);
	}
	
	NSLog(@"the list of teachers: %@", teachers);
	//Use the regular expression "(\w)(\w*)\d*@milkenschool.org" to find teacher names and first initial.
	
	/*to do list: 1) load teacher pages
	 2) run through teacher html looking for text that is between /index"> and </A>
	 then navigate after the quote and keep reading the text to the left until you hit another quote.
	 
	 example :<A HREF="/ljames/precalchon/index">Pre Calculus Honors</A>

	 
	 */
	
	if(delegate)
	{
		[delegate parser:self didFinishParsingDepartments:departments];
	}
}




@end
