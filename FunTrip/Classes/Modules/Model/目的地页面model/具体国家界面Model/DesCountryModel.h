//
//  DesCountryModel.h
//  Travel
//
//  Created by Chinsyo on 15/6/12.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import "BaseModel.h"

@interface DesCountryModel : BaseModel

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *cnname;
@property (nonatomic, copy) NSString *enname;
@property (nonatomic) NSArray *photos;
@property (nonatomic) NSArray *hot_city;
@property (nonatomic) NSArray *n_discount;
@property (nonatomic) NSArray *n_trip;

@end
