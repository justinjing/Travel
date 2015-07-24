//
//  AnalyticalNetWorkData.m
//  Travel
//
//  Created by Chinsyo on 15/6/5.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import "AnalyticalNetWorkData.h"
#import "GroupDetailModel.h"
#import "RecommendModel.h"
#import "DestinationModel.h"
#import "GroupModel.h"
#import "RecommendCellModel.h"
#import "LocationModel.h"
#import "DesCountryModel.h"
#import "DesHotCityModel.h"
#import "CityModel.h"
#import "LocationHeadModel.h"
#import "TypeModel.h"
#import "EntryModel.h"
#import "CityMapModel.h"
#import "LocalModel.h"
#import "PriceOffModel.h"

@implementation AnalyticalNetWorkData

+ (NSMutableArray *)parseRecommendData:(id)responseObject
{
    NSMutableArray * recommendDataArray=[NSMutableArray array];
    NSDictionary * oraginDict=(NSDictionary *)responseObject;
    NSDictionary * dataDict=oraginDict[@"data"];
    NSArray * nameArray=@[@"slide",@"subject",@"discount",@"mguide"];
    for (int index=0;index<4;index++) {
        NSArray * array=dataDict[nameArray[index]];
        NSMutableArray * tempArray=[[ NSMutableArray alloc]init];
        for (NSDictionary * dict in array) {
            RecommendModel * model=[[RecommendModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            [tempArray addObject:model];
        }
        [recommendDataArray addObject:tempArray];
    }
    return recommendDataArray;
}


+ (NSMutableArray *)parseDestinationData:(id)responseObject
{
    NSMutableArray * destinationDataArray=[NSMutableArray array];
    
    NSDictionary * oraginDict=(NSDictionary *)responseObject;
    
    NSArray * dataArray=oraginDict[@"data"];
    
    NSMutableArray * buttonArray=[[NSMutableArray alloc]init];
    NSMutableArray * hotCountryArray=[[NSMutableArray alloc]init];
    NSMutableArray * countryArray=[[NSMutableArray alloc]init];
    //解析第一层数据
    for (NSDictionary * firstDic in dataArray) {
        DestinationModel * continentModel=[[DestinationModel alloc]init];
        [continentModel setValuesForKeysWithDictionary:firstDic];
        [buttonArray addObject:continentModel];
        
        //解析热门目的地数据
        NSMutableArray * firstHotArray=[self analyticalDataForDestinationModelArray:continentModel.hot_country];
        [hotCountryArray addObject:firstHotArray];
        
        //解析其他目的地数据
        NSMutableArray * firstCountryArray=[self analyticalDataForDestinationModelArray:continentModel.country];
        [countryArray addObject:firstCountryArray];
        
    }
    
    [destinationDataArray addObject:buttonArray];
    [destinationDataArray addObject:hotCountryArray];
    [destinationDataArray addObject:countryArray];
    
    return destinationDataArray;
}

+ (NSMutableArray *)analyticalDataForDestinationModelArray:(NSArray *)array
{
    NSMutableArray * dataArray=[NSMutableArray array];
    for (NSDictionary * hotCountryDict in array) {
        DestinationModel * model=[[DestinationModel alloc]init];
        [model setValuesForKeysWithDictionary:hotCountryDict];
        [dataArray addObject:model];
    }
    return dataArray;
}

+ (NSMutableArray *)parseGroupData:(id)responseObject
{
    //总数组
    NSMutableArray * dataArray=[[NSMutableArray alloc]init];
    
    
    
    NSDictionary * orginDic=(NSDictionary *)responseObject;
    NSArray * orginArray=orginDic[@"data"];
    for (NSDictionary * dict in orginArray) {
        //二层数组
        NSMutableArray * secondDataArray=[[NSMutableArray alloc]init];
        NSMutableArray * titleModelArray=[[NSMutableArray alloc]init];
        NSMutableArray * cellModelArray=[[NSMutableArray alloc]init];
        GroupModel * model=[[GroupModel alloc]init];
        [model setValuesForKeysWithDictionary:dict];
        [titleModelArray addObject:model];
        
        for (NSDictionary * dic in model.group) {
            GroupModel * model=[[GroupModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [cellModelArray addObject:model];
        }
        [secondDataArray addObject:titleModelArray];
        [secondDataArray addObject:cellModelArray];
        [dataArray addObject:secondDataArray];
    }
    return dataArray;
}

+ (NSMutableArray *)parseRecommendCell:(id)responseObject
{
    NSMutableArray * dataArray=[[NSMutableArray alloc]init];
    
    NSDictionary * orginDic=(NSDictionary *)responseObject;
    NSArray * orginArray=orginDic[@"data"];
    
    for (NSDictionary * dict in orginArray) {
        RecommendCellModel * cellModel=[[RecommendCellModel alloc]init];
        [cellModel setValuesForKeysWithDictionary:dict];
        [dataArray addObject:cellModel];
    }
    return dataArray;
}

+ (NSMutableArray *)parseGroupDetailData:(id)responseObject
{
    NSMutableArray * dataArray=[[NSMutableArray alloc]init];
    
    NSDictionary * orginDic=(NSDictionary *)responseObject;
    NSDictionary * orginDict=orginDic[@"data"];
    NSArray * orginArray=orginDict[@"entry"];
    for (NSDictionary * dict in orginArray) {
        GroupDetailModel * model=[[GroupDetailModel alloc]init];
        [model setValuesForKeysWithDictionary:dict];
        [dataArray addObject:model];
    }
    return dataArray;
}

//解析推荐页面当地特色栏目信息并返回
+ (NSMutableArray *)parseRecommendLocation:(id)responseObject
{
    NSMutableArray * dataArray=[[NSMutableArray alloc]init];
    
    NSMutableArray * cellArray=[[NSMutableArray alloc]init];
    NSDictionary * orginDic=(NSDictionary *)responseObject;
    NSDictionary * orginDict=orginDic[@"data"];
    LocationHeadModel * model=[[LocationHeadModel alloc]init];
    [model setValuesForKeysWithDictionary:orginDict];
    NSArray * orginArray=orginDict[@"pois"];
    for (NSDictionary * dict in orginArray) {
        LocationModel * model=[[LocationModel alloc]init];
        [model setValuesForKeysWithDictionary:dict];
        [cellArray addObject:model];
    }
    [dataArray addObject:model];
    [dataArray addObject:cellArray];
    
    return dataArray;
}

//解析目的地界面具体国家信息并返回
+ (NSMutableArray *)parseDestinationDetailCountryData:(id)responseObject
{
    NSMutableArray * dataArray=[[NSMutableArray alloc]init];
    NSDictionary * orginDic=(NSDictionary *)responseObject;
    NSDictionary * dict=orginDic[@"data"];
    //二层数组
    NSMutableArray * countryDataArray=[[NSMutableArray alloc]init];
    NSMutableArray * hotCityDataArray=[[NSMutableArray alloc]init];
    NSMutableArray * disCountDataArray=[[NSMutableArray alloc]init];
    NSMutableArray * tripDataArray=[[NSMutableArray alloc]init];
    
    DesCountryModel  * model=[[DesCountryModel alloc]init];
    
    model.cnname=dict[@"cnname"];
    model.enname=dict[@"enname"];
    model.photos=dict[@"photos"];
    model.id=dict[@"id"];
    [countryDataArray addObject:model];
    
    
    for (NSDictionary * hotDic in dict[@"hot_city"]) {
        DesHotCityModel * model=[[DesHotCityModel alloc]init];
        [model setValuesForKeysWithDictionary:hotDic];
        [hotCityDataArray addObject:model];
    }
    for (NSDictionary * disDic in dict[@"new_discount"]) {
        PriceOffModel * model=[[PriceOffModel alloc]init];
        [model setValuesForKeysWithDictionary:disDic];
        [disCountDataArray addObject:model];
    }
    for (NSDictionary * tripDic in dict[@"hot_mguide"]) {
        LocalModel * model=[[LocalModel alloc]init];
        [model setValuesForKeysWithDictionary:tripDic];
        [tripDataArray addObject:model];
    }
    [dataArray addObject:countryDataArray];
    [dataArray addObject:hotCityDataArray];
    [dataArray addObject:tripDataArray];
    [dataArray addObject:disCountDataArray];
    return dataArray;
}

//解析目的地界面具体城市信息并返回
+ (NSMutableArray *)parseDestinationDetailCityData:(id)responseObject
{
    NSMutableArray * dataArray=[[NSMutableArray alloc]init];
    NSDictionary * orginDic=(NSDictionary *)responseObject;
    NSDictionary * dict=orginDic[@"data"];
    //二层数组
    NSMutableArray * hotMguideDataArray=[[NSMutableArray alloc]init];
    NSMutableArray * newDiscountDataArray=[[NSMutableArray alloc]init];
    
    CityModel  * model=[[CityModel alloc]init];
    [model setValuesForKeysWithDictionary:dict];


    for (NSDictionary * hotDic in dict[@"hot_mguide"]) {
        LocalModel * model=[[LocalModel alloc]init];
        [model setValuesForKeysWithDictionary:hotDic];
        [hotMguideDataArray addObject:model];
    }
    for (NSDictionary * disDic in dict[@"new_discount"]) {
        PriceOffModel * model=[[PriceOffModel alloc]init];
        [model setValuesForKeysWithDictionary:disDic];
        [newDiscountDataArray addObject:model];
    }

    [dataArray addObject:model];
    [dataArray addObject:hotMguideDataArray];
    [dataArray addObject:newDiscountDataArray];

    return dataArray;
}

//解析具体城市页面圆形button数据并返回
+ (NSMutableArray *)parseDetailCityCircleButtonData:(id)responseObject
{
    NSMutableArray * dataArray=[[NSMutableArray alloc]init];
    NSDictionary * orginDic=(NSDictionary *)responseObject;
    NSDictionary * dict=orginDic[@"data"];
    //二层数组
    NSMutableArray * typeModelArray=[[NSMutableArray alloc]init];
    NSMutableArray * entryModelArray=[[NSMutableArray alloc]init];
    
    for (NSDictionary * hotDic in dict[@"types"]) {
        TypeModel * model=[[TypeModel alloc]init];
        [model setValuesForKeysWithDictionary:hotDic];
        [typeModelArray addObject:model];
    }
    for (NSDictionary * disDic in dict[@"entry"]) {
        EntryModel * model=[[EntryModel alloc]init];
        [model setValuesForKeysWithDictionary:disDic];
        [entryModelArray addObject:model];
    }
    [dataArray addObject:typeModelArray];
    [dataArray addObject:entryModelArray];
    return dataArray;
}

//解析圆形button具体地图数据并返回
+ (NSMutableArray *)parseMapData:(id)responseObject
{
    NSMutableArray * dataArray=[[NSMutableArray alloc]init];
    NSDictionary * orginDic=(NSDictionary *)responseObject;
    NSArray * orginArray=orginDic[@"data"];
    for (NSDictionary * dict in orginArray) {
        CityMapModel * model=[[CityMapModel alloc]init];
        [model setValuesForKeysWithDictionary:dict];
        [dataArray addObject:model];
    }
    return dataArray;
}

@end
