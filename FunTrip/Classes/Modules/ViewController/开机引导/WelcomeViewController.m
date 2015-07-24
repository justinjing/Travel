//
//  WelcomeViewController.m
//  Travel
//
//  Created by Chinsyo on 15/6/23.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import "WelcomeViewController.h"
#import "AppDelegate.h"
#import "MainViewController.h"

#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height

@interface WelcomeViewController ()

@property (nonatomic) UIScrollView * scrollView;

@end

@implementation WelcomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.scrollView.pagingEnabled=YES;
    self.scrollView.showsHorizontalScrollIndicator=NO;
    [self addWelcomPages];
    [self.view addSubview:self.scrollView];
}
-(void)addWelcomPages
{
    for (int index=1; index<=4; index++) {
        NSString *imageName=[NSString stringWithFormat:@"bg_about_qyer_img%d.jpg",index];
        NSString *textImageName=[NSString stringWithFormat:@"bg_about_qyer_text%d.png",index];
        
        UIImage * image=[UIImage imageNamed:imageName];
        UIImage * textImage=[UIImage imageNamed:textImageName];
        
        UIImageView * imageView=[[UIImageView alloc]initWithImage:image];
        UIImageView * textImageView=[[UIImageView alloc]initWithImage:textImage];
        
        textImageView.frame=CGRectMake(20, 50, self.view.frame.size.width-40, 100);
        [imageView addSubview:textImageView];
        
        imageView.frame=CGRectMake((index-1)*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        if (index==4) {
            imageView.userInteractionEnabled=YES;
            UIButton * button=[UIButton buttonWithType:(UIButtonTypeCustom)];
            [button setBackgroundImage:[UIImage imageNamed:@"bg_start"] forState:(UIControlStateNormal)];
            button.frame=CGRectMake(80, SCREEN_HEIGHT-80, SCREEN_WIDTH-160, 60);
            [button addTarget:self action:@selector(start) forControlEvents:(UIControlEventTouchUpInside)];
            [imageView addSubview:button];
        }
        [self.scrollView addSubview:imageView];
    }
    //设置scrollView的contentsize
    self.scrollView.contentSize=CGSizeMake(SCREEN_WIDTH*4, SCREEN_HEIGHT);
}

- (void)start
{
    //切换到主视图
    MainViewController * homeVC=[[MainViewController alloc]init];
    UINavigationController * nav=[[UINavigationController alloc]initWithRootViewController:homeVC];
    AppDelegate * delegate=[UIApplication sharedApplication].delegate;
    UIWindow * window=delegate.window;
    window.rootViewController=nav;
}
@end
