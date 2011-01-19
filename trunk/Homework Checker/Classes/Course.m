//
//  Course.m
//  Homework Checker
//
//  Created by Seth Battis on 12/7/10.
//  Copyright 2010 Milken Community High School. All rights reserved.
//

#import "Course.h"


@implementation Course

@synthesize name, teacher, assignmentPage;

- (id) initWithName:(NSString *)aName
		   taughtBy:(Teacher *)aTeacher
	 assignmentPage:(NSURL *)aUrl
{
	[super init];
	[self setName:aName];
	[self setTeacher:aTeacher];
	[self setAssignmentPage:aUrl];
	return self;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"%@ ()", name, [assignmentPage absoluteString]];
}

+ (Course *)randomCourse:(Teacher *)aTeacher
{
	NSString *titles[3] = {
		@"Hebrew",
		@"British Literature",
		@"Defence Against the Dark Arts"
	};
	
	NSString *levels[3] = {
		@"AP ",
		@"Honors ",
		@""
	};
	
	NSURL *urls[3] = {
		[NSURL URLWithString:@"http://www.google.com"],
		[NSURL URLWithString:@"http://www.bing.com"],
		[NSURL URLWithString:@"http://www.yahoo.com"]
	};
	
	Course *randomCourse = [[Course alloc] initWithName:[NSString stringWithFormat:@"%@%@", levels[rand() %3], titles[rand() % 3]]
											   taughtBy:aTeacher
										 assignmentPage:urls[rand() % 3]]; 
	[randomCourse autorelease];
	return randomCourse;
}

@end
