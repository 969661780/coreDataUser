//
//  ViewController.m
//  Sqlite3Demo
//
//  Created by mt y on 2018/12/20.
//  Copyright © 2018年 mt y. All rights reserved.
//

#import "ViewController.h"
#import "sqliteDataBase.h"
#import "DBManage.h"
#import "Food+CoreDataClass.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
//    [sqliteDataBase excuteSql:@"create table person (id integer primary key ,name text,age integer)"];
    
//    [sqliteDataBase excuteSql:@"insert into person (name,age)values ('张三',28)"];
//
//    NSMutableArray *arr = [sqliteDataBase querryTable];
//    for (People *pe  in arr) {
//        NSLog(@"%@--%ld=----%d",pe.name,pe.ID,pe.age);
//}
//    for (int i = 0; i< 5; i++) {
//        Food *food = [[DBManage shareManager] createMO:@"Food"];
//        food.color = [NSString stringWithFormat:@"%dcolor",i];
//        food.name = [NSString stringWithFormat:@"%d元",i*100];
//        food.pice = i * 1000;
//        [[DBManage shareManager] saveMo:food];
//    }
    [[DBManage shareManager] deleteData:[NSString stringWithFormat:@"pice = %d",2000]];
    [[DBManage shareManager] upData:[NSString stringWithFormat:@"pice = %d",1000]];
    NSArray *allArr = [[DBManage shareManager] quallyData];
    for (Food *food in allArr) {
        NSLog(@"%@",food.name);
    }
    
}

@end
