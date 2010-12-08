//
//  Department.h
//  Homework Checker
//
//  Created by Seth Battis on 12/7/10.
//  Copyright 2010 Milken Community High School. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Teacher;

@interface Department : NSObject {
	NSString *name;
	NSMutableArray *teachers;
}

@property (copy) NSString *name;
@property (readonly) NSMutableArray *teachers;

+ (Department *)randomDepartment;

- (id)initWithName:(NSString *)aName
		  teachers:(NSMutableArray *)someTeachers;
- (id)initWithName:(NSString *)aName;

- (void)addTeacher:(Teacher *)teacher;
- (int)teacherCount;

@end
