//
//  MyImageView.m
//  Travel
//
//  Created by Chinsyo on 15/6/4.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import "MyImageView.h"

@implementation MyImageView

- (id)initWithFrame:(CGRect)frame url:(NSString *)urlLink title:(NSString *)title
{
    if (self=[super initWithFrame:frame]) {
        UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageClick:)];
        self.userInteractionEnabled=YES;
        [self addGestureRecognizer:tap];
        self.url=urlLink;
        self.title=title;
    }
    return self;
}

- (void)imageClick:(UITapGestureRecognizer *)tap
{
    if (self.title.length==0) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"DetailVCWithUrl" object:self.url];
    }else{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"DetailVCWithUrl" object:self.url userInfo:@{@"title":self.title}];
    }
}

@end
