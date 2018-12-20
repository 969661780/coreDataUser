//
//  sqliteDataBase.m
//  Sqlite3Demo
//
//  Created by mt y on 2018/12/20.
//  Copyright © 2018年 mt y. All rights reserved.
//

#import "sqliteDataBase.h"
@interface sqliteDataBase ()

@end
@implementation sqliteDataBase

+ (NSString *)loadPath {
    return  [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/db.sqlite3"];
}
static sqlite3 *db;
+ (BOOL)openDataBase {
    // 创建数据库文件,并创建数据库的对象
    if (sqlite3_open([[self loadPath] UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        //创建失败
        return NO;
    }
    return YES;
}

+ (void)closeDataBase {
    sqlite3_close(db);
}

+ (void)excuteSql:(NSString *)sql {
    if ([self openDataBase]) {
        //第一个参数表示数据库对象
        //第二个参数表示sql语句
        //第三个参数表示回调函数
        //第四个参数表示回调函数的第一个参数
        //第五个参数表示执行失败后的错误信息
        if (sqlite3_exec(db, [sql UTF8String], nil, nil, nil) == SQLITE_OK) {
            NSLog(@"执行成功");
        } else {
            
            NSLog(@"执行失败");
        }
        [self closeDataBase];
    }
}

+ (NSMutableArray *)querryTable {
    NSMutableArray *arr;
    if ([self openDataBase]) {
        arr = [NSMutableArray new];
        NSString *sql = @"select * from person";
        sqlite3_stmt *stmt;
        if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK) {
            //执行结果集,因为结果是多行,所以使用while循环
            while (sqlite3_step(stmt) == SQLITE_ROW) {
                People *pe = [People new];
                //列从0开始
                //取出结果集中的每一行的第0列
                pe.ID = sqlite3_column_int(stmt, 0);
                //取出第一列
                pe.name = [NSString stringWithUTF8String: (char *)sqlite3_column_text(stmt, 1)];
                //取出第二列
                pe.age = sqlite3_column_int(stmt, 2);
                [arr addObject:pe];
            }
        }
        //终结结果集
        sqlite3_finalize(stmt);
        //关闭数据库
        [self closeDataBase];
    }
    return arr;
    
}
@end
