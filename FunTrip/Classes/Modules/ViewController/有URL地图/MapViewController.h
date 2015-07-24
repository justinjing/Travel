//
//  MapViewController.h
//  Travel
//
//  Created by Chinsyo on 15/6/16.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseMapViewController.h"

@interface MapViewController : BaseMapViewController

@property (nonatomic) NSInteger index;
@property (nonatomic) NSDictionary * dict;
@property (nonatomic, copy) NSString *type;

- (void)bottomViewClick:(UITapGestureRecognizer *)tap;

@end
