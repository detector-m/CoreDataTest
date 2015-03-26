//
//  NoteDAO.m
//  LearnCoreData1
//
//  Created by RivenL on 15/3/26.
//  Copyright (c) 2015年 RivenL. All rights reserved.
//

#import "NoteDAO.h"
#import "NoteManagerObject.h"

@implementation NoteDAO
//--------------------------------------------------------//
+ (NoteDAO *)sharedManager {
    static NoteDAO *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [NoteDAO new];
    });
    
    return manager;
}
//--------------------------------------------------------//

//--------------------------------------------------------//
/*插入*/
- (NSInteger)add:(Note *)model {
    NSManagedObjectContext *cxt = self.managedObjectContext;
    
    NoteManagerObject *nmo = [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:cxt];
    
    [nmo setValue:model.content forKey:@"content"];
    [nmo setValue:model.date forKey:@"date"];
//    nmo.date = model.date;
//    nmo.content = model.content;
    
    NSError *error = nil;
    NSInteger errCode = 0;
    if([cxt save:&error]) {
        NSLog(@"Success");
    }
    else {
        NSLog(@"Failed");
        errCode = -1;
    }
    
    return errCode;
}
/*移除*/
- (NSInteger)remove:(Note *)model {
    NSInteger retCode = 0;
    
    NSManagedObjectContext *cxt = self.managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:cxt];
    
    NSFetchRequest *request = [NSFetchRequest new];
    request.entity = entityDescription;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date = %@", model.date];
    request.predicate = predicate;
    
    NSError *error = nil;
    NSArray *list = [cxt executeFetchRequest:request error:&error];
    if(list.count > 0) {
        NoteManagerObject *note = list.lastObject;
        [cxt deleteObject:note];
        
        NSError *savingError = nil;
        if([cxt save:&savingError]) {
            NSLog(@"success");
        }
        else {
            NSLog(@"failed");
            retCode = -1;
        }
    }
    
    return retCode;
}
/*修改*/
- (NSInteger)modify:(Note *)model {
    NSInteger retCode = 0;
    
    NSManagedObjectContext *cxt = self.managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:cxt];
    
    NSFetchRequest *request = [NSFetchRequest new];
    request.entity = entityDescription;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date = %@", model.date];
    request.predicate = predicate;
    
    NSError *error = nil;
    NSArray *list = [cxt executeFetchRequest:request error:&error];
    if(list.count > 0) {
        NoteManagerObject *note = list.lastObject;
        note.content = model.content;
        
        NSError *savingError = nil;
        if([cxt save:&savingError]) {
            NSLog(@"success");
        }
        else {
            NSLog(@"failed");
            retCode = -1;
        }
    }
    
    return retCode;
}
/*按照主键查询*/
- (Note *)findById:(Note *)model {
    NSManagedObjectContext *cxt = self.managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:cxt];

    NSFetchRequest *request = [NSFetchRequest new];
    request.entity = entityDescription;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date = %@", model.date];
    request.predicate = predicate;
    
    NSError *error = nil;
    NSArray *list = [cxt executeFetchRequest:request error:&error];
    
    if(list.count > 0) {
        NoteManagerObject *nmo = [list lastObject];
        
        Note *note = [Note new];
        note.date = nmo.date;
        note.content = nmo.content;
        
        return note;
    }
    
    return nil;
}
/*查询*/
- (NSArray *)findAll {
    NSManagedObjectContext *cxt = [self managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:cxt];
    NSFetchRequest *request = [NSFetchRequest new];
    [request setEntity:entityDescription];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    [request setSortDescriptors:@[sortDescriptor]];
    
    NSError *error = nil;
    NSArray *list = [cxt executeFetchRequest:request error:&error];
    
    NSMutableArray *resList = [NSMutableArray array];
    
    for(NoteManagerObject *nmo in list) {
        Note *note = [Note new];
        note.date = nmo.date;
        note.content = nmo.content;
        [resList addObject:note];
    }
    
    NSLog(@"%@", resList);
    return resList;
}
//--------------------------------------------------------//
@end
