//
//  KIVACoreDataManager.m
//  Kiva
//
//  Created by Ronald Mannak on 6/15/14.
//  Copyright (c) 2014 Ronald Mannak. All rights reserved.
//

#import "KIVACoreDataManager.h"

@implementation KIVACoreDataManager

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

+ (instancetype)defaultManager
{
    static dispatch_once_t onceToken;
    static KIVACoreDataManager *manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [[KIVACoreDataManager alloc] init];
    });
    return manager;
}

- (void)saveContext
{
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        //        [managedObjectContext performBlockAndWait:^{
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
        //        }];
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Kiva" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    NSDictionary *options = @{
                              NSInferMappingModelAutomaticallyOption : @(YES),
                              NSMigratePersistentStoresAutomaticallyOption: @(YES)
                              };
    NSError *error = nil;
    NSURL *databaseURL =    [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Kiva"];
    NSPersistentStore *store = [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:databaseURL options:options error:&error];
    if (!store) {
        if([[NSFileManager defaultManager] fileExistsAtPath:databaseURL.absoluteString]) {
            NSError *error = nil;
            [[NSFileManager defaultManager] removeItemAtURL:databaseURL error:&error];
            if (error) {
                NSLog(@"Error deleting existing schools database %@", error);
            }
        }
        if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:databaseURL options:options error:&error]) {
            NSAssert(NO, @"Error adding persistent store: %@", error);
        }
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
