//
//  Copyright Milken Community High School All rights reserved.
//  Based on the "Homepwer" application created by bhardy.
//


#import <Foundation/Foundation.h>

@class Teacher;

@interface Department : NSObject {
	NSString *name;
	NSMutableArray *teachers;
	NSRange range;
}

@property (copy) NSString *name;
@property (retain) NSMutableArray *teachers;
@property NSRange range;


+ (Department *)randomDepartment;

- (id)initWithName:(NSString *)aName
		  teachers:(NSMutableArray *)someTeachers;
- (id)initWithName:(NSString *)aName
			 range:(NSRange)someRange;

- (id)initWithName:(NSString *)aName;

- (void)addTeacher:(Teacher *)teacher;
- (int)teacherCount;

@end
