//
//  MainViewController.m
//  Travel
//
//  Created by Chinsyo on 15/6/23.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import "MainViewController.h"
#import "SVProgressHUD.h"
#import "URLDefine.h"
#import "DataEngine.h"
#import "RecommendModel.h"
#import "RecommendView.h"
#import "DetailViewController.h"
#import "DestinationView.h"
#import "AnalyticalNetWorkData.h"
#import "GroupView.h"
#import "CoreDataManager.h"
#import "GroupDetailController.h"
#import "LocationViewController.h"
#import "DesCountryControlle.h"
#import "DesCityController.h"

#define COLLECTIONVIEW_CELLID @"collectionViewCellId"

#define SCREEN_WIDTH  self.view.frame.size.width

#define SCREEN_HEIGHT self.view.frame.size.height

#define WHITESLIDERPADDING  60


@interface MainViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic) UIButton * currentButton;
@property (nonatomic)UICollectionView *HomeCollectionView;
@property (weak, nonatomic) IBOutlet UIView *whiteSliderForHeadButton;
//推荐界面view的数据存储
//数组中包含了四个数组,分别对应
//[@"slide",@"subject",@"discount",@"mguide"];
@property (nonatomic) NSMutableArray * recommendDataArray;

//第二个界面view的数据存储,需要三个数组,对应button数组,hot_country数组,country数组
//hot_countr里面包含7个数组,对应7大洲,每个数组里面7个对象
//country里面7个数组对应7大洲,每个数组里面7个对象
@property (nonatomic) NSMutableArray * destinationDataArray;

//第三个view的数据存储
//数组中每一项都包含两个数组,第一个数组表示头标题,第二个表示内部的model
@property (nonatomic) NSMutableArray * groupDataArray;

//推荐页面的view
@property (nonatomic) RecommendView * recommendView;

//目的地界面的view
@property (nonatomic) DestinationView * destinationView;

//社区页面的view
@property (nonatomic) GroupView * groupView;

@end

@implementation MainViewController

//注册collectionView的cell
- (void)awakeFromNib
{
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    [self addHomeCollectionView];
    [self addRecommendView];
    //使用coreData数据渲染
    NSMutableArray * temRecArray=[[CoreDataManager defaultCoreManager]fetchModelFromCoreDataWithEntityName:@"Entity"];
    [self.recommendView updateRecommendView:temRecArray];
    
    [self addDestinationView];
    //使用coreData数据渲染
    NSMutableArray * temDesArray=[[CoreDataManager defaultCoreManager]fetchModelFromCoreDataWithEntityName:@"Entity1"];
    self.destinationView.dataArray=temDesArray;
    
    [self addGroupView];
    [self loadRecommendData];
    [self loadDestinationData];
    [self loadGroupData];
}

- (void)initView
{
    //隐藏navigationBar
    self.navigationController.navigationBarHidden=YES;
    //设置当前selected的按钮
    _currentButton=(UIButton *)[self.view viewWithTag:10000];
    _currentButton.selected=YES;
}

- (void)addHomeCollectionView
{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize=CGSizeMake(self.view.frame.size.width, self.view.frame.size.height-80);
    flowLayout.minimumInteritemSpacing=0;
    flowLayout.minimumLineSpacing=0;
    flowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    
    _HomeCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height-70) collectionViewLayout:flowLayout];
    _HomeCollectionView.pagingEnabled=YES;
    _HomeCollectionView.showsHorizontalScrollIndicator=NO;
    _HomeCollectionView.delegate=self;
    _HomeCollectionView.dataSource=self;
    _HomeCollectionView.bounces=NO;
    //注册cell
    [self.HomeCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:COLLECTIONVIEW_CELLID];
    [self.view addSubview:_HomeCollectionView];
}

//使用通知中心观察带URL连接的ID的点击事件
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
    
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reciveImageClick:) name:@"DetailVCWithUrl" object:nil];
}

//接收到通知中心的点击事件后的处理事件
- (void)reciveImageClick:(NSNotification *)notify
{
    NSString * url=(NSString *)notify.object;
    NSString *title=[notify.userInfo objectForKey:@"title"];
    DetailViewController * detailVC=[[DetailViewController alloc]init];
    detailVC.url=url;
    detailVC.title=title;
    [self.navigationController pushViewController:detailVC animated:YES];
}

//添加推荐页面
- (void)addRecommendView
{
    self.recommendView=[[RecommendView alloc]initWithFrame:(CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-70))];
    __weak typeof(self)weakself=self;
    [self.recommendView setLocationClickBlock:^(RecommendModel * model){
        LocationViewController * locationVC=[[LocationViewController alloc]init];
        locationVC.id=model.id;
        [weakself.navigationController pushViewController:locationVC animated:YES];
    }];
    [_HomeCollectionView addSubview:self.recommendView];
}

//添加目的地页面
- (void)addDestinationView
{
    self.destinationView=[[DestinationView alloc]initWithFrame:(CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height-70))];
    __weak typeof(self) weakself = self;
    [self.destinationView setClickCountryBlock:^(DestinationModel * model){
        //如果flag==1表示是国家,否则直接跳转到城市界面
        if (model.flag==1) {
            DesCountryControlle * desVC=[[DesCountryControlle alloc]init];
            desVC.model=model;
            [weakself.navigationController pushViewController:desVC animated:YES];
        }else if(model.flag==2){
            DesCityController * desCityVC=[[DesCityController alloc]init];
            desCityVC.model=(DesHotCityModel *)model;
            [weakself.navigationController pushViewController:desCityVC animated:YES];
        }
    }];
    [_HomeCollectionView addSubview:self.destinationView];
}

//添加社区页面
- (void)addGroupView
{
    self.groupView=[[GroupView alloc]initWithFrame:(CGRectMake(self.view.frame.size.width*2, 0, self.view.frame.size.width, self.view.frame.size.height-70))];
    __weak typeof(self)weakself=self;
    [self.groupView setGroupBlock:^(GroupModel * model){
        GroupDetailController * controller=[[GroupDetailController alloc]init];
        controller.model=model;
        [weakself.navigationController pushViewController:controller animated:YES];
    }];
    [_HomeCollectionView addSubview:self.groupView];
}


//加载推荐页面的数据
- (void)loadRecommendData
{
    [[DataEngine shareInstance]requestRecommendData:^(NSData *respondsObject) {
        self.recommendDataArray=[AnalyticalNetWorkData parseRecommendData:respondsObject];
        [[CoreDataManager defaultCoreManager]removeAllModelFromCoreDataWithEntityName:@"Entity"];
        [[CoreDataManager defaultCoreManager]addModelFromNetWork:self.recommendDataArray entityName:@"Entity"];
        [self.recommendView updateRecommendView:self.recommendDataArray];
    } faild:^(NSError *error) {
        
    }];
}

//加载目的地页面的数据
- (void)loadDestinationData
{
    [[DataEngine shareInstance]requestDestinationData:^(NSData *respondsObject) {
        self.destinationDataArray=[AnalyticalNetWorkData parseDestinationData:respondsObject];
        [[CoreDataManager defaultCoreManager]removeAllModelFromCoreDataWithEntityName:@"Entity1"];
        [[CoreDataManager defaultCoreManager]addModelFromNetWork:self.destinationDataArray entityName:@"Entity1"];
        self.destinationView.dataArray=self.destinationDataArray;
    } faild:^(NSError *error) {
        
    }];
}

//加载社区页面的数据
- (void)loadGroupData
{
    [[DataEngine shareInstance]requestGroupData:^(NSData *respondsObject) {
        self.groupDataArray=[AnalyticalNetWorkData parseGroupData:respondsObject];
        self.groupView.dataArray=self.groupDataArray;
    } faild:^(NSError *error) {
        
    }];
}

#pragma mark - 懒加载区域

- (NSMutableArray *)recommendDataArray
{
    if (_recommendDataArray==nil) {
        _recommendDataArray=[NSMutableArray array];
    }
    return _recommendDataArray;
}

- (NSMutableArray *)destinationDataArray
{
    if (_destinationDataArray==nil) {
        _destinationDataArray=[[NSMutableArray alloc]init];
    }
    return _destinationDataArray;
}

- (NSMutableArray *)groupDataArray
{
    if (_groupDataArray==nil) {
        _groupDataArray=[[NSMutableArray alloc]init];
    }
    return _groupDataArray;
}

#pragma mark  XIB控件
- (IBAction)recommendButton:(UIButton *)button {
    if(_currentButton!=button){
        _currentButton.selected=NO;
        _currentButton=button;
        button.selected=!button.selected;
        [UIView animateWithDuration:0.5 animations:^{
            _HomeCollectionView.contentOffset=CGPointMake(self.view.frame.size.width*(button.tag-10000), 0);
            CGRect frame=_currentButton.frame;
            frame.origin.y=_whiteSliderForHeadButton.frame.origin.y;
            self.whiteSliderForHeadButton.frame=frame;
        }];
    }
}

#pragma mark - <UICollectionViewDataSource,UICollectionViewDelegate>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;//3个区分别为推荐,目的地,社区
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[self.HomeCollectionView dequeueReusableCellWithReuseIdentifier:COLLECTIONVIEW_CELLID forIndexPath:indexPath];
    return cell;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger currentPage=_HomeCollectionView.contentOffset.x/self.view.frame.size.width;
    
    UIButton * button=(UIButton *)[self.view viewWithTag:currentPage+10000];
    if(_currentButton!=button){
        _currentButton.selected=NO;
        _currentButton=button;
        button.selected=!button.selected;
        [UIView animateWithDuration:0.5 animations:^{
            CGRect frame=_currentButton.frame;
            frame.origin.y=_whiteSliderForHeadButton.frame.origin.y;
            self.whiteSliderForHeadButton.frame=frame;
        }];
    }
}

#pragma mark - dealloc
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
