//
//  GroupDetailModel.h
//  Travel
//
//  Created by Chinsyo on 15/6/11.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import "BaseModel.h"

@interface GroupDetailModel : BaseModel

@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *is_top;
@property (nonatomic, copy) NSString *digest_level;
@property (nonatomic, copy) NSString *title;
@property (nonatomic) int lastpost;
@property (nonatomic) int user_id;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *replys;
@property (nonatomic, copy) NSString *likes;
@property (nonatomic, copy) NSString *views;
@property (nonatomic, copy) NSString *view_url;

@end
