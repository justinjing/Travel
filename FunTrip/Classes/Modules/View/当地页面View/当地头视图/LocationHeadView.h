//
//  LocationHeadView.h
//  Travel
//
//  Created by Chinsyo on 15/6/12.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationHeadModel.h"

@interface LocationHeadView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

- (void)updateHeadViewWithModel:(LocationHeadModel *)model;
- (CGFloat)getHeadHeightWithModel:(LocationHeadModel *)model width:(CGFloat)width;


@end
