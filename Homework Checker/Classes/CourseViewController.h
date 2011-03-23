//
//  Copyright Milk N' Cookies App Design All rights reserved.
//



#import <UIKit/UIKit.h>
#import "Teacher.h"
#import "ParserDelegate.h"

@class AssignmentViewController;

@interface CourseViewController : UITableViewController <ParserDelegate> {
	AssignmentViewController *assignmentViewController;
	Teacher *teacher;
	Parser *parser;
	Boolean needToParseTeacher;
	NSMutableArray *Courses;
	UIActivityIndicatorView *activityIndicator;
}

@property (retain) UIActivityIndicatorView *activityIndicator;

- (id)setTeacher:(Teacher *)theTeacher;

@end

