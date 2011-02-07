//
//  FinalProjectTableViewController.h
//  Final project
//
//  Created by Jacob Cohen on 11/29/10.
//  Copyright 2010 Milken Community Jewish High School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParserDelegate.h"

@interface Parser : NSObject <NSXMLParserDelegate>{
	
	BOOL waitingForEntryTitle;
	BOOL parsingDepartments;
	Teacher *teacherBeingParsed;
	NSString *regularEx;
	NSMutableString *titleString;
	NSMutableArray *departments;
	NSMutableArray *teachers;
	NSMutableData *milkenSiteData;
	NSURLConnection *connectionInProgress;
	id<ParserDelegate> delegate;
}

@property (readonly) NSMutableArray *departments;
@property (readonly) NSMutableArray *teachers;
@property (retain) Teacher *teacherBeingParsed;
@property (retain) id<ParserDelegate> delegate;

-(void)parseDepartments;
-(void)parseCourses:(Teacher *)teacherToBeParsed;

@end
