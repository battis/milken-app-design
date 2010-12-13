//
//  TeacherViewController.h
//  Homepwner
//
//  Created by bhardy on 7/30/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherViewController : UITableViewController {
	TeacherViewController *teacherViewController;
	NSMutableArray *teachers;
}

@property (copy) NSMutableArray *teachers;

@end
