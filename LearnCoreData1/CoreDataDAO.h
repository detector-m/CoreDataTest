//
//  CoreDataDAO.h
//  LearnCoreData1
//
//  Created by RivenL on 15/3/26.
//  Copyright (c) 2015年 RivenL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataDAO : NSObject
//--------------------------------------------------------//
//被管理的对象的上下文
@property (nonatomic, readonly, strong) NSManagedObjectContext *managedObjectContext;
//被管理的对象模型
@property (nonatomic, readonly, strong) NSManagedObjectModel *managedObjectModel;
//持久化存储协调器
@property (nonatomic, readonly, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
//--------------------------------------------------------//

//--------------------------------------------------------//
- (NSURL *)applicationDoucmentsDirectory;
- (void)saveContext;
//--------------------------------------------------------//
@end
