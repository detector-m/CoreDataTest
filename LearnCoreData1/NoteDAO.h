//
//  NoteDAO.h
//  LearnCoreData1
//
//  Created by RivenL on 15/3/26.
//  Copyright (c) 2015年 RivenL. All rights reserved.
//

#import "CoreDataDAO.h"
#import "Note.h"

@interface NoteDAO : CoreDataDAO
//--------------------------------------------------------//
+ (NoteDAO *)sharedManager;
//--------------------------------------------------------//

//--------------------------------------------------------//
/*插入*/
- (NSInteger)add:(Note *)model;
/*移除*/
- (NSInteger)remove:(Note *)model;
/*修改*/
- (NSInteger)modify:(Note *)model;
/*按照主键查询*/
- (Note *)findById:(Note *)model;
/*查询*/
- (NSArray *)findAll;
//--------------------------------------------------------//

@end
