//
//  RecommedView.m
//  Travel
//
//  Created by Chinsyo on 15/6/3.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import "RecommendView.h"
#import "RecommendHeadView.h"
#import "DataEngine.h"
#import "RecommendCellModel.h"
#import "AnalyticalNetWorkData.h"
#import "RecommendTVCell.h"
#import "PriceOffView.h"
#import "LocalColoringView.h"
#import "SectionFootView.h"
#import "SectionHeadView.h"
#import "URLDefine.h"
#import "LocalModel.h"
#import <objc/message.h>

#define COLLECT_VIEW_HEAD @"headViewForAllViewId"
#define COLLECT_VIEW_SECTION_HEAD @"headForSectionId"
#define COLLECT_VIEW_SECTION_FOOT @"footForSectionId"
#define COLLECT_VIWE_TBL_CELLID @"tableViewCellID"
#define COLLECT_PRICE_OFF_ID @"priceOffCellId"
#define COLLECT_LOCAL_OFF_ID @"LocalColoringCellId"

@interface RecommendView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property (nonatomic) NSMutableArray * dataArray;
@property (nonatomic) NSInteger currentPage;
@property (nonatomic) NSMutableArray * tableDataArray;
@property (nonatomic) NSMutableArray * discountDataArray;
@property (nonatomic) NSMutableArray * locationDataArray;
@property (nonatomic) BOOL isLoading;

@end

@implementation RecommendView

- (id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        self.currentPage=0;
        
        _isLoading=NO;
        
        [self initArray];
        
        [self addCollectViewWithFrame:frame];
        
    }
    return self;
}

- (void)initArray
{
    self.dataArray=[NSMutableArray array];
    self.tableDataArray=[NSMutableArray array];
    self.discountDataArray=[NSMutableArray array];
    self.locationDataArray=[NSMutableArray array];
}

- (void)addCollectViewWithFrame:(CGRect)frame
{
    UICollectionViewFlowLayout * flowLayout=[[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumInteritemSpacing=0;
    flowLayout.minimumLineSpacing=0;
    flowLayout.sectionInset=UIEdgeInsetsMake(0, 10, 0, 10);
    self.collectionView=[[UICollectionView alloc]initWithFrame:(CGRectMake(0, 0, frame.size.width, frame.size.height)) collectionViewLayout:flowLayout];
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    self.collectionView.backgroundColor=[UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    
    [self registNibForCollectionView];
    
    [self addSubview:self.collectionView];
}

- (void)registNibForCollectionView
{
    UINib * priceNib=[UINib nibWithNibName:@"PriceOffView" bundle:nil];
    [self.collectionView registerNib:priceNib forCellWithReuseIdentifier:COLLECT_PRICE_OFF_ID];
    
    UINib * locationNib=[UINib nibWithNibName:@"LocalColoringView" bundle:nil];
    [self.collectionView registerNib:locationNib forCellWithReuseIdentifier:COLLECT_LOCAL_OFF_ID];
    
    UINib * tableNib=[UINib nibWithNibName:@"RecommendTVCell" bundle:nil];
    [self.collectionView registerNib:tableNib forCellWithReuseIdentifier:COLLECT_VIWE_TBL_CELLID];
    
    UINib * headNib=[UINib nibWithNibName:@"SectionHeadView" bundle:nil];
    [self.collectionView registerNib:headNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:COLLECT_VIEW_SECTION_HEAD];
    
    UINib * footNib=[UINib nibWithNibName:@"SectionFootView" bundle:nil];
    [self.collectionView registerNib:footNib forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                 withReuseIdentifier:COLLECT_VIEW_SECTION_FOOT];
    
    UINib * headForAllNib=[UINib nibWithNibName:@"RecommendHeadView" bundle:nil];
    [self.collectionView registerNib:headForAllNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                 withReuseIdentifier:COLLECT_VIEW_HEAD];
}

//接收数据更新UI
- (void)updateRecommendView:(NSMutableArray *)dataArray
{
    self.dataArray=dataArray;
    self.discountDataArray=[dataArray objectAtIndex:2];
    self.locationDataArray=[dataArray objectAtIndex:3];
    [self.collectionView reloadData];
}

#pragma mark - <UICollectionViewDelegate,UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    switch (section) {
        case 1: return self.discountDataArray.count;
        case 2: return self.locationDataArray.count;
        case 3: return self.tableDataArray.count;
        default: return 0;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 1:{
            PriceOffView * priceCell=[self.collectionView dequeueReusableCellWithReuseIdentifier:COLLECT_PRICE_OFF_ID forIndexPath:indexPath];
            RecommendModel * recommendModel=[self.discountDataArray objectAtIndex:indexPath.row];
            PriceOffModel * model=(PriceOffModel *)recommendModel;
            [priceCell updateUIWithModel:model flag:1];
            return priceCell;
        }
        case 2:{
            LocalColoringView * locationCell=[self.collectionView dequeueReusableCellWithReuseIdentifier:COLLECT_LOCAL_OFF_ID forIndexPath:indexPath];
            RecommendModel * recommendModel=[self.locationDataArray objectAtIndex:indexPath.row];
            LocalModel * model=(LocalModel *)recommendModel;
            [locationCell updateUIWithRecommendModel:model];
            return locationCell;
        }
        case 3:{
            RecommendTVCell * recommendCell=[self.collectionView dequeueReusableCellWithReuseIdentifier:COLLECT_VIWE_TBL_CELLID forIndexPath:indexPath];
            RecommendCellModel * model=[self.tableDataArray objectAtIndex:indexPath.row];
            [recommendCell updateCellWithModel:model];
            return recommendCell;
        }
        default:
            return nil;
    }
}

#pragma mark-----<UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width=(self.frame.size.width-20)/2.0;
    switch (indexPath.section) {
        case 1: return CGSizeMake(width, 230);
        case 2: return CGSizeMake(width, 210);
        case 3: return CGSizeMake(self.frame.size.width-20, 80);
        default: return CGSizeZero;
    }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGFloat width=self.frame.size.width-20;
    CGSize  size=CGSizeMake(width,70);
    if (section==0) {
        size=CGSizeMake(self.frame.size.width,636);
    }
    return size;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section==1) {
        CGFloat width=self.frame.size.width-20;
        CGSize size=CGSizeMake(width,50);
        return size;
    }
    return CGSizeZero;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            RecommendHeadView * headView=[self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier: COLLECT_VIEW_HEAD forIndexPath:indexPath];
            [headView updateRecommendHeadView:self.dataArray];
            return headView;
        }
    } else {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            //返回Header视图
            SectionHeadView * headView=[self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier: COLLECT_VIEW_SECTION_HEAD forIndexPath:indexPath];
            
            NSArray * array=@[@"抢特价折扣",@"玩当地特色",@"看热门游记"];
            headView.headTitle.text=[array objectAtIndex:indexPath.section-1];
            
            return headView;
        } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
            //返回Footer视图
            if (indexPath.section==1) {
                SectionFootView * footView=[self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:COLLECT_VIEW_SECTION_FOOT forIndexPath:indexPath];
                return footView;
            }
        }
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 1:{
            PriceOffModel * model=[self.discountDataArray objectAtIndex:indexPath.row];
            NSString *url=[NSString stringWithFormat:DISCOUNT_URL,model.id];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"DetailVCWithUrl" object:url userInfo:@{@"title":model.title}];
            break;
        }
        case 2:{
            RecommendModel * model=[self.locationDataArray objectAtIndex:indexPath.row];
            if (_locationClickBlock) {
                _locationClickBlock(model);
            }
            break;
        }
        case 3:{
            RecommendCellModel * model=[self.tableDataArray objectAtIndex:indexPath.row];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"DetailVCWithUrl" object:model.view_url userInfo:@{@"title":model.title}];
            break;
        }
            
        default:
            break;
    }
    
}

#pragma mark---上拉刷新

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    float height = scrollView.contentSize.height > _collectionView.frame.size.height ?_collectionView.frame.size.height : scrollView.contentSize.height;
    if (_isLoading==NO) {
        if ((height - scrollView.contentSize.height + scrollView.contentOffset.y) / height > 0.1) {
            _isLoading=YES;
            self.currentPage++;
            // 调用上拉刷新方法
            [self refreshCell];
        }
        _isLoading=NO;
    }
}

- (void)refreshCell
{
    [[DataEngine shareInstance]requestRecommendCellDataWithPage:self.currentPage success:^(NSData *respondsObject) {
        NSArray * temArray=[AnalyticalNetWorkData parseRecommendCell:respondsObject];
        for (RecommendCellModel * model in temArray) {
            [self.tableDataArray addObject:model];
        }
        [self.collectionView reloadData];
    } faild:^(NSError *error) {
        
    }];
}

@end
