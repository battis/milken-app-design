//
//  Copyright Milken Community High School All rights reserved.
//  Based on the "Homepwer" application created by bhardy.
//


#import <Foundation/Foundation.h>

@class Department;
@class Course;

@interface Teacher : NSObject {
	NSString *name;
	NSString *email;
	NSString *userid;
	Department *department;
	NSMutableArray *courses;
}

@property (copy) NSString *name;
@property (copy) NSString *email;
@property (copy) NSString *userid;
@property (retain) Department *department;
@property (retain) NSMutableArray *courses;

+ (Teacher *)randomTeacher:(Department *)aDepartment;

- (id)initWithName:(NSString *)aName
	  memberOfDept:(Department *)aDept
	 coursesTaught:(NSMutableArray *)someCourses;
- (id)initWithName:(NSString *)aName
	  memberOfDept:(Department *)aDept;
- (id)initWithName:(NSString *)aName;

- (void)addCourse:(Course *)aCourse;
- (int)courseCount;

@end
