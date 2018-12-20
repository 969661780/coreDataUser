//
//  DBManage.h
//  Sqlite3Demo
//
//  Created by mt y on 2018/12/20.
//  Copyright © 2018年 mt y. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
NS_ASSUME_NONNULL_BEGIN

@interface DBManage : NSObject

+ (instancetype)shareManager;

- (void)openDB;

// 创建NSManagedObject

- (id)createMO:(NSString *)entityName;

- (void)saveMo:(NSManagedObject *)obj;

- (NSArray *)quallyData;

- (void)deleteData:(NSString *)str;

- (void)upData:(NSString *)str;
@end

NS_ASSUME_NONNULL_END
