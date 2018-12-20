//
//  People.h
//  Sqlite3Demo
//
//  Created by mt y on 2018/12/20.
//  Copyright © 2018年 mt y. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface People : NSObject

@property (nonatomic, assign) int ID, age;
@property (nonatomic, copy) NSString *name;

@end

NS_ASSUME_NONNULL_END
