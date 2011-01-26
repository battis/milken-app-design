//
//  TeacherViewController.h
//  Homepwner
//
//  Created by bhardy on 7/30/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Teacher.h"

@class AssignmentViewController;

@interface CourseViewController : UITableViewController {
	AssignmentViewController *assignmentViewController;
	Teacher *teacher;
	
	UIActivityIndicatorView *activityIndicator;
}

@property (retain) UIActivityIndicatorView *activityIndicator;
@property (retain) Teacher *teacher;

@end
