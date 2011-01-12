//
//  AssignmentViewController.h
//  HWChecker
//
//  Created by (11) Aaron Daniel on 1/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course.h"

@interface AssignmentViewController : UIViewController <UIApplicationDelegate> {

	Course *course;
	IBOutlet UIWebView *webView;	
}

@property (nonatomic,retain) UIWebView *webView;
@property (retain) Course *course;

@end
