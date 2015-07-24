//
//  DestinationCollectionViewCell.m
//  Travel
//
//  Created by Chinsyo on 15/6/5.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import "DestinationCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@implementation DestinationCollectionViewCell

- (void)awakeFromNib {
   
}


- (void)updateCollectionViewCellWithModel:(DestinationModel *)model
{
    _countLabel.text=model.count;
    _countryNameLabel.text=model.cnname;
    _countryEnNameLabel.text=model.enname;
    [_cityImageView sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:[UIImage imageNamed:@"zbg_p9_cover_def_mid_round_corner.9.png"]
    ];
}

@end
