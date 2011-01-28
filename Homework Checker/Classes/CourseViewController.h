//
//  TeacherViewController.h
//  Homepwner
//
//  Created by bhardy on 7/30/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Teacher.h"
#import "ParserDelegate.h"

@class AssignmentViewController;

@interface CourseViewController : UITableViewController <ParserDelegate> {
	AssignmentViewController *assignmentViewController;
	Teacher *teacher;
	Parser *parser;
	NSMutableArray *Courses;
	
	UIActivityIndicatorView *activityIndicator;
}

@property (retain) UIActivityIndicatorView *activityIndicator;
@property (retain) Teacher *teacher;

@end

