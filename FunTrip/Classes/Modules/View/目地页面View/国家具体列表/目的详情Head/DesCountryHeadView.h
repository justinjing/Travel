//
//  DesCountryHeadView.h
//  Travel
//
//  Created by Chinsyo on 15/6/13.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DesCountryModel.h"

@interface DesCountryHeadView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UILabel *cnnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ennameLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;

- (void)updateUIWithModel:(DesCountryModel *)model;

@end
