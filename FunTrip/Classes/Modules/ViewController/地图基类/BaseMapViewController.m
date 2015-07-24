//
//  BaseMapViewController.m
//  Travel
//
//  Created by Chinsyo on 15/6/19.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import "BaseMapViewController.h"

@interface BaseMapViewController ()<MKMapViewDelegate>



@end

@implementation BaseMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addMapView];
}

- (void)addMapView
{
    self.mapView=[[MKMapView alloc]initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height-70)];
    self.mapView.delegate=self;
    [self.view addSubview:self.mapView];
}


#pragma mark - 懒加载
- (NSMutableArray *)dataArray
{
    if (_dataArray==nil) {
        _dataArray=[[NSMutableArray alloc]init];
    }
    return _dataArray;
}

#pragma mark - <MKMapViewDelegate>
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKAnnotationView   *myAnnotationView = (MKAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:ANNOTATION_ID];
    if (myAnnotationView == nil) {
        myAnnotationView = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:ANNOTATION_ID];
    }
    myAnnotationView.canShowCallout = YES;
    myAnnotationView.image=[UIImage imageNamed:@"ic_map_scenic_recommend"];
    myAnnotationView.frame=CGRectMake(0, 0, 21, 28);
    return myAnnotationView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    MKPointAnnotation * annotation=(MKPointAnnotation *)view.annotation;
    LocationModel * model=objc_getAssociatedObject(annotation, "model");
    if (self.currentView==nil) {
        self.currentView=view;
        view.image=[UIImage imageNamed:@"ic_map_scenic_recommend_pressed.png"];
        view.frame=CGRectMake(0, 0, 21, 28);
    } else if (self.currentView!=view) {
        self.currentView.selected=NO;
        self.currentView.image=[UIImage imageNamed:@"ic_map_scenic_recommend.png"];
        self.currentView.frame=CGRectMake(0, 0, 21, 28);
        self.currentView=view;
        self.currentView.selected=YES;
        view.image=[UIImage imageNamed:@"ic_map_scenic_recommend_pressed.png"];
        view.frame=CGRectMake(0, 0, 21, 28);
    }
    [self changeRegionOfMap:model];
}

- (void)changeRegionOfMap:(LocationModel *)model
{
    MKCoordinateRegion region=self.mapView.region;
    region.center=CLLocationCoordinate2DMake([model.lat floatValue], [model.lng floatValue]);
    [self.mapView setRegion:region animated:YES];
}

@end
