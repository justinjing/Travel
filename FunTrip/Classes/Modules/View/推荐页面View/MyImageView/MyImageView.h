//
//  MyImageView.h
//  Travel
//
//  Created by Chinsyo on 15/6/4.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendModel.h"

@interface MyImageView : UIImageView

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *title;

- (id)initWithFrame:(CGRect)frame url:(NSString *)urlLink title:(NSString *)title;

@end
