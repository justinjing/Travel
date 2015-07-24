//
//  RecommendTVCell.m
//  Travel
//
//  Created by Chinsyo on 15/6/11.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import "RecommendTVCell.h"
#import "UIImageView+WebCache.h"

@implementation RecommendTVCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)updateCellWithModel:(RecommendCellModel *)model
{
    [self.cellImageView sd_setImageWithURL:[NSURL URLWithString:model.photo]placeholderImage:[UIImage imageNamed:@"zbg_p9_cover_def_mid_round_corner.9.png"]];
    self.titleLabel.text=model.title;
    self.nameLabel.text=model.username;
    self.viewsLabel.text=[NSString stringWithFormat:@"%d",model.views];
    self.commentLabel.text=model.replys;
}

@end
