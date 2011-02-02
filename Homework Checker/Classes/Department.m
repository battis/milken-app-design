//
//  Department.m
//  Homework Checker
//
//  Created by Seth Battis on 12/7/10.
//  Copyright 2010 Milken Community High School. All rights reserved.
//

#import "Department.h"
#import "Teacher.h"

@implementation Department

@synthesize name, teachers, range;

- (id)initWithName:(NSString *)aName teachers:(NSMutableArray *)someTeachers
{
	[super init];
	[self initWithName:aName];
	[teachers addObjectsFromArray:someTeachers];
	return self;
}

- (id)initWithName:(NSString *)aName range:(NSRange)someRange
{
	[super init];
	range = someRange;
	[self setName:aName];
	teachers = [[NSMutableArray alloc] init];
	return self;
}

- (id)initWithName:(NSString *)aName
{
	[super init];
	[self setName:aName];
	teachers = [[NSMutableArray alloc] init];
	return self;
}

- (void)addTeacher:(Teacher *)teacher
{
	[teachers addObject:teacher];
}

- (int)teacherCount
{
	return [teachers count];
}

- (void)dealloc
{
	[teachers release];
	[super dealloc];
}

- (NSString *)description
{
	return name;
}

+ (Department *)randomDepartment
{
	NSString *deptNames[3] = {
		@"Hebrew",
		@"English",
		@"Witchcraft & Wizardry"
	};
	
	Department *randomDept = [[Department alloc] initWithName:deptNames[rand() % 3]];
	int numTeachers = random() % 10 + 1;
	for (int i = 0; i < numTeachers; i++)
	{
		[randomDept addTeacher:[Teacher randomTeacher:randomDept]];
	}

	return [randomDept autorelease];
}

@end
