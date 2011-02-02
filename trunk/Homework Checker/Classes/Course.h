//
//  Copyright Milken Community High School All rights reserved.
//  Based on the "Homepwer" application created by bhardy.
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
