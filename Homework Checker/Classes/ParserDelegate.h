#import "Teacher.h"

@class Parser;

@protocol ParserDelegate

-(void)parser:(Parser *) didFinishLoadingWebPage:(int) size;

@required

-(void)parser:(Parser *) theParser didFinishParsingDepartments:(NSMutableArray *) theDepartments;

-(void)parser:(Parser *) theParser didFinishParsingCourses:(Teacher *) theTeacher;

@end