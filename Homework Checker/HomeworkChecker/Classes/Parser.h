//
//  FinalProjectTableViewController.h
//  Final project
//
//  Created by Jacob Cohen on 11/29/10.
//  Copyright 2010 Milken Community Jewish High School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParserDelegate.h"

@interface Parser : NSObject <NSXMLParserDelegate>
{	
	BOOL parsingDepartments;
	Teacher *teacherBeingParsed;
	NSMutableArray *departments;
	NSMutableData *milkenSiteData;
	NSURLConnection *connectionInProgress;
	id<ParserDelegate> delegate;
}

@property (readonly) NSMutableArray *departments;
@property (retain) Teacher *teacherBeingParsed;
@property (assign) id<ParserDelegate> delegate;

-(void)parseDepartments;
-(void)parseCourses:(Teacher *)teacherToBeParsed;

@end
