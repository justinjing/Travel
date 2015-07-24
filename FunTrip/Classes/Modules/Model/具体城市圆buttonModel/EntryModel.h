//
//  EntryModel.h
//  Travel
//
//  Created by Chinsyo on 15/6/15.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import "BaseModel.h"

@interface EntryModel : BaseModel

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *firstname;
@property (nonatomic, copy) NSString *secondname;
@property (nonatomic, copy) NSString *chinesename;
@property (nonatomic, copy) NSString *englishname;
@property (nonatomic, copy) NSString *localname;
@property (nonatomic) BOOL has_mguide;
@property (nonatomic, copy) NSString *mapstatus;
@property (nonatomic, copy) NSString *lat;
@property (nonatomic, copy) NSString *lon;
@property (nonatomic, copy) NSString *grade;
@property (nonatomic, copy) NSString *gradescores;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *recommendnumber;
@property (nonatomic, copy) NSString *recommendstr;
@property (nonatomic, copy) NSString *beennumber;
@property (nonatomic, copy) NSString *beenstr;
@property (nonatomic, copy) NSString *planto;
@property (nonatomic, copy) NSString *beento;
@property (nonatomic, copy) NSString *distance;

@end
