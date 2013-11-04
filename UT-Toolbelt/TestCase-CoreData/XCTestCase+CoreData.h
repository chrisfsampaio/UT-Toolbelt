//
//  XCTestCase+CoreData.h
//  UT-ToolbeltDemo
//
//  Created by Christian Sampaio on 11/4/13.
//  Copyright (c) 2013 None. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface XCTestCase (CoreData)

- (NSManagedObjectContext *)testContextForDataModelFileName:(NSString *)fileName;

@end
