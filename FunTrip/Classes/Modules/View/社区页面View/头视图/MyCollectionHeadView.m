//
//  MyCollectionHeadView.m
//  Travel
//
//  Created by Chinsyo on 15/6/8.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import "MyCollectionHeadView.h"

@implementation MyCollectionHeadView

- (id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        UIView * view=[[UIView alloc]initWithFrame:(CGRectMake(10, 0, frame.size.width-20, frame.size.height))];
        view.backgroundColor=[UIColor whiteColor];
        
        self.label=[[UILabel alloc]initWithFrame:(CGRectMake(10, 5, frame.size.width-40, frame.size.height-5))];
        self.label.textColor=[UIColor grayColor];
        self.label.font=[UIFont boldSystemFontOfSize:18];
        [view addSubview:self.label];
        [self addSubview:view];
    }
    return self;
}



@end
