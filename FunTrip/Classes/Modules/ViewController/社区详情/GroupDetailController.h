//
//  GroupDetailController.h
//  Travel
//
//  Created by Chinsyo on 15/6/11.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupModel.h"
#import "GroupDetailModel.h"
#import "CustomNavBarController.h"



@interface GroupDetailController : CustomNavBarController

@property (nonatomic) NSString *id;

@property (nonatomic) GroupModel * model;

-(void)updateHeadViewWithModel:(GroupModel *)model;



@end
