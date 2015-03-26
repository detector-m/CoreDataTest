//
//  CoreDataDAO.m
//  LearnCoreData1
//
//  Created by RivenL on 15/3/26.
//  Copyright (c) 2015年 RivenL. All rights reserved.
//

#import "CoreDataDAO.h"

@interface CoreDataDAO ()
//--------------------------------------------------------//
//被管理的对象的上下文
@property (nonatomic, readwrite, strong) NSManagedObjectContext *managedObjectContext;
//被管理的对象模型
@property (nonatomic, readwrite, strong) NSManagedObjectModel *managedObjectModel;
//持久化存储协调器
@property (nonatomic, readwrite, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
//--------------------------------------------------------//

@end
@implementation CoreDataDAO

//--------------------------------------------------------//
#pragma mark - documents directory
- (NSURL *)applicationDoucmentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - Core Data 堆栈
//return managedObjectModel
- (NSManagedObjectModel *)managedObjectModel {
    if(_managedObjectModel)
        return _managedObjectModel;
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"LearnCoreData1" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:url];
    
    return _managedObjectModel;
}
//return persistentStoreCoordinator
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if(_persistentStoreCoordinator)
        return _persistentStoreCoordinator;
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    NSURL *storeUrl = [[self applicationDoucmentsDirectory] URLByAppendingPathComponent:@"LearnCoreData1.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if(![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"error domain" code:9999 userInfo:dict];
        
        NSLog(@"error = %@", error);
        abort();
    }
    
    return _persistentStoreCoordinator;
}
//return managedobjectcontext
- (NSManagedObjectContext *)managedObjectContext {
    if(_managedObjectContext)
        return _managedObjectContext;
    
    NSPersistentStoreCoordinator *coordinator = self.persistentStoreCoordinator;
    if(!coordinator) {
        return nil;
    }
    
    _managedObjectContext = [NSManagedObjectContext new];
    _managedObjectContext.persistentStoreCoordinator = coordinator;
    
    return _managedObjectContext;
}

#pragma mark - core data saving support
- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if(managedObjectContext) {
        NSError *error = nil;
        if([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"save error = %@", error);
            abort();
        }
    }
}
//--------------------------------------------------------//

@end
