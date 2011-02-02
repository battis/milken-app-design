//
//  Copyright Milken Community High School All rights reserved.
//  Based on the "Homepwer" application created by bhardy.
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
