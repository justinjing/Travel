//
//  DestinationView.m
//  Travel
//
//  Created by Chinsyo on 15/6/5.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import "DestinationView.h"
#import "DestinationCollectionViewCell.h"
#import "OtherCountryCell.h"
#import "HeadViewForSection.h"
#import "HeadViewForDestinationView.h"

#define COLLCETION_VIEW_CELL_ID @"collectionViewCellId"
#define OTHERCOUNTRY_CELL_ID  @"otherCountryCellID"
#define HEADVIEW_FORSECTION_ID @"headViewForSectionId"
#define HEADVIEW_FORDESTINATION_ID @"headViewForDestinationId"


@interface DestinationView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic) UICollectionView * collectionView;
@property (nonatomic) NSArray * buttonDataArray;
@property (nonatomic) NSArray * hot_countryDataArray;
@property (nonatomic) NSArray * countryDataArray;
@property (nonatomic) NSInteger currentAreaInArray;

@end

@implementation DestinationView

- (id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self addCollectionView:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _currentAreaInArray=0;
    }
    return self;
}

- (void)addCollectionView:(CGRect)frame
{
    UICollectionViewFlowLayout * flowLayout=[[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumInteritemSpacing=10;
    flowLayout.minimumLineSpacing=10;
    flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset=UIEdgeInsetsMake(10, 10, 10, 10);
    flowLayout.headerReferenceSize=CGSizeMake(self.frame.size.width, 30);
    
    _collectionView=[[UICollectionView alloc]initWithFrame:frame collectionViewLayout:flowLayout];
    _collectionView.backgroundColor=[UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    _collectionView.dataSource=self;
    _collectionView.delegate=self;
    _collectionView.bounces=NO;

    UINib *hotCountryNib=[UINib nibWithNibName:@"DestinationCollectionViewCell" bundle:nil];
    [_collectionView registerNib:hotCountryNib forCellWithReuseIdentifier:COLLCETION_VIEW_CELL_ID];
    
    UINib *otherCountryNib=[UINib nibWithNibName:@"OtherCountryCell" bundle:nil];
    [_collectionView registerNib:otherCountryNib forCellWithReuseIdentifier:OTHERCOUNTRY_CELL_ID];
    
    [_collectionView registerClass:[HeadViewForSection class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HEADVIEW_FORSECTION_ID];
    
    UINib *headForDestinationNib=[UINib nibWithNibName:@"HeadViewForDestinationView" bundle:nil];
    [_collectionView registerNib:headForDestinationNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HEADVIEW_FORDESTINATION_ID];
    
    [self addSubview:_collectionView];
}

////第二个界面view的数据存储,需要三个数组,对应button数组,hot_country数组,country数组
//hot_countr里面包含7个数组,对应7大洲,每个数组里面7个对象
//country里面7个数组对应7大洲,每个数组里面7个对象
-(void)setDataArray:(NSArray *)dataArray
{
    _dataArray=dataArray;
    _buttonDataArray=[_dataArray objectAtIndex:0];
    _hot_countryDataArray=[_dataArray objectAtIndex:1];
    _countryDataArray=[_dataArray objectAtIndex:2];
    [self.collectionView reloadData];
}

#pragma mark - <UICollectionViewDataSource,UICollectionViewDelegate>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section
{
    if (section==0) {
        NSArray * hotCountryArray=[_hot_countryDataArray objectAtIndex:_currentAreaInArray];
        return [hotCountryArray count];
    } else {
        if (_currentAreaInArray<=5) {
            NSArray * countryArray=[_countryDataArray objectAtIndex:_currentAreaInArray];
            return [countryArray count];
        }
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        DestinationCollectionViewCell * cell=[_collectionView dequeueReusableCellWithReuseIdentifier:COLLCETION_VIEW_CELL_ID forIndexPath:indexPath];
        DestinationModel * model=[[_hot_countryDataArray objectAtIndex:_currentAreaInArray] objectAtIndex:indexPath.row];
        [cell updateCollectionViewCellWithModel:model];
        return cell;
    } else {
        OtherCountryCell * cell=[_collectionView dequeueReusableCellWithReuseIdentifier:OTHERCOUNTRY_CELL_ID forIndexPath:indexPath];
        DestinationModel * model=[[_countryDataArray objectAtIndex:_currentAreaInArray] objectAtIndex:indexPath.row];
        [cell updateCollectionViewCellWithModel:model];
        return cell;
    }
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        DestinationModel * model=[_buttonDataArray objectAtIndex:_currentAreaInArray];
        NSString *areaHotName=[NSString stringWithFormat:@"%@热门目的地",model.cnname];
        NSString *areaName=[NSString stringWithFormat:@"%@其他目的地",model.cnname];
        switch (indexPath.section) {
            case 0:{
                HeadViewForDestinationView * headView=[_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:HEADVIEW_FORDESTINATION_ID forIndexPath:indexPath];
                [headView setAreaBlock:^(NSInteger tag){
                    if (_currentAreaInArray!=tag) {
                        _currentAreaInArray=tag-3400;
                        [self.collectionView reloadData];
                    }
                }];
                [headView updateHeadLabelWithString:areaHotName];
                return headView;
            }
            case 1:{
                HeadViewForSection * headView=[_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:HEADVIEW_FORSECTION_ID forIndexPath:indexPath];
                [headView updateHeadLabelWithString:areaName];
                return headView;
            }
            default:
                break;
        }
    }
    return nil;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        CGFloat width=(self.frame.size.width-30)/2.0;
        CGSize size=CGSizeMake(width, 60);
        return size;
    } else {
        CGFloat width=(self.frame.size.width-30)/2.0;
        CGFloat height=self.frame.size.width-75;
        CGSize size=CGSizeMake(width, height);
        return  size;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize size;
    if (section==0) {
        size = CGSizeMake(self.frame.size.width, 300);
        return size;
    } else if (_currentAreaInArray<=5) {
        size = CGSizeMake(self.frame.size.width, 30);
    } else {
        size = CGSizeZero;
    }
    return size;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //得到具体的类型,是热门国家还是其他国家
    NSArray * contryArray=[self.dataArray objectAtIndex:indexPath.section+1];
    //得到和头视图对应的选项的大洲
    NSArray * areaArray=[contryArray objectAtIndex:_currentAreaInArray];
    DestinationModel * model=[areaArray objectAtIndex:indexPath.row];
    if (_clickCountryBlock) {
        _clickCountryBlock(model);
    }
}


@end
