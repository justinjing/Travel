//
//  MyAnnotationView.h
//  Travel
//
//  Created by Chinsyo on 15/6/16.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "CityMapModel.h"

@interface MyAnnotationView : MKAnnotationView

@property (nonatomic) CityMapModel * model;

@end
