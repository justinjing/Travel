//
//  DetailViewController.m
//  Travel
//
//  Created by Chinsyo on 15/6/4.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import "DetailViewController.h"
#import <WebKit/WebKit.h>

@interface DetailViewController ()<WKNavigationDelegate>

@property (nonatomic) WKWebView * webView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView=[[WKWebView alloc]initWithFrame:(CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height-70))];
    self.webView.navigationDelegate=self;
    self.leftTitle.text=self.title;
    
    NSURLRequest * request=[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:_url]];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
     [SVProgressHUD showWithStatus:@"努力加载中"];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [SVProgressHUD showSuccessWithStatus:@"加载完成"];
}

@end
