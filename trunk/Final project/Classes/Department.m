//
//  Department.m
//  Homework Checker
//
//  Created by Seth Battis on 12/7/10.
//  Copyright 2010 Milken Community High School. All rights reserved.
//

#import "Department.h"


@implementation Department

@synthesize name, teachers;

- (id)initWithName:(NSString *)aName teachers:(NSMutableArray *)someTeachers
{
	[super init];
	[self initWithName:aName];
	[teachers addObjectsFromArray:someTeachers];
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

+ (Department *)randomDepartment
{
	NSString *deptNames[3] = {
		@"תירבע",
		@"English",
		@"Witchcraft & Wizardry"
	};
	
	Department *randomDept = [[Department alloc] initWithName:deptNames[random() % 3]];
	[randomDept addTeacher:[Teacher randomTeacher:randomDept]];
	[randomDept autorelease];
	return randomDept;
}

@end
