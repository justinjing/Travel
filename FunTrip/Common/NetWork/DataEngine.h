//
//  DataEngine.h
//  Travel
//
//  Created by Chinsyo on 15/6/3.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SuccessBlockType) (NSData * respondsObject);
typedef void(^FailedBlockType)(NSError * error);

@interface DataEngine : NSObject
+(instancetype)shareInstance;
//获取推荐页面数据
-(void)requestRecommendData:(SuccessBlockType)success faild:(FailedBlockType)failed;

//获取目的地页面数据
-(void)requestDestinationData:(SuccessBlockType)success faild:(FailedBlockType)failed;

//获取社区页面数据
-(void)requestGroupData:(SuccessBlockType)success faild:(FailedBlockType)failed;

//获取推荐页面刷新CELL数据
-(void)requestRecommendCellDataWithPage:(NSInteger)pageNo success:(SuccessBlockType)success faild:(FailedBlockType)failed;


//获取社区二级页面数据POST方法
-(void)requestGroupDetailDataWithDict:(NSDictionary *)dict success:(SuccessBlockType)success faild:(FailedBlockType)failed;

//获取推荐页面玩当地特色数据
-(void)requestRecommendLocationDataWithPage:(NSString *)pageID success:(SuccessBlockType)success faild:(FailedBlockType)failed;

//获取目的地界面具体国家数据
-(void)requestDestinationDetailCountryDataWithCountryID:(NSString *)countryId success:(SuccessBlockType)success faild:(FailedBlockType)failed;

//获取目的地界面具体城市数据
-(void)requestDestinationDetailCityDataWithCityID:(NSString *)cityId success:(SuccessBlockType)success faild:(FailedBlockType)failed;

//获取目的地具体城市页面圆形按钮点击数据
-(void)requestDetailCityCricleButtonWithCategoryId:(NSString *)categoryId cityID:(NSString *)cityId success:(SuccessBlockType)success faile:(FailedBlockType)failed;

//按钮点击进入地图
-(void)requestMapWithDict:(NSDictionary *)dict type:(NSString *)type  success:(SuccessBlockType)success faile:(FailedBlockType)failed;

@end
