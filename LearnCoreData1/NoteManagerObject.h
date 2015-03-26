//
//  NoteManagerObject.h
//  LearnCoreData1
//
//  Created by RivenL on 15/3/26.
//  Copyright (c) 2015年 RivenL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface NoteManagerObject : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * content;

@end
