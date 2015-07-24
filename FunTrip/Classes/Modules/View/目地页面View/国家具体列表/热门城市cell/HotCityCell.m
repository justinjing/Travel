//
//  HotCityCell.m
//  Travel
//
//  Created by Chinsyo on 15/6/13.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import "HotCityCell.h"
#import "UIImageView+WebCache.h"

@implementation HotCityCell

- (void)awakeFromNib {
    self.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.layer.borderWidth=0.5;
}

- (void)updateCellUIWithModel:(DesHotCityModel *)model
{
    self.cnnameLabel.text=model.cnname;
    self.ennameLabel.text=model.enname;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:[UIImage imageNamed:@"zbg_p9_cover_def_mid_round_corner.9.png"]
    ];
}

@end
