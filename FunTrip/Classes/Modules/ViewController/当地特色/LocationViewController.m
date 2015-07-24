//
//  LocationViewController.m
//  Travel
//
//  Created by Chinsyo on 15/6/12.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import "LocationViewController.h"
#import "LocationHeadView.h"
#import "LocationCollectCell.h"
#import "DataEngine.h"
#import "AnalyticalNetWorkData.h"
#import "LocationHeadModel.h"
#import "MapWithoutURLController.h"
#import "UMSocial.h"

#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
#define COLLECT_HEAD_VIEW_CELL @"collectionHeadViewCellID"
#define COLLECT_VIEW_CELL @"collectionViewCellID"

@interface LocationViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate,UMSocialUIDelegate>

@property (nonatomic) UICollectionView * collectionView;
@property (nonatomic) NSMutableArray * dataArray;
@property (nonatomic) UIButton * shareButton;
@property (nonatomic) LocationHeadModel * model;

@end

@implementation LocationViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self addCollectionView];
    [self fetchDataWithUrl];
    [self addShareItem];
    [self.view insertSubview:self.collectionView atIndex:0];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
    self.collectionView.contentOffset=CGPointMake(0, 20);
    self.bar.alpha=0.0;
}



- (void)addShareItem
{
    self.shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.shareButton setFrame:CGRectMake(WIDTH-100, 10, 30, 30)];
    [self.shareButton setImage:[UIImage imageNamed:@"ic_share_white.png"] forState:(UIControlStateNormal)];
    [self.shareButton addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [ self.lucencyView addSubview:self.shareButton];
}

- (void)map:(UIButton *)button
{
    MapWithoutURLController * VC=[[MapWithoutURLController alloc]init];
    VC.dataArray=self.dataArray;
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)share
{
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"55555dc167e58e7bb20054bc"
                                      shareText:@"友盟社会化分享让您快速实现分享等社会化功能，http://umeng.com/social"
                                     shareImage:[UIImage imageNamed:@"icon"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,nil]
                                       delegate:self];
}

- (void)addCollectionView
{
    UICollectionViewFlowLayout * flowLayout=[[UICollectionViewFlowLayout alloc]init];
    flowLayout.sectionInset=UIEdgeInsetsMake(10, 15, 10, 15);
    
    self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-20) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor=[UIColor whiteColor];
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    
    UINib *cellNib=[UINib nibWithNibName:@"LocationCollectCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:COLLECT_VIEW_CELL];
    
    UINib *nib=[UINib nibWithNibName:@"LocationHeadView" bundle:nil];
    [self.collectionView registerNib:nib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:COLLECT_HEAD_VIEW_CELL];
    [self.view addSubview:self.collectionView];
}

- (void)fetchDataWithUrl
{
    [[DataEngine shareInstance]requestRecommendLocationDataWithPage:self.id success:^(NSData *respondsObject) {
        NSMutableArray * reciveArray=[AnalyticalNetWorkData parseRecommendLocation:respondsObject];
        self.dataArray=reciveArray[1];
        self.model=[reciveArray objectAtIndex:0];
        self.leftTitle.text=self.model.title;
        [self.collectionView reloadData];
    } faild:^(NSError *error) {
        
    }];
}

#pragma mark - <UICollectionViewDataSource,UICollectionViewDelegate>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LocationCollectCell * cell=[self.collectionView dequeueReusableCellWithReuseIdentifier:COLLECT_VIEW_CELL forIndexPath:indexPath];
    LocationModel * model=[self.dataArray objectAtIndex:indexPath.row];
    cell.layer.borderColor=[UIColor darkGrayColor].CGColor;
    cell.layer.borderWidth=0.3;
    [cell updateCollectionCellWithModel:model];
    return cell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    LocationHeadView * headView=[self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:COLLECT_HEAD_VIEW_CELL forIndexPath:indexPath];
    [headView updateHeadViewWithModel:self.model];
    return headView;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArray>0) {
        LocationCollectCell * cell=[[LocationCollectCell alloc]init];
        LocationModel * model=[self.dataArray objectAtIndex:indexPath.row];
        CGFloat height=[cell getCellHeightWithModel:model width:self.view.frame.size.width-30];
        CGSize size=CGSizeMake(self.view.frame.size.width-30, height);
        return size;
    } else {
        return CGSizeZero;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    LocationHeadView * headView=[[LocationHeadView alloc]init];
    CGFloat height= [headView getHeadHeightWithModel:self.model width:self.view.frame.size.width-55];
    CGSize size=CGSizeMake(self.view.frame.size.width, height);
    return size;
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.collectionView.contentOffset.y<20) {
        self.collectionView.contentOffset=CGPointMake(0, 20);
    }
    self.bar.alpha=(self.collectionView.contentOffset.y-20)/200;
}

- (void)dealloc
{
    [self.shareButton removeFromSuperview];
}

@end
