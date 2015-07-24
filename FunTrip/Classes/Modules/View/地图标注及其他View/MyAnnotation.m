//
//  MyAnnotation.m
//  Travel
//
//  Created by Chinsyo on 15/6/16.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation

//当呼出视图显示时，调用title作为呼出视图的标题显示
- (NSString*)title
{
    return self.myTitle;
}

//当呼出视图显示时，调用suttitle作为呼出视图的副标题显示
- (NSString*)subtitle
{
    return self.mySubTitle;
}

- (CLLocationCoordinate2D)coordinate
{
    return self.myCoordinate;
}

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate
{
    self.myCoordinate = newCoordinate;
}


@end
