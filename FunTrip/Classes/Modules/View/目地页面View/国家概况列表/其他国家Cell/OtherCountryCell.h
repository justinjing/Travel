//
//  OtherCountryCell.h
//  Travel
//
//  Created by Chinsyo on 15/6/6.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DestinationModel.h"

@interface OtherCountryCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *cnNameLabel;


- (void)updateCollectionViewCellWithModel:(DestinationModel *)model;

@end
