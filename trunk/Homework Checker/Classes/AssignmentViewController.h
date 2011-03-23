//
//  Copyright Milk N' Cookies App Design All rights reserved.
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
