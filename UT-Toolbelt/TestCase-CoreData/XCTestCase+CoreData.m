//
//  XCTestCase+CoreData.m
//  UT-ToolbeltDemo
//
//  Created by Christian Sampaio on 11/4/13.
//  Copyright (c) 2013 None. All rights reserved.
//

#import "XCTestCase+CoreData.h"
#import <CoreData/CoreData.h>

@implementation XCTestCase (CoreData)

- (NSManagedObjectContext *)testContextForDataModelFileName:(NSString *)fileName
{
    NSManagedObjectContext *moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"%@", fileName]
                                                                                                              withExtension:@"momd"]];
    moc.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    return moc;
}

@end
