//
//  Copyright Milk N' Cookies App Design All rights reserved.
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
