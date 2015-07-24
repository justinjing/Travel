//
//  LocationModel.h
//  Travel
//
//  Created by Chinsyo on 15/6/12.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import "BaseModel.h"

@interface LocationModel : BaseModel

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *firstname;
@property (nonatomic, copy) NSString *secondname;
@property (nonatomic, copy) NSString *localname;
@property (nonatomic, copy) NSString *chinesename;
@property (nonatomic, copy) NSString *englishname;
@property (nonatomic, copy) NSString *countryname;
@property (nonatomic, copy) NSString *cityname;
@property (nonatomic, copy) NSString *lat;
@property (nonatomic, copy) NSString *lng;
@property (nonatomic) int mapstatus;
@property (nonatomic) int recommandstar;
@property (nonatomic) int planto;
@property (nonatomic) int beento;
@property (nonatomic) int beennumber;
@property (nonatomic, copy) NSString *beenstr;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *description;


@end
