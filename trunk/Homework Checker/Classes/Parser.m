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

@synthesize departments, teacherBeingParsed, delegate;

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
	NSURL *milkenSite = [NSURL URLWithString:@"http://www.milkenschool.org/usfaculty/"];
	NSURLRequest *request = [NSURLRequest requestWithURL:milkenSite
											 cachePolicy:NSURLRequestReloadIgnoringCacheData
										  timeoutInterval:30];	
	if (connectionInProgress)
	{
		[connectionInProgress cancel];
		[connectionInProgress release];
	}
	
	//clear milkensite data, to load it up with html
	if (milkenSiteData)
	{
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
		NSString *htmlCheck = [[NSString alloc] initWithData:milkenSiteData encoding:NSUTF8StringEncoding];
		
		//use department names we already know to deduce the regular expression for finding the departments
		NSRange mathStringRange = [htmlCheck rangeOfString:@"Mathematics"];
		NSRange englishStringRange = [htmlCheck rangeOfString:@"English"];
		
		int mathLocation = mathStringRange.location;
		int mathLength = mathStringRange.length;
		
		int englishLocation = englishStringRange.location;
		int englishLength = englishStringRange.length;
		int counter = 0;
		
		//run through each letter to the left of the department as long as the characters are equal
		for (int i=1; [htmlCheck characterAtIndex:englishLocation-i] == [htmlCheck characterAtIndex:mathLocation-i]; i++){
			counter = i;
			// 2011-03-02 SDB: Why are we stopping at 17 characters?
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
		NSString *regexString= [NSString stringWithFormat:@"%@([\\w -]*[^ ])( */.*)* *%@", leftString, rightString];
		
		//create the regular expression
		NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString
																		  options:0
																			error:&error];
		
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
			
			[departments addObject:[[Department alloc] initWithName:departmentName range:departmentRange]];
		}
				
		/* Mr. Battis' full faculty info regex */
		NSString *facultyInfoPattern = @"<td[^>]*>(\\s*<span[^>]*>\\s*)?([^<]*)(((</span>)|(<br />))\\s*)?\\s*</td>\\s*<td[^>]*>.*<a.*mailto:([^\"]*)[^>]*>.*</td>\\s*<td[^>]*>.*<a.*faculty.[^\\.]+.org/([a-z0-9]+)";
		NSRegularExpression *facultyInfo =[NSRegularExpression regularExpressionWithPattern:facultyInfoPattern
																					 options:NSRegularExpressionCaseInsensitive
																					   error:&error];
		NSArray *matchesFacultyInfo = [facultyInfo matchesInString:htmlCheck 
															   options:0
																 range:NSMakeRange(0,[htmlCheck length])];
		for (NSTextCheckingResult *matchFacultyInfo in matchesFacultyInfo)
		{
			//NSString *teacherName = [htmlCheck substringWithRange:[matchFacultyInfo rangeAtIndex:2]];
			//NSString *teacherEmail = [htmlCheck substringWithRange:[matchFacultyInfo rangeAtIndex:7]];
			//NSString *userid = [htmlCheck substringWithRange:[matchFacultyInfo rangeAtIndex:8]];
			
			Teacher *currentTeacher = [[Teacher alloc] initWithName:[htmlCheck substringWithRange:[matchFacultyInfo rangeAtIndex:2]]];
			[currentTeacher setUserid:[htmlCheck substringWithRange:[matchFacultyInfo rangeAtIndex:8]]];
			[currentTeacher setEmail:[htmlCheck substringWithRange:[matchFacultyInfo rangeAtIndex:7]]];
			//[currentTeacher setName:[htmlCheck substringWithRange:[matchFacultyInfo rangeAtIndex:2]]];
			NSRange teacherRange = [htmlCheck rangeOfString:[NSString stringWithFormat:@"%@@", [currentTeacher userid]]];
					
			//checks the teacher's range and then matches it to a department based on that range
			for (int i=0; i<[departments count]; i++) {
				if (teacherRange.location>[[departments objectAtIndex:i] range].location && teacherRange.location<[[departments objectAtIndex:i]range].length+[[departments objectAtIndex:i] range].location) {
					[currentTeacher setDepartment:[departments objectAtIndex:i]];
					[[departments objectAtIndex:i] addTeacher:currentTeacher];
					break;
				}					
			}
			[currentTeacher release];
		}
	
		
		[htmlCheck release];

		
		if(delegate)
		{
			[[self delegate] parser:self didFinishParsingDepartments:departments];
		}
		
		
	}
	
	//if the parser is not parsing departments, parse courses.
	if (!parsingDepartments) {
		// NSLog(@"Look at me! I'm parsing courses for %@", [teacherBeingParsed name]);
		NSError *error = NULL;
		NSString *htmlCheck = [[NSString alloc] initWithData:milkenSiteData encoding:NSUTF8StringEncoding];
		
		//Search the teacher page for courses
		NSString *regexString = [NSString stringWithFormat:@"(http://faculty.milkenschool.org)?((/%@/.*/)|(?!(/%@))/.*/)index[^>]*>([^<]*)</a>", [teacherBeingParsed userid], [teacherBeingParsed userid]];
		
		NSRegularExpression *regexCourses = [NSRegularExpression regularExpressionWithPattern:regexString
																				 options:NSRegularExpressionCaseInsensitive
																				   error:&error];
		
		NSArray *matchesCourses = [regexCourses matchesInString:htmlCheck 
														options:0
														  range:NSMakeRange(0,[htmlCheck length])];
		
		
		
		
		for (NSTextCheckingResult *matchCourses in matchesCourses){
			
			NSString *currentCourseUrlName = [NSString stringWithFormat:@"http://faculty.milkenschool.org%@assignments/index", [htmlCheck substringWithRange:[matchCourses rangeAtIndex:2]]];
			//added stringByAddingPercentEscapesUsingEncoding to deal with URLs that have spaces in them
			NSURL *currentCourseUrl = [NSURL URLWithString:[currentCourseUrlName stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
			//NSString *currentCourseName = [htmlCheck substringWithRange:[matchCourses rangeAtIndex:5]];
			// NSLog(@"Courses %@ with URL %@", currentCourseName, currentCourseUrl);
			[[Course alloc] initWithName:[htmlCheck substringWithRange:[matchCourses rangeAtIndex:5]]
														taughtBy:teacherBeingParsed
												  assignmentPage:currentCourseUrl];
			
		
			
		}		
		
		// NSLog(@"%@ teaches %@", [teacherBeingParsed name], [teacherBeingParsed courses]);
		
		[htmlCheck release];
		
		if([self delegate])
		{
			[[self delegate] parser:self didFinishParsingCourses:teacherBeingParsed];
		}
	}
}

-(void)parseCourses:(Teacher *)teacherToBeParsed{
	//Take out the period and space in the teachers name
	// NSLog(@"parseCourses teacher is %@ (%@)",[teacherToBeParsed name], [teacherToBeParsed userid]);
	[self setTeacherBeingParsed:teacherToBeParsed];
	
	NSString *url = [NSString stringWithFormat:@"http://faculty.milkenschool.org/%@/index", [[self teacherBeingParsed] userid]];
	// NSLog(@"THIS TEACHERS ID IS %@",[teacherToBeParsed userid]);
	NSURL *teacherSite = [NSURL URLWithString:url];
	
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
	// NSLog(@"%@", teacherSite);
}

- (void)dealloc 
{
	if (connectionInProgress) 
	{
		[connectionInProgress release];
	}
	if (milkenSiteData)
	{
		[milkenSiteData release];
	}
    [super dealloc];

}

@end
