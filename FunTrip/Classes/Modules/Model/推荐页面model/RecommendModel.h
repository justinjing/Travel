//
//  RecommendModel.h
//  Travel
//
//  Created by Chinsyo on 15/6/3.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import "BaseModel.h"

@interface RecommendModel : BaseModel<NSCoding>


@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *count;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *end_date;
@property (nonatomic, copy) NSString *priceoff;


@end
