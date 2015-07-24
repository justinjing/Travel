//
//  lucencyNavBarBaseController.h
//  Travel
//
//  Created by Chinsyo on 15/6/17.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"


@interface LucencyNavBarBaseController : UIViewController

@property (nonatomic) UINavigationBar *bar;
@property (nonatomic) UIView *lucencyView;
@property (nonatomic) UILabel *leftTitle;

- (void)map:(UIButton *)button;

@end
