//
//  LocationHeadModel.h
//  Travel
//
//  Created by Chinsyo on 15/6/15.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import "BaseModel.h"

@interface LocationHeadModel : BaseModel

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *count;
@end
