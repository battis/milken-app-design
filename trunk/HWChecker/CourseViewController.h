//
//  TeacherViewController.h
//  Homepwner
//
//  Created by bhardy on 7/30/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CourseViewController;

@interface CourseViewController : UITableViewController {
	CourseViewController *courseViewController;
	NSMutableArray *courses;
}

@property (copy) NSMutableArray *courses;

@end
