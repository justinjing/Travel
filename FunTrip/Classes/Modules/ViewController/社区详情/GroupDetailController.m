//
//  GroupDetailController.m
//  Travel
//
//  Created by Chinsyo on 15/6/11.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import "GroupDetailController.h"
#import "UIImageView+WebCache.h"
#import "GroupDetailCell.h"
#import "DataEngine.h"
#import "AnalyticalNetWorkData.h"
#import "GroupDetailModel.h"
#import "DetailViewController.h"


#define TBL_CELL_ID @"groupDetailCellId"

#define BASETAG  110

@interface GroupDetailController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic) UITableView *tableView;
@property (nonatomic) UIButton  *currentButton;
@property (nonatomic) NSInteger currentPage;
@property (nonatomic) UIView  *sliderForButton;
@property (nonatomic) NSString *currentType;
@property (nonatomic) NSString *forum_type;

@property (nonatomic) BOOL isLoading;

@property (nonatomic) UIImageView *topImageView;
@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UILabel *countLabel;

@property (nonatomic) NSMutableArray *allDataArray;
@property (nonatomic) NSMutableDictionary *postDict;

@end

@implementation GroupDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentPage=1;
    _isLoading=NO;
    self.leftTitle.text=self.model.name;
    
    self.postDict=[[NSMutableDictionary alloc]init];
    self.forum_type=[self.model.types objectAtIndex:0][@"id"];
    
    self.view.backgroundColor=[UIColor whiteColor];
    [self initPostDict];
    [self addHeadView];
    [self addSliderForButton];
    [self addHeadButton];
    [self addTableView];
    [self updateHeadViewWithModel:self.model];
    [self loadGroupAllData];
}

- (void)initPostDict
{
    [self.postDict setObject:self.model.id forKey:@"forum_id"];
    [self.postDict setObject:[NSString stringWithFormat:@"%ld",(long)self.currentPage] forKey:@"page"];
}

- (void)addHeadView
{
    CGRect frame=CGRectMake(20, 84, 80, 80);
    self.topImageView=[[UIImageView alloc]initWithFrame:frame];
    [self.view addSubview:self.topImageView];
    
    frame.origin.x=CGRectGetMaxX(frame)+20;
    frame.origin.y=frame.origin.y+10;
    frame.size.width=200;
    frame.size.height=20;
    self.titleLabel=[[UILabel alloc]initWithFrame:frame];
    self.titleLabel.font=[UIFont boldSystemFontOfSize:20];
    [self.view addSubview:self.titleLabel];
    
    frame.origin.y=CGRectGetMaxY(frame)+10;
    self.countLabel=[[UILabel alloc]initWithFrame:frame];
    self.countLabel.font=[UIFont systemFontOfSize:15];
    self.countLabel.textColor=[UIColor grayColor];
    [self.view addSubview:self.countLabel];
}

- (void)addSliderForButton
{
    self.sliderForButton=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 3)];
    self.sliderForButton.backgroundColor=[UIColor colorWithRed:48/255.0 green:194/255.0 blue:128/255.0 alpha:1.0];
    [self.view addSubview:self.sliderForButton];
}

- (void)addHeadButton
{
    CGRect frame=self.topImageView.frame;
    frame.origin.y=CGRectGetMaxY(frame)+20;
    frame.origin.x=0;
    
    UIImageView *lineImageView=[[UIImageView alloc]initWithFrame:(CGRectMake(0, frame.origin.y, self.view.frame.size.width, 1))];
    lineImageView.backgroundColor=[UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1.0];
    [self.view addSubview:lineImageView];
    
    frame.origin.y+=1;
    frame.size.width=60;
    frame.size.height=40;
    NSArray * titleArray=@[@"全部",@"最新",@"精华",@"讨论"];
    for (int index=0; index<4; index++) {
        UIButton * button=[UIButton buttonWithType:(UIButtonTypeCustom)];
        frame.origin.x=index*frame.size.width;
        button.frame=frame;
        button.titleLabel.font=[UIFont boldSystemFontOfSize:18];
        [button setTitle:titleArray[index] forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor blackColor] forState:(UIControlStateSelected)];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        button.tag=BASETAG+index;
        
        if (index==0) {
            button.selected=YES;
            _currentButton=button;
            CGRect sliderFrame=self.sliderForButton.frame;
            sliderFrame.origin.y=CGRectGetMaxY(button.frame);
            self.sliderForButton.frame=sliderFrame;
            self.currentType=@"all";
        }
        [self.view addSubview:button];
    }
    
    UIImageView * lineImageView_1=[[UIImageView alloc]initWithFrame:(CGRectMake(0, frame.origin.y+43, self.view.frame.size.width, 1))];
    lineImageView_1.backgroundColor=[UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1.0];
    [self.view addSubview:lineImageView_1];
}

- (void)buttonClick:(UIButton *)button
{
    if(_currentButton!=button){
        _currentButton.selected=NO;
        _currentButton=button;
        button.selected=!button.selected;
        
        [UIView animateWithDuration:0.5 animations:^{
            CGRect frame=self.sliderForButton.frame;
            frame.origin.x=button.frame.origin.x;
            self.sliderForButton.frame=frame;
        }];
        self.tableView.contentOffset=CGPointMake(0,0);
        self.currentPage=1;
        [self.postDict removeObjectForKey:@"forum_type"];
        [self.postDict removeObjectForKey:@"type"];
        switch (button.tag-BASETAG) {
            case 0:
                self.currentType=@"all";
                [self.postDict setObject:self.currentType forKey:@"type"];
                break;
            case 1:
                self.currentType=@"new";
                [self.postDict setObject:self.currentType forKey:@"type"];
                break;
            case 2:
                self.currentType=@"digest";
                [self.postDict setObject:self.currentType forKey:@"type"];
                break;
            case 3:
                [self.postDict setObject:self.forum_type forKey:@"forum_type"];
                break;
            default:
                break;
        }
        [self initPostDict];
        [self loadGroupAllData];
    }
}

- (void)addTableView
{
    CGRect frame=self.sliderForButton.frame;
    frame.origin.y=CGRectGetMaxY(frame)+1;
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, frame.origin.y, self.view.frame.size.width, self.view.frame.size.height-frame.origin.y)];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    UINib * nib=[UINib nibWithNibName:@"GroupDetailCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:TBL_CELL_ID];
    [self.view addSubview:self.tableView];
}

- (void)updateHeadViewWithModel:(GroupModel *)model
{
    [self.topImageView sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:[UIImage imageNamed:@"zbg_p9_cover_def_mid_round_corner.9.png"]];
    self.titleLabel.text=model.name;
    self.countLabel.text=[NSString stringWithFormat:@"%@个主题",model.total_threads];
}

//加载全部栏目的数据
- (void)loadGroupAllData
{
    _isLoading=YES;
    
    [[DataEngine shareInstance]requestGroupDetailDataWithDict:self.postDict success:^(NSData *respondsObject) {
        self.allDataArray=[AnalyticalNetWorkData parseGroupDetailData:respondsObject];
        [self.tableView reloadData];
        
    } faild:^(NSError *error) {
        
    }];
    _isLoading=NO;
}

#pragma mark - 懒加载
-(NSMutableArray *)allDataArray
{
    if (_allDataArray==nil) {
        _allDataArray=[[NSMutableArray alloc]init];
    }
    return _allDataArray;
}

#pragma mark - <UITableViewDataSource,UITableViewDelegate>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allDataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GroupDetailCell * cell=[self.tableView dequeueReusableCellWithIdentifier:TBL_CELL_ID forIndexPath:indexPath];
    GroupDetailModel * model=[self.allDataArray objectAtIndex:indexPath.row];
    [cell updateCellWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GroupDetailModel * model=[self.allDataArray objectAtIndex:indexPath.row];
    DetailViewController * controller=[[DetailViewController alloc]init];
    controller.url=model.view_url;
    controller.title=model.title;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - 上拉刷新
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    float height = scrollView.contentSize.height > _tableView.frame.size.height ?_tableView.frame.size.height : scrollView.contentSize.height;
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
    [[DataEngine shareInstance]requestGroupDetailDataWithDict:self.postDict success:^(NSData *respondsObject) {
        NSArray * temArray=[AnalyticalNetWorkData parseGroupDetailData:respondsObject];
        for (GroupDetailModel * model in temArray) {
            [self.allDataArray addObject:model];
        }
        [self.tableView reloadData];
    } faild:^(NSError *error) {
        
    }];
}

@end
