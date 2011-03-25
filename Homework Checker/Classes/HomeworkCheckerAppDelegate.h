//
//  Copyright Milk N' Cookies App Design All rights reserved.
//


#import <UIKit/UIKit.h>

@interface HomeworkCheckerAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

