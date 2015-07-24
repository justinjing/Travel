//
//  LocalColoringView.m
//  Travel
//
//  Created by Chinsyo on 15/6/4.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import "LocalColoringView.h"
#import "UIImageView+WebCache.h"
@implementation LocalColoringView

- (void)awakeFromNib
{
    self.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.layer.borderWidth=0.5;
    self.headOfWriterImageView.layer.borderColor=[UIColor whiteColor].CGColor;
}

- (void)updateUIWithRecommendModel:(LocalModel *)model
{
    
    [self.MainImageView sd_setImageWithURL:[NSURL URLWithString:model.photo]];
    [self.headOfWriterImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"zbg_p9_cover_def_mid_round_corner.9.png"]];
    self.writerLabel.text=model.username;
    self.titleLabel.text=model.title;
}

@end
