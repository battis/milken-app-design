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
	Department *department;
	NSMutableArray *courses;
}

@property (copy) NSString *name;
@property (retain) Department *department;
@property (readonly) NSMutableArray *courses;

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
