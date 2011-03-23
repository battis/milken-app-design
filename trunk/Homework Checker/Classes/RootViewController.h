//
//  RootViewController.h
//  Homework Checker v2
//
//  Created by Seth Battis on 3/5/11.
//  Copyright 2011 Milken Community High School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parser.h"
#import "TeacherViewController.h";

@interface RootViewController : UITableViewController <ParserDelegate>
{
	Parser *parser;
	NSMutableArray *departments;
	bool parsing;
	TeacherViewController *teacherView;
}

@property (nonatomic, retain) Parser *parser;
@property (nonatomic, retain) NSMutableArray *departments;
@property (nonatomic, retain) TeacherViewController *teacherView;

-(void)showNetworkError;

@end
