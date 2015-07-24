//
//  HeadViewForSection.m
//  Travel
//
//  Created by Chinsyo on 15/6/6.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import "HeadViewForSection.h"

@implementation HeadViewForSection


- (id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.headLabel=[[UILabel alloc]initWithFrame:(CGRectMake(20, 5, 200, 25))];
        self.backgroundColor=[UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];

        self.headLabel.textColor=[UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1.0];
        self.headLabel.font=[UIFont boldSystemFontOfSize:18];
        [self addSubview:_headLabel];
    }
    return self;
}

- (void)updateHeadLabelWithString:(NSString *)string
{
    self.headLabel.text=string;
}

@end
