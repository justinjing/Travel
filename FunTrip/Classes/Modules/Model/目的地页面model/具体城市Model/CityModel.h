//
//  CityModel.h
//  Travel
//
//  Created by Chinsyo on 15/6/13.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface CityModel : BaseModel

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *country_id;
@property (nonatomic, copy) NSString *planto;
@property (nonatomic, copy) NSString *beento;
@property (nonatomic, copy) NSString *overview_url;
@property (nonatomic, copy) NSString *selecthotel_url;
@property (nonatomic, copy) NSArray *photos;
@property (nonatomic) BOOL has_guide;
@property (nonatomic) BOOL has_plan;
@property (nonatomic, copy) NSString *country_cnname;
@property (nonatomic, copy) NSString *country_enname;
@property (nonatomic, copy) NSString *cnname;
@property (nonatomic, copy) NSString *enname;
@property (nonatomic) BOOL has_trip;


@end
