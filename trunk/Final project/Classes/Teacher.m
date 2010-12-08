//
//  Teacher.m
//  Homework Checker
//
//  Created by Seth Battis on 12/7/10.
//  Copyright 2010 Milken Community High School. All rights reserved.
//

#import "Teacher.h"


@implementation Teacher

@synthesize name, department, courses;

- (id)initWithName:(NSString *)aName
	  memberOfDept:(Department *) aDept
	coursesTaught:(NSMutableArray *) someCourses
{
	[self initWithName:aName memberOfDept:aDept];
	[courses addObjectsFromArray:someCourses];
	return self;
}

- (id)initWithName:(NSString *)aName
	  memberOfDept:(Department *) aDept
{
	[self initWithName:aName];
	[self setDepartment:aDept];
	return self;
}

- (id)initWithName:(NSString *)aName
{
	[super init];
	[self setName:aName];
	courses = [[NSMutableArray alloc] init];
	return self;
}

- (id)init
{
	return [self initWithName:@"<No Name>"];
}

- (void)addCourse:(Course *)aCourse
{
	[courses addObject:aCourse];
}

- (int)courseCount
{
	return [courses count];
}

- (void)dealloc
{
	[courses release];
	[super dealloc];
}

+ (Teacher *)randomTeacher:(Department *)aDepartment
{
	static NSString *firstNames[3] = {
		@"Roger",
		@"Sarah",
		@"Jason"
	};
	
	static NSString *lastNames[3] = {
		@"Fuller",
		@"Shulkind",
		@"Ablin"
	};
	
	Teacher *randomTeacher = [[Teacher alloc] initWithName:[NSString stringWithFormat:@"%@ %@", firstNames[random() % 3], lastNames[random() % 3]]];
	[randomTeacher addCourse:[Course randomCourse:randomTeacher]];
	[randomTeacher autorelease];
	return randomTeacher;
}

@end
