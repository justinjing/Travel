//
//  CoreDataManager.m
//  Travel
//
//  Created by Chinsyo on 15/6/10.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import "CoreDataManager.h"
#import "Entity.h"
#import "BaseManagerEntity.h"
#import "Entity1.h"



@interface CoreDataManager()

{
    NSManagedObjectContext * _context;
}

@end



@implementation CoreDataManager


-(void)perple
{
    NSString *momdPath=[[NSBundle mainBundle]pathForResource:@"Model" ofType:@"momd"];
    NSManagedObjectModel * model=[[NSManagedObjectModel alloc]initWithContentsOfURL:[NSURL URLWithString:momdPath]];
    NSPersistentStoreCoordinator * coordinator=[[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:model];
    
    NSString *dbPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/xxx.sqlite"];
    NSError *error   = nil;
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:dbPath] options:nil error:&error];
    _context=[[NSManagedObjectContext alloc]init];
    _context.persistentStoreCoordinator=coordinator;
}

+(instancetype)defaultCoreManager
{
    static CoreDataManager * s_coreDataManager=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_coreDataManager=[[CoreDataManager alloc]init];
        [s_coreDataManager perple];
    });
    return s_coreDataManager;
}

-(void)addModelFromNetWork:(NSArray *)array entityName:(NSString *)name
{
    
    BaseManagerEntity * entity=[NSEntityDescription insertNewObjectForEntityForName:name
                                                             inManagedObjectContext:_context];
    NSData * archiveCarPriceData=[NSKeyedArchiver archivedDataWithRootObject:array];
    entity.dataArray=archiveCarPriceData;
    
    [_context save:nil];
    
}

-(NSMutableArray *)fetchModelFromCoreDataWithEntityName:(NSString *)name
{
    //推荐界面view的数据存储
    //数组中包含了四个数组,分别对应
    //[@"slide",@"subject",@"discount",@"mguide"];
    NSFetchRequest * fetchRequest=[NSFetchRequest fetchRequestWithEntityName:name];
    NSArray * array=[_context executeFetchRequest:fetchRequest error:nil];
    if (array==0) {
        return nil;
    }else{
        BaseManagerEntity * entity=[array firstObject];
        NSArray * arrays=[NSKeyedUnarchiver unarchiveObjectWithData:entity.dataArray];
        return (NSMutableArray *)arrays;
    }
}

-(void)removeAllModelFromCoreDataWithEntityName:(NSString *)name
{
    NSFetchRequest * fetchRequest=[[NSFetchRequest alloc]initWithEntityName:name];
    NSArray * array=[_context executeFetchRequest:fetchRequest error:nil];
    if (array>0) {
        for (BaseManagerEntity  * model in array) {
            [_context deleteObject:(NSManagedObject *)model];
        }
        [_context save:nil];
    }
}

- (void)update:(id)sender {
    // 如果要删除或更新数据库文件，首先要找出来，找出来之后再进行内存删除，内存删除完之后，再用NSObjectContext保存save
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name like 'liu*'"];
    
    NSFetchRequest *request= [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Entity" inManagedObjectContext:_context]];
    [request setPredicate:predicate];
    //    NSArray *arr = [_context executeFetchRequest:request error:nil];
    //    if (arr.count > 0) {
    //        for (Student *student in arr) {
    //            student.name = @"ZhengSangFeng";
    //        } // 循环结束后，数组中所有的学生对象名字都变为了 @"ZhengSangFeng";
    //    }
    [_context save:nil];
}



@end
