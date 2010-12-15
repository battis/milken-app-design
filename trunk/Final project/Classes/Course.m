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
	
	Course *randomCourse = [[Course alloc] initWithName:[NSString stringWithFormat:@"%@%@", levels[rand() %3], titles[rand() % 3]]
										 taughtBy:aTeacher
									assignmentPage:[NSURL URLWithString:@"http://faculty.milkenschool.org/sbattis/appdesign/assignments/index"]]; 
	[randomCourse autorelease];
	return randomCourse;
}

@end
