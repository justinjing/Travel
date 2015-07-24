//
//  MyCollectionViewCell.m
//  Travel
//
//  Created by Chinsyo on 15/6/8.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import "MyCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@implementation MyCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)updateCellViewWithModel:(GroupModel *)model
{
    [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:[UIImage imageNamed:@"zbg_p9_cover_def_mid_round_corner.9.png"]];
    self.nameLabel.text=model.name;
    self.totleThreadLabel.text=[NSString stringWithFormat:@"%@个主题",model.total_threads];
}

@end
