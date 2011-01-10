//
//  Course.h
//  Homework Checker
//
//  Created by Seth Battis on 12/7/10.
//  Copyright 2010 Milken Community High School. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Teacher;

@interface Course : NSObject {
	NSString *name;
	Teacher *teacher;
	NSURL *assignmentPage;
}

@property (copy) NSString *name;
@property (retain) Teacher *teacher;
@property (copy) NSURL *assignmentPage;

+ (Course *)randomCourse:(Teacher *)aTeacher;

- (id)initWithName:(NSString *)aName
		  taughtBy:(Teacher *)aTeacher
	assignmentPage:(NSURL *)aUrl;

@end
