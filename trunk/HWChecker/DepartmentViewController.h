//
//  ItemsViewController.h
//  Homepwner
//
//  Created by bhardy on 7/30/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TeacherViewController;

@interface DepartmentViewController : UITableViewController {
	TeacherViewController *teacherViewController;
	NSMutableArray *departments;
}

@property (copy) NSMutableArray *teachers;

@end
