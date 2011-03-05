//
//  Copyright Milken Community High School All rights reserved.
//  Based on the "Homepwer" application created by bhardy.
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
	NSArray *deptNames = [NSArray arrayWithObjects:@"Hebrew", @"English", @"Witchcraft & Wizardry", nil];
	
	Department *randomDept = [[Department alloc] initWithName:[deptNames objectAtIndex:rand() % [deptNames count]]];
	int numTeachers = random() % 10 + 1;
	for (int i = 0; i < numTeachers; i++)
	{
		[randomDept addTeacher:[Teacher randomTeacher:randomDept]];
	}

	return [randomDept autorelease];
}

@end
