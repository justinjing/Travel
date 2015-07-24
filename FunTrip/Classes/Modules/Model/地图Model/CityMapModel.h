//
//  CityMapModel.h
//  Travel
//
//  Created by Chinsyo on 15/6/16.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import "BaseModel.h"

@interface CityMapModel : BaseModel

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *cnname;
@property (nonatomic, copy) NSString *enname;
@property (nonatomic, copy) NSString *lat;
@property (nonatomic, copy) NSString *lng;
@property (nonatomic, copy) NSString *mapstatus;
@property (nonatomic, copy) NSString *is_recommend;
@property (nonatomic, copy) NSString *planto;
@property (nonatomic, copy) NSString *beento;
@property (nonatomic, copy) NSString *beenstr;
@property (nonatomic, copy) NSString *grade;
@property (nonatomic, copy) NSString *photo;

@end
