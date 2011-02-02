//
//  Teacher.h
//  Homework Checker
//
//  Created by Seth Battis on 12/7/10.
//  Copyright 2010 Milken Community High School. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Department;
@class Course;

@interface Teacher : NSObject {
	NSString *name;
	NSString *userid;
	Department *department;
	NSMutableArray *courses;
}

@property (copy) NSString *name;
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
