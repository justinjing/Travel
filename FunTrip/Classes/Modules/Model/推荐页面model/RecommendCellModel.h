//
//  RecommendCellModel.h
//  Travel
//
//  Created by Chinsyo on 15/6/11.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import "BaseModel.h"

@interface RecommendCellModel : BaseModel

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *lastpost;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *replys;
@property (nonatomic, copy) NSString *likes;
@property (nonatomic, copy) NSString *view_url;
@property (nonatomic, copy) NSString *view_author_url;
@property (nonatomic) int views;
@property (nonatomic, copy) NSString *digest_level;
@end
