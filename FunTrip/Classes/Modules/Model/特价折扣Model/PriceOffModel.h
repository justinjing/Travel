//
//  PriceOffModel.h
//  Travel
//
//  Created by Chinsyo on 15/6/18.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import "BaseModel.h"

@interface PriceOffModel : BaseModel

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *priceoff;
@property (nonatomic, copy) NSString *expire_date;
@property (nonatomic, copy) NSString *end_date;
@property (nonatomic, copy) NSString *photo;

@end

