//
//  Copyright Milken Community High School All rights reserved.
//  Based on the "Homepwer" application created by bhardy.
//


#import "Course.h"
#import "Teacher.h"

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
	return name;
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
		[NSURL URLWithString:@"http://faculty.milkenschool.org/sbattis/companim2/assignments/index"],
		[NSURL URLWithString:@"http://faculty.milkenschool.org/sbattis/appdesign/assignments/index"],
		[NSURL URLWithString:@"http://faculty.milkenschool.org/rshaltiel/hebbas1/assignments/index"]
	};
	
	Course *randomCourse = [[Course alloc] initWithName:[NSString stringWithFormat:@"%@%@", levels[rand() %3], titles[rand() % 3]]
											   taughtBy:aTeacher
										 assignmentPage:urls[rand() % 3]];
	if ([[aTeacher userid] length] > 0)
	{
		[randomCourse setAssignmentPage:[NSURL URLWithString:[NSString stringWithFormat:@"http://faculty.milkenschool.org/%@/index", [aTeacher userid]]]];
	}

	return [randomCourse autorelease];
}

@end
