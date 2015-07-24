//
//  GroupView.m
//  Travel
//
//  Created by Chinsyo on 15/6/8.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import "GroupView.h"
#import "MyCollectionViewCell.h"
#import "MyCollectionHeadView.h"

#define COLLECTION_VIEW_CELL_ID @"collectionViewCellId"
#define MY_COLLECTION_HEAD_VIEW @"myCollectionHeadViewId"

@interface GroupView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic) UICollectionView * collectionView;

@end


@implementation GroupView

- (id)initWithFrame:(CGRect)frame
{
    if ( self=[super initWithFrame:frame]) {
        [self addCollectionViewWithFrame:frame];
        self.dataArray=[[NSArray alloc]init];
    }
    return self;
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray=dataArray;
    [self.collectionView reloadData];
}

- (void)addCollectionViewWithFrame:(CGRect)frame
{
    UICollectionViewFlowLayout * flowLayout=[[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize=CGSizeMake((frame.size.width-20)/2.0, 80);
    flowLayout.minimumInteritemSpacing=0;
    flowLayout.minimumLineSpacing=0;
    flowLayout.sectionInset=UIEdgeInsetsMake(0, 10, 10, 10);
    flowLayout.headerReferenceSize=CGSizeMake(frame.size.width, 40);
    
    self.collectionView=[[UICollectionView alloc]initWithFrame:(CGRectMake(0, 0, frame.size.width, frame.size.height)) collectionViewLayout:flowLayout];
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    _collectionView.backgroundColor=[UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    UINib * nib=[UINib nibWithNibName:@"MyCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:COLLECTION_VIEW_CELL_ID];
    
    [self.collectionView registerClass:[MyCollectionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MY_COLLECTION_HEAD_VIEW];
    [self addSubview:self.collectionView];
}

#pragma mark - <UICollectionViewDelegate,UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.dataArray count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  [[[self.dataArray objectAtIndex:section] objectAtIndex:1]count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell * cell=[self.collectionView dequeueReusableCellWithReuseIdentifier:COLLECTION_VIEW_CELL_ID forIndexPath:indexPath];
    GroupModel * model=[[[self.dataArray objectAtIndex:indexPath.section] objectAtIndex:1]objectAtIndex:indexPath.row];
    [cell updateCellViewWithModel:model];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionHeadView * headView=[self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:MY_COLLECTION_HEAD_VIEW forIndexPath:indexPath];
   GroupModel * model=[[[self.dataArray objectAtIndex:indexPath.section]objectAtIndex:0]objectAtIndex:0];
    headView.label.text=model.name;
    return headView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GroupModel * model=[[[self.dataArray objectAtIndex:indexPath.section] objectAtIndex:1]objectAtIndex:indexPath.row];
    self.groupBlock(model);
}

@end
