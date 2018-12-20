//
//  DBManage.m
//  Sqlite3Demo
//
//  Created by mt y on 2018/12/20.
//  Copyright © 2018年 mt y. All rights reserved.
//

#import "DBManage.h"
#import "Food+CoreDataProperties.h"
@interface DBManage ()

@property (nonatomic, strong)NSManagedObjectContext *contexrt;

@end
@implementation DBManage
//1.在该类中定义一个静态的全局变量，防止被外部d用extren访问
 static id instance = nil;
// 3.提供一个shared方法让外界调用这个单例（一般单例都会提供这个方法），确保只init一次
+ (instancetype)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DBManage alloc] init];
        [instance openDB];
    });
    return instance;
}
//  2.重写它这个类的llocWithZone:方法，确保只为你这个类分配一次内存地址
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}
// 4.重写copyWithZone:方法，避免使用copy时创建多个对象
- (id)copyWithZone:(NSZone *)zone
{
    return instance;
}


- (void)openDB
{
  //系统创建模型文件时会自动生成关联数据库的代码，在iOS10以下和iOS10之后生成的不一样，出现了一个新类NSPersistentContainer。
    if (@available(iOS 10.0,*)) {
        NSPersistentContainer *preCon = [[NSPersistentContainer alloc] initWithName:@"Model"];
        [preCon loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription * _Nonnull stor, NSError * _Nullable error) {
            NSLog(@"%@",error.userInfo);
        }];
        //使用存储调度器快速在多线程中操作数据库，效率非常高(比主线程操作块50倍！！！)
        [preCon performBackgroundTask:^(NSManagedObjectContext * _Nonnull con) {
            
        }];
        _contexrt = preCon.viewContext;
    }else{
        //1、创建模型对象
        //获取模型路径
        NSURL *modeUrl = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
        //根据模型文件创建模型对象
        NSManagedObjectModel *mangerMode = [[NSManagedObjectModel alloc] initWithContentsOfURL:modeUrl];
        //2、创建持久化存储助理：数据库
        //利用模型对象创建助理对象
        NSPersistentStoreCoordinator *store = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mangerMode];
        //数据库的名称和路径
        NSURL *storeUrl = [NSURL fileURLWithPath: [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/coreData.sqlite3"]];
        NSError *error = nil;
        //设置数据库相关信息 添加一个持久化存储库并设置类型和路径，NSSQLiteStoreType：SQLite作为存储库，options是做数据库迁移的
        
        [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error];
        if (error) {
            NSLog(@"打开数据库文件失败%@",error);
        }else{
            NSLog(@"打开数据库文件成功");
        }
        //3、创建上下文 保存信息 对数据库进行操作
        NSManagedObjectContext *contexrt = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        //关联持久化助理
        contexrt.persistentStoreCoordinator = store;
        _contexrt = contexrt;
    }
}
// 创建NSManagedObject
- (id)createMO:(NSString *)entityName
{
    NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:_contexrt];
    return managedObject;
}
//增加
- (void)saveMo:(NSManagedObject *)obj
{
    NSError *error = nil;
    if ([_contexrt save:&error]) {
        NSLog(@"保存成功");
    }else{
        NSLog(@"保存失败");
    }
}
//查询
- (NSArray *)quallyData
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Food"];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"pice > %ld",100];
    request.predicate = pre;
    NSArray *allArr = [_contexrt executeFetchRequest:request error:nil];
    return allArr;
}
//删除
- (void)deleteData:(NSString *)str
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Food"];
    NSPredicate *pre = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"%@",str]];
    request.predicate = pre;
    NSArray *arr = [_contexrt executeFetchRequest:request error:nil];
    for (Food *food in arr) {
        [_contexrt deleteObject:food];
    }
    NSError *error = nil;
    if ([_contexrt save:&error])
    {
        NSLog(@"w保存成功");
    }else
    {
        NSLog(@"保存失败");
    }
}
//f更新
- (void)upData:(NSString *)str
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Food"];
    NSPredicate *pre = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"%@",str]];
    request.predicate = pre;
    if (@available(iOS 10.0,*)) {
      
    }
    NSArray *arr = [_contexrt executeFetchRequest:request error:nil];
    for (Food *food in arr) {
        food.name = @"100000";
    }
    NSError *error = nil;
    if ([_contexrt save:&error]) {
        NSLog(@"更新价格成功");
    }else{
        NSLog(@"更新价格失败");
    }
}
@end
