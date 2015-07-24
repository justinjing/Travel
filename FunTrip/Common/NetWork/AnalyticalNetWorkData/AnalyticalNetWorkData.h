//
//  AnalyticalNetWorkData.h
//  Travel
//
//  Created by Chinsyo on 15/6/5.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface AnalyticalNetWorkData : NSObject

//解析推荐页面的信息并返回
+(NSMutableArray *)parseRecommendData:(id)responseObject;

//解析目的地页面的信息并返回
+(NSMutableArray *)parseDestinationData:(id)responseObject;

//解析社区页面信息并返回
+(NSMutableArray *)parseGroupData:(id)responseObject;

//解析推荐页面的cell信息并返回
+(NSMutableArray *)parseRecommendCell:(id)responseObject;

//解析社区二级页面全部栏目的cell信息并返回
+(NSMutableArray *)parseGroupDetailData:(id)responseObject;

//解析推荐页面当地特色栏目信息并返回
+(NSMutableArray *)parseRecommendLocation:(id)responseObject;

//解析目的地界面具体国家信息并返回
+(NSMutableArray *)parseDestinationDetailCountryData:(id)responseObject;

//解析目的地界面具体城市信息并返回
+(NSMutableArray *)parseDestinationDetailCityData:(id)responseObject;

//解析具体城市页面圆形button数据并返回
+(NSMutableArray *)parseDetailCityCircleButtonData:(id)responseObject;

//解析圆形button具体地图数据并返回
+(NSMutableArray *)parseMapData:(id)responseObject;

@end
