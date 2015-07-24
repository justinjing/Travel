//
//  CustomNavBarController.h
//  Travel
//
//  Created by Chinsyo on 15/6/16.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"

@interface CustomNavBarController : UIViewController

@property (nonatomic) UINavigationBar * bar;

@property (nonatomic) UINavigationItem * navItem;

@property (nonatomic, copy) NSString *categoryID;

@property (nonatomic, copy) NSString *cityID;

@property (nonatomic) NSMutableDictionary * rightButtonDict;

@property (nonatomic) NSArray * colorArray;

@property (nonatomic) NSArray * annotationImageArray;

@property (nonatomic) UILabel * leftTitle;

-(void)addCustomNavgationBar;

@end
