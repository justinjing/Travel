//
//  DestinationCollectionViewCell.h
//  Travel
//
//  Created by Chinsyo on 15/6/5.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DestinationModel.h"
@interface DestinationCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cityImageView;
@property (weak, nonatomic) IBOutlet UILabel *countryNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *countryEnNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

- (void)updateCollectionViewCellWithModel:(DestinationModel *)model;

@end
