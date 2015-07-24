//
//  OtherCountryCell.m
//  Travel
//
//  Created by Chinsyo on 15/6/6.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import "OtherCountryCell.h"

@implementation OtherCountryCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)updateCollectionViewCellWithModel:(DestinationModel *)model
{
    _nameLabel.text=model.cnname;
    _cnNameLabel.text=model.enname;
}

@end
