//
//  GroupDetailCell.m
//  Travel
//
//  Created by Chinsyo on 15/6/11.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import "GroupDetailCell.h"

@implementation GroupDetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)updateCellWithModel:(GroupDetailModel *)model
{
    self.titleLabel.text=model.title;
    self.viewsLabel.text=model.views;
    self.commentLabel.text=model.replys;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
