//
//  Copyright Milken Community High School All rights reserved.
//  Based on the "Homepwer" application created by bhardy.
//


#import <UIKit/UIKit.h>
#import "Course.h"

@interface AssignmentViewController : UIViewController <UIApplicationDelegate, UIWebViewDelegate> {
	
	Course *course;
	IBOutlet UIWebView *webView;
	IBOutlet UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic,retain) UIWebView *webView;
@property (retain) Course *course;

-(void)clearView:(NSTimer *)timer;

@end
