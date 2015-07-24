//
//  CustomNavBarController.m
//  Travel
//
//  Created by Chinsyo on 15/6/16.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import "CustomNavBarController.h"
#import "MapViewController.h"
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height

@interface CustomNavBarController ()



@end

@implementation CustomNavBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initRightButtonDict];
    [self initColorArray];
    [self initAnnotationImageNameArray];
    [self addCustomNavgationBar];
    [self addLeftTitleForCustomNavBar];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.navItem  setRightBarButtonItem:nil];
}

- (void)initRightButtonDict
{
    self.rightButtonDict=[[NSMutableDictionary alloc]init];
    NSArray * imageNameArray=@[@"share",@"map",@"heart"];
    for (int index=0; index<imageNameArray.count; index++) {
        UIBarButtonItem * barButton=[self addRightButtonWithImage:imageNameArray[index]];
        [self.rightButtonDict setValue:barButton forKey:imageNameArray[index]];
    }
}

- (void)initColorArray
{
    UIColor * firstColor=[UIColor colorWithRed:208/255.0 green:147/255.0 blue:215/255.0 alpha:1.0];
    UIColor * secondColor=[UIColor colorWithRed:249/255.0 green:132/255.0 blue:116/255.0 alpha:1.0];
    UIColor * thirdColor=[UIColor colorWithRed:255/255.0 green:216/255.0 blue:111/255.0 alpha:1.0];
    UIColor * fourthColor=[UIColor colorWithRed:100/255.0 green:216/255.0 blue:229/255.0 alpha:1.0];
    self.colorArray=@[firstColor,secondColor,thirdColor,fourthColor];
}

- (void)initAnnotationImageNameArray
{
    self.annotationImageArray=@[@"_scenic",@"_food",@"_shopping",@"_activity"];
}

- (UIBarButtonItem *)addRightButtonWithImage:(NSString *)imageName
{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [rightButton setFrame:CGRectMake(WIDTH-50, -100, 30, 30)];
    [rightButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"ic_%@_white.png",imageName]] forState:(UIControlStateNormal)];
    [rightButton addTarget:self action:NSSelectorFromString(imageName) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    return rightButtonItem;
}

- (void)share
{
    
}

- (void)map
{
    
}

- (void)heart
{
    
}

- (void)addCustomNavgationBar
{
    self.view.backgroundColor=[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    self.navigationController.navigationBarHidden = YES;
    self.bar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20,WIDTH, 50)];
    self.bar.barTintColor=[UIColor colorWithRed:35/255.0 green:169/255.0 blue:118/255.0 alpha:1.0];
    self.navItem = [[UINavigationItem alloc] initWithTitle:nil];
    
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [left setImage:[UIImage imageNamed:@"ic_back_white.png"] forState:(UIControlStateNormal)];
    [left setFrame:CGRectMake(0, 10, 30, 30)];
    [left addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:left];
    
    [self.navItem setLeftBarButtonItem:leftButton];
    [self.bar pushNavigationItem:self.navItem animated:NO];
    [self.view addSubview:self.bar];
}

- (void)addLeftTitleForCustomNavBar
{
    self.leftTitle=[[UILabel alloc]initWithFrame:(CGRectMake(50,8,self.view.frame.size.width-150, 40))];
    self.leftTitle.numberOfLines=0;
    self.leftTitle.font=[UIFont boldSystemFontOfSize:18];
    self.leftTitle.textColor=[UIColor whiteColor];
    [self.bar addSubview:self.leftTitle];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
