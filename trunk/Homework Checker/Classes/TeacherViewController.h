//
//  TeacherViewController.h
//  Homepwner
//
//  Created by bhardy on 7/30/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Department.h"

@class CourseViewController;

@interface TeacherViewController : UITableViewController {
	CourseViewController *courseViewController;
	Department *department;
}

@property (retain) Department *department;

@end
