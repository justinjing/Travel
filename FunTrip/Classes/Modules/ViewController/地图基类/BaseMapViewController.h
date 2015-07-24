//
//  BaseMapViewController.h
//  Travel
//
//  Created by Chinsyo on 15/6/19.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "LocationModel.h"
#import <objc/message.h>
#import "CustomNavBarController.h"

#define ANNOTATION_ID  @"annotationId"
#define SCREEN_WIDTH self.view.frame.size.width
#define SCREEN_HEIGHT self.view.frame.size.height

@interface BaseMapViewController : CustomNavBarController

@property (nonatomic) NSMutableArray * dataArray;

@property (nonatomic) MKMapView * mapView;

@property (nonatomic) MKAnnotationView * currentView;

@end
