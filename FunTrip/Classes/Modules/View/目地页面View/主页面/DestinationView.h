//
//  DestinationView.h
//  Travel
//
//  Created by Chinsyo on 15/6/5.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DestinationModel;

typedef void (^ClickInCountryInDes)(DestinationModel * model);

@interface DestinationView : UIView

@property (nonatomic) NSArray * dataArray;

@property (nonatomic, copy) ClickInCountryInDes clickCountryBlock;

@end
