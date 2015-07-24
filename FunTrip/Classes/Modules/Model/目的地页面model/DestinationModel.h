//
//  DestinationModel.h
//  Travel
//
//  Created by Chinsyo on 15/6/5.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import "BaseModel.h"

@interface DestinationModel : BaseModel<NSCoding>

//第一层model属性
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *cnname;
@property (nonatomic, copy) NSString *enname;
@property (nonatomic) NSArray *hot_country;
@property (nonatomic) NSArray *country;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *count;
@property (nonatomic, copy) NSString *label;
@property (nonatomic) NSInteger flag;

@end

