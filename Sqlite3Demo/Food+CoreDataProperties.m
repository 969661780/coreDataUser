//
//  Food+CoreDataProperties.m
//  Sqlite3Demo
//
//  Created by mt y on 2018/12/20.
//  Copyright © 2018年 mt y. All rights reserved.
//
//

#import "Food+CoreDataProperties.h"

@implementation Food (CoreDataProperties)

+ (NSFetchRequest<Food *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Food"];
}

@dynamic color;
@dynamic pice;
@dynamic name;

@end
