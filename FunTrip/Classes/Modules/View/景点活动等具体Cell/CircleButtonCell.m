//
//  CircleButtonCell.m
//  Travel
//
//  Created by Chinsyo on 15/6/15.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import "CircleButtonCell.h"
#import "UIImageView+WebCache.h"

@implementation CircleButtonCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)initUIWithModel:(EntryModel *)model
{
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:[UIImage imageNamed:@"zbg_p9_cover_def_mid_round_corner.9.png"]];
    self.picImageView.layer.masksToBounds=YES;
    self.nameLabel.text=model.firstname;
    self.beentoCountLabel.text=model.beenstr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
