//
//  Copyright Milken Community High School All rights reserved.
//  Based on the "Homepwer" application created by bhardy.
//


#import <UIKit/UIKit.h>
#import "ParserDelegate.h";


@class TeacherViewController;

@interface DepartmentViewController : UITableViewController <ParserDelegate> {
	TeacherViewController *teacherViewController;
	NSMutableArray *departments;
	Parser *parser;
	bool parsing, splashing;
	UIActivityIndicatorView *activityIndicator;
}

@property (copy) NSMutableArray *teachers;
@property (retain) NSMutableArray *departments;
@property (retain) UIActivityIndicatorView *activityIndicator;

-(void)doneSplashing:(NSTimer *)timer;
-(void)doneParsing:(NSTimer *)timer;

@end
