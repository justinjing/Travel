//
//  lucencyNavBarBaseController.m
//  Travel
//
//  Created by Chinsyo on 15/6/17.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import "lucencyNavBarBaseController.h"

#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height

@interface LucencyNavBarBaseController ()

@end

@implementation LucencyNavBarBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCustomNavgationBar];
    [self addLucencyNavBar];
    [self addLeftTitleForCustomNavBar];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
    self.bar.alpha=0.0;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)addCustomNavgationBar
{
    self.view.backgroundColor=[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    self.navigationController.navigationBarHidden=YES;
    self.bar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20,WIDTH, 50)];
    self.bar.barTintColor=[UIColor colorWithRed:35/255.0 green:169/255.0 blue:118/255.0 alpha:1.0];
    [self.view addSubview:self.bar];
}

- (void)addLucencyNavBar
{
    self.lucencyView = [[UIView alloc] initWithFrame:CGRectMake(0, 20,WIDTH, 50)];
    self.lucencyView.backgroundColor=[UIColor clearColor];
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    [left setFrame:CGRectMake(10, 10, 30, 30)];
    [left setImage:[UIImage imageNamed:@"ic_back_white.png"] forState:(UIControlStateNormal)];
    [left addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    [right setFrame:CGRectMake(WIDTH-50, 10, 30, 30)];
    [right setImage:[UIImage imageNamed:@"ic_map_white.png"] forState:(UIControlStateNormal)];
    [right addTarget:self action:@selector(map:) forControlEvents:UIControlEventTouchUpInside];
    
    [ self.lucencyView addSubview:left];
    [ self.lucencyView addSubview:right];
    [self.view addSubview: self.lucencyView];
    
}

-(void)addLeftTitleForCustomNavBar
{
    self.leftTitle=[[UILabel alloc]initWithFrame:(CGRectMake(50,0,self.view.frame.size.width-150, 50))];
    self.leftTitle.numberOfLines=0;
    self.leftTitle.font=[UIFont boldSystemFontOfSize:18];
    self.leftTitle.textColor=[UIColor whiteColor];
    [self.bar addSubview:self.leftTitle];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)map:(UIButton *)button
{
    
}

@end
