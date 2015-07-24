//
//  MapWithoutURLController.m
//  Travel
//
//  Created by Chinsyo on 15/6/18.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import "MapWithoutURLController.h"

@interface MapWithoutURLController ()<MKMapViewDelegate>



@end

@implementation MapWithoutURLController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCoordinateForMap];
    [self addAnnotation];
}



- (void)setCoordinateForMap
{
    LocationModel * model=[self.dataArray objectAtIndex:0];
    CLLocationCoordinate2D coordinate=CLLocationCoordinate2DMake([model.lat floatValue], [model.lng floatValue]);
    MKCoordinateSpan span=MKCoordinateSpanMake(0.2, 0.2);
    MKCoordinateRegion region=MKCoordinateRegionMake(coordinate, span);
    [self.mapView setRegion:region animated:YES];
}

- (void)addAnnotation
{
    int index = 0;
    for (LocationModel * model in self.dataArray) {
        MKPointAnnotation * annotation=[[MKPointAnnotation alloc]init];
        annotation.coordinate=CLLocationCoordinate2DMake([model.lat floatValue], [model.lng floatValue]);
        annotation.title=model.chinesename;
        objc_setAssociatedObject(annotation, "model", model, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(annotation, "index", [NSNumber numberWithInt:index], OBJC_ASSOCIATION_ASSIGN);
        [self.mapView addAnnotation:annotation];
        index++;
    }
} 

#pragma mark - <MKMapViewDelegate>
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKAnnotationView   *myAnnotationView = (MKAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:ANNOTATION_ID];
    if (myAnnotationView == nil) {
        myAnnotationView = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:ANNOTATION_ID];
    }
    myAnnotationView.canShowCallout = YES;
    myAnnotationView.image=[UIImage imageNamed:@"ic_map_recommend"];
    myAnnotationView.frame=CGRectMake(0, 0, 21, 28);
    return myAnnotationView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    MKPointAnnotation * annotation=(MKPointAnnotation *)view.annotation;
    LocationModel * model=objc_getAssociatedObject(annotation, "model");
    if (self.currentView==nil) {
        self.currentView=view;
        view.image=[UIImage imageNamed:@"ic_map_recommend_pressed.png"];
        view.frame=CGRectMake(0, 0, 21, 28);
    } else if (self.currentView!=view) {
        self.currentView.selected=NO;
        self.currentView.image=[UIImage imageNamed:@"ic_map_recommend.png"];
        self.currentView.frame=CGRectMake(0, 0, 21, 28);
        self.currentView=view;
        self.currentView.selected=YES;
        view.image=[UIImage imageNamed:@"ic_map_recommend_pressed.png"];
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
