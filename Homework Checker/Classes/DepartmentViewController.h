//
//  ItemsViewController.h
//  Homepwner
//
//  Created by bhardy on 7/30/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParserDelegate.h";

@class TeacherViewController;

@interface DepartmentViewController : UITableViewController <ParserDelegate> {
	TeacherViewController *teacherViewController;
	NSMutableArray *departments;
	Parser *parser;
	
	IBOutlet UIActivityIndicatorView *activityIndicator;
}

@property (copy) NSMutableArray *teachers;
@property (retain) NSMutableArray *departments;

@end
