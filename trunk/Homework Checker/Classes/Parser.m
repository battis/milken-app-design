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
#import "Course.h"


@implementation Parser

@synthesize departments, teachers, delegate, teacherBeingParsed;

- (id)init {
	[super init];
	return self;
	
}

/*Goes through the html of the milken faculty page and then pulls out the
	departments and teachers, and assigns teachers to departments based on their place in the html
 */
-(void)parseDepartments
{
	parsingDepartments = YES;
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
	
	//clear milkensite data, to load it up with html
	if (milkenSiteData) {
		[milkenSiteData release];
	}
	
	milkenSiteData = [[NSMutableData alloc] init];
	connectionInProgress = [[NSURLConnection alloc] initWithRequest:request
														   delegate:self
												   startImmediately:YES];
	
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[milkenSiteData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	if (parsingDepartments) {
	
	
	NSError *error = NULL;
	NSString *htmlCheck = [[[NSString alloc] initWithData:milkenSiteData encoding:NSUTF8StringEncoding] autorelease];
	
	//use department names we already know to deduce the regular expression for finding the departments
	NSString *mathString = @"Mathematics";
	NSString *englishString = @"English";
	
	NSRange mathStringRange = [htmlCheck rangeOfString:mathString];
	NSRange englishStringRange = [htmlCheck rangeOfString:englishString];
	
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
	
	
	//assign left range
	NSRange leftRange = NSMakeRange(englishLocation-counter, counter);
	NSString *leftString = [htmlCheck substringWithRange:leftRange];	
	counter = 0;
	
	//run through each letter to the right of the department as long as the characters are equal to ensure an accurate regular expression
	for(int i=1; [htmlCheck characterAtIndex:englishLocation+englishLength+i] == [htmlCheck characterAtIndex:mathLocation+mathLength+i];i++){
		counter = i;
		if(counter == 16){
			break;}
		
	}
	
	//assign right range
	NSRange rightRange = NSMakeRange(englishLocation+englishLength, counter);
	NSString *rightString = [htmlCheck substringWithRange:rightRange];
	
	
	//create the string for the regular expression to look for departments between leftString and rightString
	NSString *regexString= [[NSString alloc] initWithFormat:@"%@([\\w -]*[^ ])( */.*)* *%@", leftString, rightString];
	
	//create the regular expression
	NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:regexString
																	  options:0
																		error:&error];
		[regexString release];	
		
	//run the regular expression and place the results into matches
	NSArray *matches = [regex matchesInString:htmlCheck 
									  options:0
										range:NSMakeRange(0,[htmlCheck length])];

	//create an array to package the departments to send to departmentViewController	
	departments = [[NSMutableArray alloc] init];
		
	//run through the departments array to get the departments	
	for (int i = 0; i < ([matches count]-1); i++){
		NSString *departmentName = [htmlCheck substringWithRange:[[matches objectAtIndex:i] rangeAtIndex:1]];
		NSRange departmentNameRange = [[matches objectAtIndex:i] rangeAtIndex:1];
		NSRange nextDepartmentNameRange = [[matches objectAtIndex:i+1] rangeAtIndex:1];
		
		NSRange departmentRange = NSMakeRange(departmentNameRange.location, nextDepartmentNameRange.location-departmentNameRange.location);
		
		Department *currentDepartment = [[Department alloc] initWithName:departmentName range:departmentRange];
		
		[departments addObject:currentDepartment];
	}
		
		
		[regex release];
	
		
	//find teacher names from their email addresses by looking for @mchschool.org in the html
	NSString *emailFormat =@"@milkenschool.org";
	NSRange emailFormatRange = [htmlCheck rangeOfString:emailFormat];
	
	//NSLog(@"range is: %d",emailFormatRange.location);
	counter = 0;
	
	for(int i=1; [htmlCheck characterAtIndex:emailFormatRange.location-i] != ':'; i++){
		counter = i;
	}
	
	
		regexString = @"((\\w)(\\w+)\\d*)@milkenschool.org";
	
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
	NSString *userid;
	
	//run through the array to get the teachers
	for (NSTextCheckingResult *matchTeachers in matchesTeachers){
		NSString *lastName = [htmlCheck substringWithRange:[matchTeachers rangeAtIndex:3]];
		NSString *firstInitial = [htmlCheck substringWithRange:[matchTeachers rangeAtIndex:2]];
		NSString *teacherName = [[NSString alloc]initWithFormat:@"%@. %@", [firstInitial capitalizedString], [lastName capitalizedString]];
		NSString *userid = [htmlCheck substringWithRange:[matchTeachers rangeAtIndex:1]];
		NSRange teacherRange = [htmlCheck rangeOfString:userid];
		NSString *fullName = [[NSString alloc]init];
		
		
		NSLog(@"teacher with userid %@ has range %d", userid, teacherRange);
		
		[regexString release];
		
		NSString *regexString = [[NSString alloc] initWithFormat:@"<td[^>]*>(.*)</td>", firstInitial, lastName];
		
		//NSLog(@"%@", regexString);
		
		
		
		NSRegularExpression *regexTeachersEmail = [[NSRegularExpression alloc] initWithPattern:regexString
																					   options:NSRegularExpressionCaseInsensitive
																						 error:&error];
		
		NSArray *matchesTeachersNames = [regexTeachersEmail matchesInString:htmlCheck 
																	options:0
																	  range:NSMakeRange(teacherRange.location-200, 200+teacherRange.length)];
		
		
		
		//NSLog(@"WRAH!!!%@",matchesTeachersNames);
		for (NSTextCheckingResult *matchTeachersNames in matchesTeachersNames){
			
			fullName = [htmlCheck substringWithRange:[matchTeachersNames rangeAtIndex:1]];
		}
		
		[regexTeachersEmail release];
		Teacher *currentTeacher = [[Teacher alloc] initWithName:teacherName];
		[currentTeacher setUserid:userid];
		[teachers addObject:currentTeacher];
		
		
		for (int i=0; i<[departments count]; i++) {
			if (teacherRange.location>[[departments objectAtIndex:i] range].location && teacherRange.location<[[departments objectAtIndex:i]range].length+[[departments objectAtIndex:i] range].location) {
				[currentTeacher setDepartment:[departments objectAtIndex:i]];
				[[departments objectAtIndex:i] addTeacher:currentTeacher];
				break;
			}
			
			//NSLog(@"%@ with range %d is not in %@ with range from %d to %d", teacherName,teacherRange.location,[[departments objectAtIndex:i] name],[[departments objectAtIndex:i]range].location ,[[departments objectAtIndex:i]range].length+[[departments objectAtIndex:i] range].location);
		}
		
		[regexString release];
		
	}
		
		
		
		[regexTeachersEmail release];
	
	NSLog(@"Teachers:");
	for (int i=0; i<[departments count]; i++) {
		
		//NSLog(@"teachers in %@: %@", [[departments objectAtIndex:i] name], [[departments objectAtIndex:i] teachers]);
	}
	
	NSLog(@"the list of teachers: %@", teachers);
	//Use the regular expression "(\w)(\w*)\d*@milkenschool.org" to find teacher names and first initial.
	

	 
	 
	
	if(delegate)
	{
		[delegate parser:self didFinishParsingDepartments:departments];
	}
}

	
	if (!parsingDepartments) {
		NSLog(@"Look at me! I'm parsing courses for %@", [teacherBeingParsed name]);
		NSError *error = NULL;
		NSString *htmlCheck = [[[NSString alloc] initWithData:milkenSiteData encoding:NSUTF8StringEncoding] autorelease];
		
		NSString *regexString = [[NSString alloc] initWithFormat:@"(http://faculty.milkenschool.org)?((/%@/.*/)|(?!(/%@))/.*/)index[^>]*>([^<]*)</a>", [teacherBeingParsed userid], [teacherBeingParsed userid]];
		
		//create the regular expression
		NSRegularExpression *regexCourses = [[NSRegularExpression alloc] initWithPattern:regexString
																					   options:NSRegularExpressionCaseInsensitive
																						 error:&error];
		[regexString release];
		
		NSArray *matchesCourses = [regexCourses matchesInString:htmlCheck 
															   options:0
																 range:NSMakeRange(0,[htmlCheck length])];
		

		
		
		for (NSTextCheckingResult *matchCourses in matchesCourses){
			
			NSString *currentCourseUrlName = [[NSString alloc] initWithFormat:@"http://faculty.milkenschool.org%@assignments/index", [htmlCheck substringWithRange:[matchCourses rangeAtIndex:2]]];
			NSURL *currentCourseUrl = [[NSURL alloc] initWithString:currentCourseUrlName];
			//PROBLEM: the range at index is wrong but any value of 1 or 4 crashes it
			NSString *currentCourseName = [htmlCheck substringWithRange:[matchCourses rangeAtIndex:5]];
			NSLog(@"Courses %@ with URL %@", currentCourseName, currentCourseUrl);
			Course *currentCourse = [[Course alloc] initWithName:currentCourseName
													   taughtBy:teacherBeingParsed
												 assignmentPage:currentCourseUrl];
			
			NSLog(@"%@ teaches %@", [teacherBeingParsed name], [teacherBeingParsed courses]);
				
		}		
		
		
		[regexCourses release];
		
		if(delegate)
		{
			[delegate parser:self didFinishParsingCourses:teacherBeingParsed];
		}
		
		
		
		
		
		
	}
}
-(void)parseCourses:(Teacher *)teacherToBeParsed{
	NSURL *teacherSite;
	//Take out the period and space in the teachers name
	NSString *teacherOfCourseName = [teacherToBeParsed name];
	NSLog(@"parseCourses teacher is %@ (%@)",teacherOfCourseName, [teacherToBeParsed userid]);
	teacherBeingParsed = teacherToBeParsed;
	
		NSString *url = [[NSString alloc] initWithFormat:@"http://faculty.milkenschool.org/%@/index", [teacherToBeParsed userid]];
	teacherSite = [[NSURL alloc]initWithString:url];
	
	NSURLRequest *courseRequest = [NSURLRequest requestWithURL:teacherSite
											 cachePolicy:NSURLRequestReloadIgnoringCacheData
										 timeoutInterval:30];
	
	if (connectionInProgress)
	{
		[connectionInProgress cancel];
		[connectionInProgress release];
	}
	
	if (milkenSiteData) {
		[milkenSiteData release];
	}
	milkenSiteData = [[NSMutableData alloc] init];
	connectionInProgress = [[NSURLConnection alloc] initWithRequest:courseRequest
														   delegate:self
												   startImmediately:YES];
	NSLog(@"%@", teacherSite);
	
	[url release];
	[teacherSite release];
	
	
}

- (void)dealloc 
{
    [super dealloc];
}










@end
