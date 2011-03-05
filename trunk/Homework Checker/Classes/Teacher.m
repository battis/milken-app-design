//
//  Copyright Milken Community High School All rights reserved.
//  Based on the "Homepwer" application created by bhardy.
//


#import "Teacher.h"
#import "Course.h"

@implementation Teacher

@synthesize name, email, userid, department, courses;

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

- (NSString *)description
{
	return name;
}

+ (Teacher *)randomTeacher:(Department *)aDepartment
{
	static NSString *firstNames[6] = {
		@"Adam",
		@"Barbara",
		@"Charles",
		@"Diana",
		@"Ethan",
		@"Francis"
	};
	
	static NSString *lastNames[3] = {
		@"Smith",
		@"Jones",
		@"Doe"
	};
	
	Teacher *randomTeacher = [[Teacher alloc] initWithName:[NSString stringWithFormat:@"%@ %@", firstNames[rand() % 6], lastNames[rand() % 3]]];
	int numCourses = random() % 4 + 1;
	for (int i = 0; i < numCourses; i++)
	{
		[randomTeacher addCourse:[Course randomCourse:randomTeacher]];
	}
	return [randomTeacher autorelease];
}

@end
