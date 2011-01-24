//
//  TeacherViewController.h
//  Homepwner
//
//  Created by bhardy on 7/30/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AssignmentViewController;

@interface CourseViewController : UITableViewController {
	AssignmentViewController *assignmentViewController;
	NSMutableArray *courses;
	
	IBOutlet UIActivityIndicatorView *activityIndicator;
}

@property (copy) NSMutableArray *courses;

@end
