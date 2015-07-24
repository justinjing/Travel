//
//  CircleButtonController.m
//  Travel
//
//  Created by Chinsyo on 15/6/15.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import "CircleButtonController.h"
#import "CircleButtonCell.h"
#import "DataEngine.h"
#import "AnalyticalNetWorkData.h"
#import "TypeModel.h"
#import "EntryModel.h"
#import "CircleButtonCell.h"
#import "CustomNavBarController.h"
#import "MapViewController.h"

#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
#define TBL_CELL_ID @"tableViewCellId"
#define COLLCETION_VIEW_CELL_ID @"collectionViewCellId"

@interface CircleButtonController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic) UITableView * tableView;
@property (nonatomic) UIView * backView;
@property (nonatomic) UIView * filterView;
@property (nonatomic) UIView * sortView;

@property (nonatomic) NSMutableArray * entryArray;
@property (nonatomic) NSMutableArray * typeArray;


@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *rightImage;

@property (nonatomic) NSInteger index;
@property (nonatomic) UICollectionView * filterCollectionView;

@end

@implementation CircleButtonController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTableView];
    [self initUIWithCategory];
    [self addBottomViewWithImageName:self.imageName];
    [self fetchDataWithUrl];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self addRightButton];
}

- (void)initUIWithCategory
{
    NSArray *categoryIDArray=@[@"32",@"78",@"147",@"148"];
    self.index=[categoryIDArray indexOfObject:self.categoryID];
    NSArray *imageNameArray=@[@"view",@"food",@"shopping",@"act"];
    self.imageName=[imageNameArray objectAtIndex:self.index];
    NSArray *leftTitleNameArray=@[@"景点",@"美食",@"购物",@"活动"];
    self.leftTitle.text=[leftTitleNameArray objectAtIndex:self.index];
    self.imageName=[imageNameArray objectAtIndex:self.index];
    self.bar.barTintColor=[self.colorArray objectAtIndex:self.index];
}

- (void)addTableView
{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 70, WIDTH, HEIGHT-120)];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    UINib * nib=[UINib nibWithNibName:@"CircleButtonCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:TBL_CELL_ID];
    [self.view addSubview:self.tableView];
}

- (void)addRightButton
{
    UIBarButtonItem * rightItem=self.rightButtonDict[@"map"];
    [self.navItem setRightBarButtonItem:rightItem];
    [self.bar pushNavigationItem:self.navItem animated:YES];
}

- (void)addBottomViewWithImageName:(NSString *)imageName
{
    self.bottomView=[[UIView alloc]initWithFrame:(CGRectMake(0, HEIGHT-50, WIDTH, 50))];
    self.bottomView.backgroundColor=[UIColor whiteColor];
    
    UIView * topView=[[UIView alloc]initWithFrame:(CGRectMake(0, 0, WIDTH, 1))];
    topView.backgroundColor=[UIColor  grayColor];
    [self.bottomView addSubview:topView];
    
    CGFloat buttonWidth=(WIDTH-1)/2.0;
    UIButton * leftButton=[UIButton buttonWithType:(UIButtonTypeCustom)];
    [leftButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"ic_poilist_filter_%@",imageName]] forState:(UIControlStateNormal)];
    [leftButton setTitle:@"筛选" forState:(UIControlStateNormal)];
    [leftButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    leftButton.frame=CGRectMake(0, 0, buttonWidth, 50);
    leftButton.imageEdgeInsets=UIEdgeInsetsMake(10, ((buttonWidth-30)/5)*2, 10, ((buttonWidth-30)/5)*3);
    leftButton.titleEdgeInsets=UIEdgeInsetsMake(5,0, 10, ((buttonWidth-30)/5));
    [leftButton addTarget:self action:@selector(filter) forControlEvents:(UIControlEventTouchUpInside)];
    [self.bottomView addSubview:leftButton];
    
    UIView * middileView=[[UIView alloc]initWithFrame:(CGRectMake(buttonWidth, 10, 1, 30))];
    middileView.backgroundColor=[UIColor  grayColor];
    [self.bottomView addSubview:middileView];
    
    UIButton * rightButton=[UIButton buttonWithType:(UIButtonTypeCustom)];
    [rightButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"ic_poilist_sort_%@",imageName]] forState:(UIControlStateNormal)];
    [rightButton setTitle:@"排序" forState:(UIControlStateNormal)];
    [rightButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    rightButton.imageEdgeInsets=UIEdgeInsetsMake(10, ((buttonWidth-30)/5)*2, 10, ((buttonWidth-30)/5)*3);
    rightButton.frame=CGRectMake((WIDTH-1)/2.0+1, 0, (WIDTH-1)/2.0, 50);
    rightButton .titleEdgeInsets=UIEdgeInsetsMake(5,0, 10, ((buttonWidth-30)/5));
    [rightButton addTarget:self action:@selector(sort) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.bottomView addSubview:rightButton];
    [self.view addSubview:self.bottomView];
}

- (void)map
{
    NSDictionary * dic=[[NSDictionary alloc]initWithObjects:@[self.categoryID,self.cityID] forKeys:@[@"cate_id",@"city_id"]];
    MapViewController * mapVC=[[MapViewController alloc]init];
    mapVC.dict=dic;
    mapVC.index=self.index;
    mapVC.type=@"poi";
    [self.navigationController pushViewController:mapVC animated:YES];
}

- (void)filter
{
    //添加筛选背景半透明图
    [self addFilterBackView];
    
    self.filterView=[[UIView alloc]initWithFrame:(CGRectMake(20, 100, WIDTH-40, HEIGHT-200))];
    self.filterView.layer.cornerRadius=4;
    self.filterView.backgroundColor=[UIColor whiteColor];
    //添加筛选title
    [self addFilterTitleLabel];
    //添加filterCollectionView
    [self addFilterCollectionView];
    //添加筛选底部button
    [self addFilterBottomButton];
    [self.view addSubview:self.filterView];
}

//添加筛选背景半透明图
- (void)addFilterBackView
{
    self.backView=[[UIView alloc]initWithFrame:(CGRectMake(0, 0, WIDTH, HEIGHT))];
    self.backView.backgroundColor=[UIColor blackColor];
    self.backView.alpha=0.5;
    [self.view addSubview:self.backView];
}

//添加筛选title
- (void)addFilterTitleLabel
{
    UILabel * label=[[UILabel alloc]initWithFrame:(CGRectMake(20, 20, 100, 30))];
    label.text=@"筛选";
    label.font=[UIFont boldSystemFontOfSize:18];
    [self.filterView addSubview:label];
}

//添加filterCollectionView
- (void)addFilterCollectionView
{
    UICollectionViewFlowLayout * flowLayout=[[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumInteritemSpacing=10;
    flowLayout.minimumLineSpacing=10;
    flowLayout.sectionInset=UIEdgeInsetsMake(10, 10, 10, 10);
    
    self.filterCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 50, WIDTH-40,self.filterView.self.frame.size.height-100) collectionViewLayout:flowLayout];
    self.filterCollectionView.backgroundColor=[UIColor whiteColor];
    self.filterCollectionView.delegate=self;
    self.filterCollectionView.dataSource=self;
    [self.filterCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:COLLCETION_VIEW_CELL_ID];
    [self.filterView addSubview:self.filterCollectionView];
}

//添加筛选底部button
-(void)addFilterBottomButton
{
    UIButton * bottomButton=[UIButton buttonWithType:(UIButtonTypeCustom)];
    bottomButton.frame=CGRectMake(self.filterView.frame.size.width-70, self.filterView.frame.size.height-40, 60, 30);
    [bottomButton setTitle:@"确认" forState:(UIControlStateNormal)];
    [bottomButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [bottomButton addTarget:self action:@selector(verify) forControlEvents:(UIControlEventTouchUpInside)];
    [self.filterView addSubview:bottomButton];
}

//底部button触发事件
- (void)verify
{
    [self.filterView removeFromSuperview];
    [self.backView removeFromSuperview];
}

- (void)sort
{
    
}

- (void)fetchDataWithUrl
{
    [[DataEngine shareInstance]requestDetailCityCricleButtonWithCategoryId:self.categoryID cityID:self.cityID success:^(NSData *respondsObject) {
        NSMutableArray * tempArray=[AnalyticalNetWorkData parseDetailCityCircleButtonData:respondsObject];
        self.typeArray=tempArray[0];
        self.entryArray=tempArray[1];
        [self.tableView reloadData];
    } faile:^(NSError *error) {
        
    }];
}

#pragma mark - 懒加载
- (NSMutableArray *)typeArray
{
    if (_typeArray==nil) {
        _typeArray=[[NSMutableArray alloc]init];
    }
    return _typeArray;
}

- (NSMutableArray *)entryArray
{
    if (_entryArray==nil) {
        _entryArray=[[NSMutableArray alloc]init];
    }
    return _entryArray;
}

#pragma mark - <UITableViewDataSource,UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.entryArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CircleButtonCell * cell=[self.tableView dequeueReusableCellWithIdentifier:TBL_CELL_ID forIndexPath:indexPath];
    EntryModel * model=[self.entryArray objectAtIndex:indexPath.row];
    [cell initUIWithModel:model];
    return cell;
}

#pragma mark - <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.typeArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TypeModel * model=[self.typeArray objectAtIndex:indexPath.row];
    UILabel * label=[[UILabel alloc]initWithFrame:CGRectZero];
    label.font=[UIFont systemFontOfSize:20];
    label.backgroundColor=[UIColor grayColor];
    label.text=model.name;
    CGSize desize=[label sizeThatFits:CGSizeMake(CGFLOAT_MAX,40)];
    return CGSizeMake(desize.width+20, 40);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell=[self.filterCollectionView dequeueReusableCellWithReuseIdentifier:COLLCETION_VIEW_CELL_ID forIndexPath:indexPath];
    TypeModel * model=[self.typeArray objectAtIndex:indexPath.row];
    UILabel * label=[[UILabel alloc]initWithFrame:CGRectZero];
    label.font=[UIFont systemFontOfSize:20];
    label.textAlignment=NSTextAlignmentCenter;
    label.backgroundColor=[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
    label.text=model.name;
    cell.backgroundView=label;
    return cell;
}

@end
