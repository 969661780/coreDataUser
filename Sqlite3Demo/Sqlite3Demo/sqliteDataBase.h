//
//  sqliteDataBase.h
//  Sqlite3Demo
//
//  Created by mt y on 2018/12/20.
//  Copyright © 2018年 mt y. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "People.h"
NS_ASSUME_NONNULL_BEGIN

@interface sqliteDataBase : NSObject

+(NSString *)loadPath;
+(BOOL)openDataBase;
+ (void)excuteSql:(NSString *)sql;
+ (NSMutableArray *)querryTable;
@end

NS_ASSUME_NONNULL_END
