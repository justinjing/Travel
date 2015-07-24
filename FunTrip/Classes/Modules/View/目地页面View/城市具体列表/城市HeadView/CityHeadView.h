//
//  CityHeadView.h
//  Travel
//
//  Created by Chinsyo on 15/6/13.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityModel.h"

typedef void (^CircleClickBlockHandler)(NSString *category_id);

@interface CityHeadView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *cnnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ennameLabel;
@property (nonatomic, copy) CircleClickBlockHandler circleBlock;

- (void)updateUIWithModel:(CityModel *)model;

@end
