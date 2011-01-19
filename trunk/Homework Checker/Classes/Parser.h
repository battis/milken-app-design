//
//  FinalProjectTableViewController.h
//  Final project
//
//  Created by Jacob Cohen on 11/29/10.
//  Copyright 2010 Milken Community Jewish High School. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Parser : NSObject <NSXMLParserDelegate>{
	
	BOOL waitingForEntryTitle;
	NSString *regularEx;
	NSMutableString *titleString;
	NSMutableArray *departments;
	NSMutableArray *teachers;
	NSMutableData *milkenSiteData;
	NSURLConnection *connectionInProgress;

	
}

@property (readonly) NSMutableArray *departments;
@property (readonly) NSMutableArray *teachers;

@end
