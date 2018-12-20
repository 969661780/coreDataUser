//
//  Food+CoreDataProperties.h
//  Sqlite3Demo
//
//  Created by mt y on 2018/12/20.
//  Copyright © 2018年 mt y. All rights reserved.
//
//

#import "Food+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Food (CoreDataProperties)

+ (NSFetchRequest<Food *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *color;
@property (nonatomic) int16_t pice;
@property (nullable, nonatomic, copy) NSString *name;

@end

NS_ASSUME_NONNULL_END
