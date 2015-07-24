//
//  RecommendModel.m
//  Travel
//
//  Created by Chinsyo on 15/6/3.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import "RecommendModel.h"
#import <objc/message.h>

@implementation RecommendModel
@synthesize description=_description;

// 利用runtime机制进行属性的归档接档
- (void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([RecommendModel class], &count);
    for (int i = 0; i<count; i++) {
        // 取出i位置对应的成员变量
        Ivar ivar = ivars[i];
        // 查看成员变量
        const char *name = ivar_getName(ivar);
        // 归档
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    free(ivars);
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([RecommendModel class], &count);
        for (int i = 0; i<count; i++) {
            // 取出i位置对应的成员变量
            Ivar ivar = ivars[i];
            // 查看成员变量
            const char *name = ivar_getName(ivar);
            // 归档
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            // 设置到成员变量身上
            [self setValue:value forKey:key];
        }
        free(ivars);
    }
    return self;
}


//-(void)encodeWithCoder:(NSCoder *)aCoder
//{
//    [aCoder encodeObject:self.url         forKey:@"MyUrl"];
//    [aCoder encodeObject:self.photo       forKey:@"MyPhoto"];
//    [aCoder encodeObject:self.title       forKey:@"MyTitle"];
//    [aCoder encodeObject:self.id          forKey:@"MyID"];
//    [aCoder encodeObject:self.user_id     forKey:@"MyUserId"];
//    [aCoder encodeObject:self.username    forKey:@"MyUserName"];
//    [aCoder encodeObject:self.avatar      forKey:@"MyAvatar"];
//    [aCoder encodeObject:self.description forKey:@"MyDesc"];
//    [aCoder encodeObject:self.count       forKey:@"MyCount"];
//    [aCoder encodeObject:self.price       forKey:@"MyPrice"];
//    [aCoder encodeObject:self.end_date    forKey:@"MyEndDate"];
//    [aCoder encodeObject:self.priceoff    forKey:@"MyPriceOff"];
//    
//    
//}
//
//-(id)initWithCoder:(NSCoder *)aDecoder
//{
//    if (self=[super init]) {
//    self.url=[aDecoder decodeObjectForKey:@"MyUrl"];
//    self.photo =[aDecoder decodeObjectForKey:@"MyPhoto"];
//    self.title =[aDecoder decodeObjectForKey:@"MyTitle"];
//    self.id    =[aDecoder decodeObjectForKey:@"MyID"];
//    self.user_id  =[aDecoder decodeObjectForKey:@"MyUserId"];
//    self.username =[aDecoder decodeObjectForKey:@"MyUserName"];
//    self.avatar   =[aDecoder decodeObjectForKey:@"MyAvatar"];
//    self.description =[aDecoder decodeObjectForKey:@"MyDesc"];
//    self.count   =[aDecoder decodeObjectForKey:@"MyCount"];
//    self.price   =[aDecoder decodeObjectForKey:@"MyPrice"];
//    self.end_date =[aDecoder decodeObjectForKey:@"MyEndDate"];
//    self.priceoff =[aDecoder decodeObjectForKey:@"MyPriceOff"];
//    }
//    return self;
//}

@end
