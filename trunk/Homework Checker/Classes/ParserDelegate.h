//
//  Created by Seth Battis
//  Copyright 2010 Milken Community Jewish High School. All rights reserved.
//

#import "Teacher.h"

@class Parser;

@protocol ParserDelegate

@required

-(void)parser:(Parser *) theParser didFinishParsingDepartments:(NSMutableArray *) theDepartments;

-(void)parser:(Parser *) theParser didFinishParsingCourses:(Teacher *) theTeacher;

@end