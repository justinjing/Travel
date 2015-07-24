//
//  DataEngine.m
//  Travel
//
//  Created by Chinsyo on 15/6/3.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import "DataEngine.h"
#import "AFNetworking.h"
#import "URLDefine.h"
#import "SVProgressHUD.h"

@implementation DataEngine
{
    AFHTTPRequestOperationManager * _manager;
}

- (id)init
{
    if (self=[super init]) {
        _manager=[AFHTTPRequestOperationManager manager];
        //指定返回二进制数据
        //        [_manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    }
    return self;
}

+ (instancetype)shareInstance
{
    static DataEngine *s_dataEngine=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_dataEngine=[[DataEngine alloc]init];
    });
    return s_dataEngine;
}

- (void)requestRecommendData:(SuccessBlockType)success faild:(FailedBlockType)failed
{
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0]];
    [SVProgressHUD showWithStatus:@"努力加载中"];
    [_manager GET:REC_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD dismiss];
        success(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败了"];
        failed(error);
    }];
}

- (void)requestDestinationData:(SuccessBlockType)success faild:(FailedBlockType)failed
{
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0]];
    [SVProgressHUD showWithStatus:@"努力加载中"];
    [_manager GET:DES_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD dismiss];
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败了"];
        failed(error);
    }];
}

- (void)requestGroupData:(SuccessBlockType)success faild:(FailedBlockType)failed
{
    
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0]];
    [SVProgressHUD showWithStatus:@"努力加载中"];
    [_manager GET:GROUO_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD dismiss];
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败了"];
        failed(error);
    }];
}


- (void)requestRecommendCellDataWithPage:(NSInteger)pageNo success:(SuccessBlockType)success faild:(FailedBlockType)failed
{
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0]];
    [SVProgressHUD showWithStatus:@"努力加载中"];
    [_manager GET:[NSString stringWithFormat:REC_CELL_URL,(long)pageNo] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD showSuccessWithStatus:@"加载完成"];
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败了"];
        failed(error);
    }];
    
}

- (void)requestGroupDetailDataWithDict:(NSDictionary *)dict success:(SuccessBlockType)success faild:(FailedBlockType)failed
{
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0]];
    [SVProgressHUD showWithStatus:@"努力加载中"];
    [_manager POST:GROUP_DETAIL_URL_POST parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD showSuccessWithStatus:@"加载完成"];
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败了"];
        failed(error);
    }];
}

//获取推荐页面玩当地特色数据
- (void)requestRecommendLocationDataWithPage:(NSString *)pageID success:(SuccessBlockType)success faild:(FailedBlockType)failed
{
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0]];
    [SVProgressHUD showWithStatus:@"努力加载中"];
    [_manager GET:[NSString stringWithFormat:LOCATION_URL,pageID] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD showSuccessWithStatus:@"加载完成"];
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败了"];
        failed(error);
    }];
    
}

//获取目的地界面具体国家数据
- (void)requestDestinationDetailCountryDataWithCountryID:(NSString *)countryId success:(SuccessBlockType)success faild:(FailedBlockType)failed
{
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0]];
    [SVProgressHUD showWithStatus:@"努力加载中"];
    NSString *url=[NSString stringWithFormat:DES_DETAIL_COUNTRY_URL,countryId];
    [_manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD showSuccessWithStatus:@"加载完成"];
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败了"];
        failed(error);
    }];
}

//获取目的地界面具体城市数据
- (void)requestDestinationDetailCityDataWithCityID:(NSString *)cityId success:(SuccessBlockType)success faild:(FailedBlockType)failed
{
    
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0]];
    [SVProgressHUD showWithStatus:@"努力加载中"];
    NSString *url=[NSString stringWithFormat:DES_DETAIL_CITY_URL,cityId];
    [_manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD showSuccessWithStatus:@"加载完成"];
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败了"];
        failed(error);
    }];
}


//获取目的地具体城市页面圆形按钮点击数据
- (void)requestDetailCityCricleButtonWithCategoryId:(NSString *)categoryId cityID:(NSString *)cityId success:(SuccessBlockType)success faile:(FailedBlockType)failed
{
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0]];
    [SVProgressHUD showWithStatus:@"努力加载中"];
    NSString *url=[NSString stringWithFormat:DES_DETAIL_CITY_CORCLE_BUTTON_URL,cityId,categoryId];
    [_manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD showSuccessWithStatus:@"加载完成"];
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败了"];
        failed(error);
    }];
}

//按钮点击进入地图
- (void)requestMapWithDict:(NSDictionary *)dict type:(NSString *)type success:(SuccessBlockType)success faile:(FailedBlockType)failed
{
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0]];
    [SVProgressHUD showWithStatus:@"努力加载中"];
    [_manager POST:[NSString stringWithFormat:MAP_URL,type] parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD showSuccessWithStatus:@"加载完成"];
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败了"];
        failed(error);
    }];
}

@end
